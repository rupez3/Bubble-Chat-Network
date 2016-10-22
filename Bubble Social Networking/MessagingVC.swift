//
//  MessagingVC.swift
//  Bubble Social Networking
//
//  Created by Chhetri, Rupesh (Contractor) on 10/20/16.
//  Copyright © 2016 RupeshChhetri. All rights reserved.
//

import UIKit
import FirebaseAuth
import SwiftKeychainWrapper

class MessagingVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

    }

    override func viewWillAppear(_ animated: Bool) {

    }
    
    @IBAction func logoutAction(_ sender: UIButton) {
        
        KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        do {
            try FIRAuth.auth()?.signOut()
        } catch {
            }
        self.performSegue(withIdentifier: "goToLogin", sender: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
