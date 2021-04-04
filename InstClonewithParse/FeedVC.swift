//
//  FeedVC.swift
//  InstClonewithParse
//
//  Created by mesutAygun on 3.04.2021.
//

import UIKit
import Parse

class FeedVC: UIViewController, UITableViewDelegate , UITableViewDataSource {
    
    var postOwnerArray = [String]()
    var postCommentArray = [String]()
    var postImageArray = [PFFileObject]()
    var postUUIDArray = [String]()

    
    @IBOutlet weak var tableView: UITableView!
    
    //parseda ne kadar postOwner varsa yani ne kadar kayit edilmisse o kadar row olustur
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postOwnerArray.count
    }
    
    //rowlar icinde ne olacagini hangi indexe gidecegini belirle
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! feedCell
        cell.usernameLabel.text = postOwnerArray[indexPath.row]
        cell.postCommentLabel.text = postCommentArray[indexPath.row]
        cell.uuidlabel.text = postUUIDArray[indexPath.row]
        postImageArray[indexPath.row].getDataInBackground { (data, error) in
            if error != nil {
                self.makeAlert(titleInput: "error", messageInput: error?.localizedDescription ?? "error")
            }else{
                cell.postImage.image = UIImage(data: data!)
            }
        }
        return cell
    }
    
    //notification gozlemleyici uploadda degisiklik oldugu zaman algilar
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(FeedVC.getData), name: NSNotification.Name?(NSNotification.Name(rawValue: "newPost")), object: nil)
    }
    
    //parsedan verileri ceker dizilere kaydeder
    
    @objc func getData(){
        let query = PFQuery(className: "Posts")
        query.addDescendingOrder("createdAt")
        query.findObjectsInBackground { (objects, error) in
            if error != nil {
                self.makeAlert(titleInput: "error", messageInput: error?.localizedDescription  ?? "error")
                } else{
                    if objects!.count > 0 {
                        self.postOwnerArray.removeAll(keepingCapacity: false)
                        self.postCommentArray.removeAll(keepingCapacity: false)
                        self.postUUIDArray.removeAll(keepingCapacity: false)
                        self.postImageArray.removeAll(keepingCapacity: false)
                        
                        for object in objects! {
                            self.postOwnerArray.append(object.object(forKey: "postOwner") as! String)
                            self.postCommentArray.append(object.object(forKey: "postComment") as! String)
                            self.postUUIDArray.append(object.object(forKey: "postuuid") as! String)
                            self.postImageArray.append(object.object(forKey: "posImage") as! PFFileObject)
                            
                            
                        }
                    }
                    self.tableView.reloadData()
                }
        }
        
        
    }
    
    func makeAlert(titleInput : String , messageInput : String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        getData()
    }
}
