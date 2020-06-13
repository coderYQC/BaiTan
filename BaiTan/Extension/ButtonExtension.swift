//
//  ButtonExtension.swift
//  LynxIOS
//
//  Created by 秦英乔 on 2018/5/24.
//  Copyright © 2018年 叶波. All rights reserved.
//

import UIKit

class ItemLeftButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        let Offset: CGFloat = 15
        titleLabel?.sizeToFit()
        titleLabel?.frame = CGRect(x: -Offset, y: height - 15, width: width - Offset, height: (titleLabel?.height)!)
 
        titleLabel?.textAlignment = .center
        imageView?.frame = CGRect(x: -Offset, y: 0, width: width - Offset, height: height - 15)
        
        imageView?.contentMode = .center
    }
}

class ItemRightButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        let Offset: CGFloat = 15
        titleLabel?.sizeToFit()
        titleLabel?.frame = CGRect(x: Offset, y: height - 15, width: width + Offset, height: (titleLabel?.height)!)
        titleLabel?.textAlignment = .center
        imageView?.frame = CGRect(x: Offset, y: 0, width: width + Offset, height: height - 15)
        imageView?.contentMode = UIViewContentMode.center
    }
    
}

