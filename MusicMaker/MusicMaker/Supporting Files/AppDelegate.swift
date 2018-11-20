//
//  AppDelegate.swift
//  MusicMaker
//
//  Created by Vuk Radosavljevic on 11/6/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
    
    // MARK: - GIDSignInDelegate
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            NSLog("Error signing in with google : \(error)")
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        
        Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
            if let error = error {
                print(error)
                return
            }
            let storyboard = UIStoryboard(name: "Teachers", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "ContainerViewController") as? ContainerViewController
            self.window?.rootViewController = vc
        }
        
    }
    

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        GIDSignIn.sharedInstance()?.clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance()?.delegate = self
        
        let db = Firestore.firestore()
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
        setRootViewController()
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String, annotation: [:])
    }

  
    //If the user is already logged in, set the root view controller to the students' teachers view controller
    private func setRootViewController() {
        if Auth.auth().currentUser != nil {
            let storyboard = UIStoryboard(name: "Teachers", bundle: nil)
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "ContainerViewController")
            self.window?.rootViewController = initialViewController
        }
    }


}

