//
//  SettingsVC.swift
//  InstClonewithParse
//
//  Created by mesutAygun on 3.04.2021.
//

import UIKit
import Parse

class SettingsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func logOutClicked(_ sender: Any) {
        
        
        PFUser.logOutInBackground { (error) in
            if error == nil {
                self.performSegue(withIdentifier: "toSignInVC", sender: nil)
            }
        }
        
        
    }
}
