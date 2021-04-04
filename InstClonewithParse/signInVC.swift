//
//  ViewController.swift
//  InstClonewithParse
//
//  Created by mesutAygun on 3.04.2021.
//

import UIKit
import Parse

class signInVC: UIViewController {
    @IBOutlet weak var usernameText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func signInClicked(_ sender: Any) {
        
        if usernameText.text != "" && passwordText.text != "" {
            
            PFUser.logInWithUsername(inBackground: usernameText.text!, password: passwordText.text!) { (user, error) in
                if error != nil {
                    self.makeAlert(titleInput: "ERROR", messageInput: error?.localizedDescription ?? "error")
                }else{
                    //segue
                    
                    self.performSegue(withIdentifier: "toTabBarVC", sender: nil)
                }
            }
        }else {
            makeAlert(titleInput: "ERROR", messageInput: "please try again")
        }
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
        
        let user = PFUser()
        user.username = usernameText.text!
        user.password = passwordText.text!
        
        user.signUpInBackground { (success, error) in
            if error != nil {
                self.makeAlert(titleInput: "ERROR", messageInput: error?.localizedDescription ?? "error")
                
            }else {
                //segue
                self.performSegue(withIdentifier: "toTabBarVC", sender: nil)
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

