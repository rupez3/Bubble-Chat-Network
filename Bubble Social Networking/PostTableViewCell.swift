//
//  PostTableViewCell.swift
//  Bubble Social Networking
//
//  Created by Chhetri, Rupesh (Contractor) on 10/24/16.
//  Copyright © 2016 RupeshChhetri. All rights reserved.
//

import UIKit

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

    func configCell(post: PostModel) {
        self.post = post
        self.caption.text = post.caption
        self.likesLabel.text = "\(post.likes)"
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
