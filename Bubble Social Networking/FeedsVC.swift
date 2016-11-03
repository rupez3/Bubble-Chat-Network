//
//  FeedsVC.swift
//  Bubble Social Networking
//
//  Created by Chhetri, Rupesh (Contractor) on 10/20/16.
//  Copyright © 2016 RupeshChhetri. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase

class FeedsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var posts = [PostModel]()
    
    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
        
        ///Listener
        DataService.ds.REF_POSTS.observe(.value, with: {(snapshot) in
            //print(snapshot.value)
            if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshots {
                    print(snap)
                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let post = PostModel(postKey: key, postData: postDict)
                        self.posts.append(post)
                    }
                }
            }
            self.myTableView.reloadData()
        })
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
//        self.tabBarController?.navigationItem.hidesBackButton = true
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let post = posts[indexPath.row]
        print(post)
        if let cell = tableView.dequeueReusableCell(withIdentifier: "postCell") as? PostTableViewCell {
            cell.configCell(post: post)
            return cell
        } else {
            return PostTableViewCell()
        }
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
