
//
//  UIButton+ImageTitleSpacing.swift
//  LynxIOS
//
//  Created by 严群超 on 2018/10/16.
//  Copyright © 2018年 Global Hengtong (Beijing) Technology Co., Ltd. All rights reserved.
//

import UIKit

enum ButtonEdgeInsetsStyle: Int {
    case left = 0
    case right = 1
    case top = 2
    case bottom = 3
}

extension UIButton{
    
    func layoutButton(edgeInsetsStyle:ButtonEdgeInsetsStyle,imageTitleSpace:CGFloat,fitSize:Bool = false) {
        let imageWidth:CGFloat = (self.imageView?.width)!
        let imageHeight:CGFloat = (self.imageView?.height)!
        var labelWidth:CGFloat = 0.0
        var labelHeight:CGFloat = 0.0
  
        if #available(iOS 8, *) {
            labelWidth = (self.titleLabel?.intrinsicContentSize.width)!
            labelHeight = (self.titleLabel?.intrinsicContentSize.height)!
        }else {
            labelWidth = (self.titleLabel?.width)!
            labelHeight = (self.titleLabel?.height)!
        }
        
        var imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        var labelEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        switch edgeInsetsStyle {
        case .top:
            imageEdgeInsets = UIEdgeInsets(top: -labelHeight - imageTitleSpace * 0.5, left: 0, bottom: 0, right: -labelWidth)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth, bottom: -imageHeight - imageTitleSpace * 0.5, right: 0)
            break
        case .left:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: -imageTitleSpace * 0.5, bottom: 0, right: imageTitleSpace * 0.5)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: imageTitleSpace * 0.5, bottom: 0, right: -imageTitleSpace * 0.5)
            break
        case .bottom:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -labelHeight - imageTitleSpace * 0.5, right: -labelWidth)
            labelEdgeInsets = UIEdgeInsets(top: -imageHeight - imageTitleSpace * 0.5, left: -imageWidth, bottom: 0, right: 0)
            break
        default:
            imageEdgeInsets = UIEdgeInsets(top: 0, left:labelWidth + imageTitleSpace * 0.5, bottom: 0, right: -labelWidth - imageTitleSpace * 0.5)
            labelEdgeInsets = UIEdgeInsets(top: 0, left:-imageWidth - imageTitleSpace * 0.5, bottom: 0, right: imageWidth + imageTitleSpace * 0.5)
            break
        }
        self.titleEdgeInsets = labelEdgeInsets
        self.imageEdgeInsets = imageEdgeInsets
        
        if fitSize == true {
            self.width = labelWidth + labelHeight + imageTitleSpace
        }
    }
    
   
}
