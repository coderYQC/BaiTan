//
//  BarButtomItenExtension.swift
//  LynxIOS
//
//  Created by 严群超 on 2018/7/17.
//  Copyright © 2018年 叶波. All rights reserved.
//

enum ItemButtonType: Int {
    case Left = 0
    case Right = 1
    case Normal = 2
}
import UIKit

extension UIBarButtonItem {
    class func barButton(title: String, titleColor: UIColor, image: UIImage, hightLightImage: UIImage?, target: AnyObject?, action: Selector, type: ItemButtonType) -> UIBarButtonItem {
        var btn:UIButton = UIButton()
        if type == ItemButtonType.Left {
            btn = ItemLeftButton(type: .custom)
        } else {
            btn = ItemRightButton(type: .custom)
        }
        btn.setTitle(title, for: .normal)
        btn.setImage(image, for: .normal)
        btn.setTitleColor(titleColor, for: .normal)
        btn.setImage(hightLightImage, for: .highlighted)
        btn.addTarget(target, action: action, for: .touchUpInside)
        btn.frame = CGRect(x: 0, y: 0, width: 60, height: 44)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        return UIBarButtonItem(customView: btn)
    }
    
    class func barButton(type: ItemButtonType,image: UIImage, target: AnyObject?, action: Selector) -> UIBarButtonItem {
        
        return UIBarButtonItem(customView: getBarButton(type: type, image: image, target: target, action: action))
    }
    
    class func homeLeftBarButton(type: ItemButtonType,image: UIImage, target: AnyObject?, action: Selector) -> UIBarButtonItem {
        
        let contentView = UIView.init(frame: CGRect(x: 0, y: 0, width: 59, height: 44))
        let locationimage = UIImageView.init(frame: CGRect(x: 0, y: 14.5, width: 15, height: 15))
        locationimage.image = UIImage.init(named: "")
        let locBtn = getBarButton(type: type, image: image, target: target, action: action)
        contentView.addSubview(locationimage)
        contentView.addSubview(locBtn)
        return UIBarButtonItem(customView:contentView)
    }
    
    fileprivate class func getBarButton(type: ItemButtonType,image: UIImage, target: AnyObject?, action: Selector) -> UIButton {
      
        let btn = UIButton(type: .custom)
        btn.setImage(image, for: .normal)
        btn.imageView?.contentMode = UIViewContentMode.center
        JPrint(msg: image.size.width)
        
        btn.frame = CGRect(x: 0, y: 0, width: 56, height: 44)
        if type == .Left {
            btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 30)
        }else if type == .Right{
            btn.imageEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 0)
        }else {
        }
        btn.addTarget(target, action: action, for: UIControlEvents.touchUpInside)
        return btn
    }
    
    
    
    class func barButton(title: String, titleColor: UIColor, target: AnyObject?, action: Selector) -> UIBarButtonItem {
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 65, height: 44))
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(titleColor, for: .normal)
        btn.addTarget(target, action: action, for: UIControlEvents.touchUpInside)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        if title.count == 2 {
            btn.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -25)
        }
        return UIBarButtonItem(customView: btn)
    }
}

