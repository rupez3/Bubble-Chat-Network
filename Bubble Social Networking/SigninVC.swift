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
import SwiftKeychainWrapper

class SigninVC: UIViewController {

    @IBOutlet weak var emailField: CustomTextField!
    @IBOutlet weak var passwordField: CustomTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.passwordField.isSecureTextEntry = true
//        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        ///If the user is already logged in before
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID) {
            performSegue(withIdentifier: "goToFeed", sender: self)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func facebookAction(_ sender: UIButton) {
        
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
    
    @IBAction func signInAction(_ sender: UIButton) {
        
        if let email = emailField.text, let pwd = passwordField.text {
            FIRAuth.auth()?.signIn(withEmail: email, password: pwd, completion: { (user, error) in
                if error == nil {
                    print("rkc: firebase login with email successful")
                    if let user = user {
                        self.completeSignIn(id: user.uid)
                    }
                    
                } else {
                    FIRAuth.auth()?.createUser(withEmail: email, password: pwd, completion: { (user, error) in
                        if error != nil {
                            print("rkc: firebase email login failed")
                        } else {
                            print("rkc: firebase email account created")
                            if let user = user {
                                self.completeSignIn(id: user.uid)
                            }
                        }
                    })
                }
            })
        }
    }
    
    func firebaseAuth(_ credential: FIRAuthCredential) {
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil {
                print("rkc: Firebase Auhentication Failed")
            } else {
                print("rkc: Firebase Authenication Successful")
                if let user = user {
                    self.completeSignIn(id: user.uid)
                }
            }
        })
    }
    
    func completeSignIn(id: String) {
        KeychainWrapper.standard.set(id, forKey: KEY_UID)
        
        performSegue(withIdentifier: "goToFeed", sender: self)
    }

}

