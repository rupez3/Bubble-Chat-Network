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

class FeedsVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var addCaption: CustomTextField!
    
    @IBOutlet weak var addImageOutlet: CircleImageView!
    var imagePicker: UIImagePickerController!
    var posts = [PostModel]()
    var imageSelected = false
    
    static var imageCache: NSCache<NSString, UIImage> = NSCache()
    
    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
        
        //image picker intializer
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
        ///Listener
        DataService.ds.REF_POSTS.observe(.value, with: {(snapshot) in
            //print(snapshot.value)
            self.posts = []
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
            
            if let img = FeedsVC.imageCache.object(forKey: post.imageUrl as NSString) {
                cell.configCell(post: post, image: img)
                return cell
            } else {
                cell.configCell(post: post)
                return cell
            }
            
        } else {
            return PostTableViewCell()
        }
    }
    
    @IBAction func logoutAction(_ sender: AnyObject) {
        
        KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        
        try! FIRAuth.auth()?.signOut()
        
        self.performSegue(withIdentifier: "GoToSignInVC", sender: nil)
    }

    ///IMAGE PICKER
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            addImageOutlet.image = image
            imageSelected = true
        } else {
            print("rkc: image wasn't selected")
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addImageAction(_ sender: AnyObject) {
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func postButton(_ sender: AnyObject) {
        guard let caption = addCaption.text, caption != "" else {
            print("rkc: need to enter caption")
            return
        }
        guard let image = addImageOutlet.image, imageSelected == true else {
            print("rkc: need to enter image")
            return
        }
        //converting image into imagedata
        if let imageData = UIImageJPEGRepresentation(image, 0.2) {
            
            let imageUid = NSUUID().uuidString
            let metaData = FIRStorageMetadata()
            metaData.contentType = "image/jpeg"
            
            DataService.ds.REF_POST_IMAGES.child(imageUid).put(imageData, metadata: metaData, completion: { (metaData, error) in
                if error != nil {
                    print("rkc: unable to upload image")
                } else {
                    print("rkc: image was successfully uploaded to firebase")
                    let downloadUrl = metaData?.downloadURL()?.absoluteString
                    if let url = downloadUrl {
                        self.postToFirebase(imageUrl: url)
                    }
                }
            })
        }
    }
    
    func postToFirebase(imageUrl: String) {
        let post: Dictionary<String, AnyObject> = [
            "caption": addCaption.text! as AnyObject,
            "imageUrl": imageUrl as AnyObject,
            "likes": 0 as AnyObject
        ]
        let firebasePost = DataService.ds.REF_POSTS.childByAutoId()
        firebasePost.setValue(post)
        
        addCaption.text = ""
        imageSelected = false
        addImageOutlet.image = UIImage(named: "add-image")
        
        myTableView.reloadData()
    }
    
    ////Temp code
    //This is for the keyboard to GO AWAYY !! when user clicks anywhere on the view
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    //This is for the keyboard to GO AWAYY !! when user clicks "Return" key  on the keyboard
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        addCaption.resignFirstResponder()
        return true
    }
}
