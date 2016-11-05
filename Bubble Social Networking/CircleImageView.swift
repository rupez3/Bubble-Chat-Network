//
//  CircleImageView.swift
//  Bubble Social Networking
//
//  Created by Chhetri, Rupesh (Contractor) on 10/23/16.
//  Copyright © 2016 RupeshChhetri. All rights reserved.
//

import UIKit

class CircleImageView: UIImageView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.shadowColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 0.6).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }
    
//    override func draw(_ rect: CGRect) {
//        super.draw(rect)
//        layer.cornerRadius = self.frame.width / 2
//    }
}
