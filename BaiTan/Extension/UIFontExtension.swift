
//
//  UIFontExtension.swift
//  LynxIOS
//
//  Created by yanqunchao on 2019/7/12.
//  Copyright © 2019 Global Hengtong (Beijing) Technology Co., Ltd. All rights reserved.
//

import UIKit
extension UIFont {
    // 可以通过let names = UIFont.fontNames(forFamilyName: "PingFang SC") 来遍历所有PingFang 的字体名字 iOS9.0 以后支持
    /*
     PingFangSC-Medium
     PingFangSC-Semibold
     PingFangSC-Light
     PingFangSC-Ultralight
     PingFangSC-Regular
     PingFangSC-Thin
     */
    
    public static func pingFangRegular(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "PingFangSC-Regular", size: size) else {
            return UIFont.systemFont(ofSize: size)
        }
        return font
    }
    
    public static func pingFangMedium(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "PingFangSC-Medium", size: size) else {
            return UIFont.systemFont(ofSize: size)
        }
        return font
    }
    
    public static func pingFangSemibold(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "PingFangSC-Semibold", size: size) else {
            return UIFont.systemFont(ofSize: size)
        }
        return font
    }
    
    public static func DINAlternateBold(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "Georgia", size: size) else {
            return UIFont.systemFont(ofSize: size)
        }
        return font
    }
}
