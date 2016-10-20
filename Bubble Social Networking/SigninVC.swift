//
//  SigninVC.swift
//  Bubble Social Networking
//
//  Created by Rupesh  on 10/17/16.
//  Copyright © 2016 RupeshChhetri. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit

class SigninVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func facebookAction(_ sender: AnyObject) {
        
        let fbLogin = FBSDKLoginManager()
        fbLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                print("rkc: failed to authenticate, \(error)")
            } else if result?.isCancelled == true {
                print("rkc: user cancelled Facebook authernication")
            } else {
                print("rkc: Facebook authentication successful")
                
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                
                self.firebaseAuth(credential)
            }
        }
    }
    
    func firebaseAuth(_ credential: FIRAuthCredential) {
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil {
                print("rkc: Firebase Auhentication Failed")
            } else {
                print("rkc: Firebase Authenication Successful")
            }
        })
    }

}

