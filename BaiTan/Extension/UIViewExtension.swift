//
//  UIViewExtension.swift
//  LynxIOS
//
//  Created by 叶波 on 2018/5/7.
//  Copyright © 2018年 叶波. All rights reserved.
//

import UIKit

extension UIView {
    
    //加载xib文件
    public class func viewFromXib() -> UIView? {
        return Bundle.main.loadNibNamed("\(self)", owner: nil, options: nil)?.last as? UIView ?? nil
    }
    
    static var resuableID: String {
        get {
            return "\(self)"
        }
    }
    
    public class func getResuableID()-> String {
        return "\(self)"
    }
    
    public class func getNibPath()-> String? {
        let bundle = Bundle.main.path(forResource: "\(self)", ofType: "nib")
        return bundle
    }
    
    public func removeAllSubviews() {
        for subview in self.subviews {
            subview.removeFromSuperview()
        }
    }
    
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue > 0 ? newValue : 0
        }
    }
    
    @IBInspectable var borderColor: UIColor {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
    
    // MARK: - 常用位置属性
    public var left:CGFloat {
        get {
            return self.frame.origin.x
        }
        set(newLeft) {
            var frame = self.frame
            frame.origin.x = newLeft
            self.frame = frame
        }
    }
    
    public var top:CGFloat {
        get {
            return self.frame.origin.y
        }
        
        set(newTop) {
            var frame = self.frame
            frame.origin.y = newTop
            self.frame = frame
        }
    }
    
    public var width:CGFloat {
        get {
            return self.frame.size.width
        }
        
        set(newWidth) {
            var frame = self.frame
            frame.size.width = newWidth
            self.frame = frame
        }
    }
    
    public var height:CGFloat {
        get {
            return self.frame.size.height
        }
        
        set(newHeight) {
            var frame = self.frame
            frame.size.height = newHeight
            self.frame = frame
        }
    }
    
    public var right:CGFloat {
        get {
            return self.left + self.width
        }
        set(newLeft) {
            var frame = self.frame
            frame.origin.x += frame.width
            self.frame = frame
        }
    }
    
    public var bottom:CGFloat {
        get {
            return self.top + self.height
        }
        set(newLeft) {
            var frame = self.frame
            frame.origin.y += frame.height
            self.frame = frame
        }
    }
    
    public var centerX:CGFloat {
        get {
            return self.center.x
        }
        
        set(newCenterX) {
            var center = self.center
            center.x = newCenterX
            self.center = center
        }
    }
    
    public var centerY:CGFloat {
        get {
            return self.center.y
        }
        
        set(newCenterY) {
            var center = self.center
            center.y = newCenterY
            self.center = center
        }
    }
    public var size:CGSize {
        get {
            return self.frame.size
        }
        set(newSize) {
            var frame = self.frame
            frame.size = newSize
            self.frame = frame
        }
    }
    func setShadowColor(shadowColor:UIColor = UIColor.lightGray) {
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowOpacity = 0.6
        self.layer.shadowColor = shadowColor.cgColor
    }
}
