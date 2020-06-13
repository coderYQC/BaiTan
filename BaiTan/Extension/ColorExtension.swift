//
//  ColorExtension.swift
//  LynxIOS
//
//  Created by wangbin on 2018/10/22.
//  Copyright © 2018年 wangbin. All rights reserved.
//

//颜色宏封装
import UIKit

extension UIColor {
    class func colorFromRGB(_ rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    class func rgb(r:CGFloat,g:CGFloat,b:CGFloat)->UIColor{
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1)
    }
    class func randomColor() -> UIColor {
        return  rgb(r: CGFloat(arc4random_uniform(256)), g: CGFloat(arc4random_uniform(256)), b: CGFloat(arc4random_uniform(256)))
    }
}
