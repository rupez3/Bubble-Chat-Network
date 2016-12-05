//
//  PostTableViewCell.swift
//  Bubble Social Networking
//
//  Created by Chhetri, Rupesh (Contractor) on 10/24/16.
//  Copyright © 2016 RupeshChhetri. All rights reserved.
//

import UIKit
import Firebase

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImage: CircleImageView!
    @IBOutlet weak var profileNameLbl: UILabel!
    @IBOutlet weak var likeImage: UIImageView!
    @IBOutlet weak var postedImage: UIImageView!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var caption: UITextView!
    
    var post: PostModel!
    var likesRef : FIRDatabaseReference!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.caption.isEditable = false
        
        let likeTap = UITapGestureRecognizer(target: self, action: #selector(likeImageTapped))
        likeTap.numberOfTapsRequired = 1
        likeImage.addGestureRecognizer(likeTap)
        likeImage.isUserInteractionEnabled = true
    }

    func configCell(post: PostModel, image: UIImage? = nil) {
        self.post = post
        likesRef = DataService.ds.REF_USER_CURRENT.child("likes").child(post.postKey)
        self.caption.text = post.caption
        self.likesLabel.text = "\(post.likes)"
        
        if image != nil {
            self.postedImage.image = image
        } else {
            let ref = FIRStorage.storage().reference(forURL: post.imageUrl)
            ref.data(withMaxSize: 2 * 1024 * 1024, completion: { (data, error) in
                if error != nil {
                    print("rkc: unable to download image frmo firbase storage")
                } else {
                    print("rkc: image was downloaded")
                    if let imageData = data {
                        if let image = UIImage(data: imageData) {
                            self.postedImage.image = image
                            FeedsVC.imageCache.setObject(image, forKey: post.imageUrl as NSString)
                        }
                    }
                }
            })
            
        }

        likesRef.observeSingleEvent(of: .value, with: { (snapshot) in
            if let _ = snapshot.value as? NSNull {
                self.likeImage.image = UIImage(named: "empty-heart")
            } else {
                self.likeImage.image = UIImage(named: "filled-heart")
            }
        })
        
    }
    
    func likeImageTapped(sender: UITapGestureRecognizer) {
        
        likesRef.observeSingleEvent(of: .value, with: { (snapshot) in
            if let _ = snapshot.value as? NSNull {
                self.likeImage.image = UIImage(named: "filled-heart")
                self.post.adjustLikes(addLike: true)
                self.likesRef.setValue(true)
            } else {
                self.likeImage.image = UIImage(named: "empty-heart")
                self.post.adjustLikes(addLike: false)
                self.likesRef.removeValue()
            }
        })
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
