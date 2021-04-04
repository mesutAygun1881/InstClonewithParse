//
//  feedCell.swift
//  InstClonewithParse
//
//  Created by mesutAygun on 4.04.2021.
//

import UIKit
import Parse

class feedCell: UITableViewCell {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var uuidlabel: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var postCommentLabel: UILabel!
    @IBOutlet weak var likeSayac: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        uuidlabel.isHidden = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
  
        // Configure the view for the selected state
    }

    @IBAction func likeButtonClicked(_ sender: Any) {
        let likeObject = PFObject(className: "LIKES")
        likeObject["from"] = PFUser.current()?.username
        likeObject["to"] = uuidlabel.text
        likeObject.saveInBackground { (success, error) in
            if error != nil {
                print ("error")
                
            }else {
                print("saved")
            
            }
        }
    }
    @IBAction func commentClicked(_ sender: Any) {
        let commentObject = PFObject(className: "COMMENTS")
        commentObject["from"] = PFUser.current()?.username
        commentObject["to"] = uuidlabel.text
        commentObject.saveInBackground { (success, error) in
            if error != nil {
                print ("error")
                
            }else {
                print("saved")
            }
    }
}
}
