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
    @IBOutlet weak var postedImage: UIImageView!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var caption: UITextView!
    
    var post: PostModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configCell(post: PostModel, image: UIImage? = nil) {
        self.post = post
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
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
