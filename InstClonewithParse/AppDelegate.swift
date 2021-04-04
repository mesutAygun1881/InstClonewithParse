//
//  AppDelegate.swift
//  InstClonewithParse
//
//  Created by mesutAygun on 3.04.2021.
//

import UIKit
import Parse

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let configuration = ParseClientConfiguration { (ParseMutableClientConfiguration)  in
            
            ParseMutableClientConfiguration.applicationId =   "Tyj3jRUsBklOatVc1sR63EZ9bXYBCvWNf3OUAutB"
            ParseMutableClientConfiguration.clientKey =  "gbp5PccDbvNBFXPZ4jvZWiakIfvaX6R5jHMBJnD6"
            ParseMutableClientConfiguration.server =  "https://parseapi.back4app.com/"
            
            
            
        }
        
        Parse.initialize(with: configuration)
        
        let defaultACL = PFACL()
        defaultACL.hasPublicReadAccess = true
        defaultACL.hasPublicWriteAccess = true
        PFACL.setDefault(defaultACL, withAccessForCurrentUser: true)
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

