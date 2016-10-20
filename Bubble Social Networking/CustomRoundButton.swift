//
//  CustomRoundButton.swift
//  Bubble Social Networking
//
//  Created by Rupesh  on 10/19/16.
//  Copyright © 2016 RupeshChhetri. All rights reserved.
//

import UIKit

class CustomRoundButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.shadowColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 0.6).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        imageView?.contentMode = .scaleAspectFit

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.clipsToBounds = true
        layer.cornerRadius = self.frame.size.width / 2
//        layer.cornerRadius = 0.5 * layer.bounds.size.width
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
