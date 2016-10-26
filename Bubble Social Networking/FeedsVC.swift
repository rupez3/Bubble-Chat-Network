//
//  FeedsVC.swift
//  Bubble Social Networking
//
//  Created by Chhetri, Rupesh (Contractor) on 10/20/16.
//  Copyright © 2016 RupeshChhetri. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import FirebaseAuth

class FeedsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
//        self.tabBarController?.navigationItem.hidesBackButton = true
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return myTableView.dequeueReusableCell(withIdentifier: "postCell") as! PostTableViewCell
    }
    
//    @IBAction func logoutAction(_ sender: AnyObject) {
//        
//        KeychainWrapper.standard.removeObject(forKey: KEY_UID)
//        
//        try! FIRAuth.auth()?.signOut()
//        
//        self.performSegue(withIdentifier: "goToLogin", sender: nil)
//    }

    
}
