//
//  UIImageViewExtension.swift
//  LynxIOS
//
//  Created by yanqunchao on 2020/3/2.
//  Copyright © 2020 Global Hengtong (Beijing) Technology Co., Ltd. All rights reserved.
//

import Foundation
import Kingfisher
extension UIImageView {
    
    func kfImage(_ imageUrlStr:String, placeholder:String = "default") {
        self.kf.setImage(with: URL(string:imageUrlStr), placeholder: UIImage(named: placeholder))
    }
}
