//
//  UploadVC.swift
//  InstClonewithParse
//
//  Created by mesutAygun on 3.04.2021.
//

import UIKit
import Parse

class UploadVC: UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate {

    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var postCommentText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        postButton.isEnabled = false
        postImage.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        postImage.addGestureRecognizer(gestureRecognizer)
        
        let keyboardRecognizer = UITapGestureRecognizer(target: self, action: #selector(UploadVC.hideKeyboard))
        self.view.addGestureRecognizer(keyboardRecognizer)
    }

    @objc func hideKeyboard () {
        
        self.view.endEditing(true)
    }
    
    //telefon kutuphanesinden resim cekme
    
    @objc func selectImage(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    //resim sectikten sonra otomatik kapatma dismiss
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        postImage.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
        postButton.isEnabled = true
    }

    //parse kayit islemi 
   
    @IBAction func postClicked(_ sender: Any) {
        postButton.isEnabled = false
        
        let object = PFObject(className: "Posts")
        let like = PFObject(className: "likes") //likes olusturmadik
        
        //IMAGE KAYDETME
        
        let data = postImage.image?.jpegData(compressionQuality: 0.5)
        let pfImage = PFFileObject(name:  "image" , data: data!)
        let uuid = UUID().uuidString
        let uuidPost = ("\(uuid)\(PFUser.current()?.username!)")
        
        
        
        
        object["postComment"] = postCommentText.text!
        object["postOwner"] = PFUser.current()!.username
        object["posImage"] = pfImage
        object["postuuid"] = uuidPost
        
        object.saveInBackground { (success, error) in
            if error != nil {
                self.makeAlert(titleInput: "error", messageInput: error?.localizedDescription ?? "error")
                
            }else {
                self.postCommentText.text = ""
                self.tabBarController?.selectedIndex = 0
                self.postImage.image = UIImage(named: "select.png")
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newPost"), object: nil)
            }
        }
        
        
        
        
        
        
    }
    func makeAlert(titleInput : String , messageInput : String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
        
    }
    
}
