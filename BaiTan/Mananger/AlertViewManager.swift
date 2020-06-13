
//
//  AlertViewManager.swift
//  LynxIOS
//
//  Created by 严群超 on 2018/7/25.
//  Copyright © 2018年 叶波. All rights reserved.
//

//UIAlertController封装
import UIKit
import SVProgressHUD
class AlertViewManager: NSObject,UITextFieldDelegate {
    var tfContent = ""
    class func showAlertView(message:String,viewController: UIViewController = UtilTool.topViewController()) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(
            UIAlertAction(title: "确认", style: .default, handler: { (action) in
            }))
        viewController.present(alert, animated: true, completion: nil)
    }
    
    class func showAlertView(message:String,viewController: UIViewController = UtilTool.topViewController(),handler: @escaping ()->()) {
        let alert = UIAlertController(title: "提示", message: message, preferredStyle: .alert)
        alert.addAction(
            UIAlertAction(title: "确认", style: .default, handler: { (action) in
                handler()
            }))
        viewController.present(alert, animated: true, completion: nil)
    }
    
    class func showAlertView(title: String?, message:String,confirmTitle: String = "确认", viewController: UIViewController = UtilTool.topViewController(),handler: @escaping ()->()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(
            UIAlertAction(title: confirmTitle, style: .default, handler: { (action) in
                handler()
            }))
        UtilTool.topViewController().present(alert, animated: true, completion: nil)
    }
    
    class func showAlertView(title: String, message:String, cancelTitle:String, confirmTitle: String,viewController: UIViewController = UtilTool.topViewController(),handler: @escaping ()->(),cancelHandler:@escaping ()->()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(
            UIAlertAction(title: cancelTitle, style: .default, handler: { (action) in
                cancelHandler()
            }))
        alert.addAction(
            UIAlertAction(title: confirmTitle, style: .default, handler: { (action) in
                handler()
            }))
        viewController.present(alert, animated: true, completion: nil)
    }
    
    class func showDefaultAlertView(message:String,viewController: UIViewController = UtilTool.topViewController(),handler: @escaping ()->()) {
        let alert = UIAlertController(title: "提示", message: message, preferredStyle: .alert)
        alert.addAction(
            UIAlertAction(title: "取消", style: .default, handler: { (action) in
            }))
        alert.addAction(
            UIAlertAction(title: "确认", style: .default, handler: { (action) in
                handler()
            }))
        viewController.present(alert, animated: true, completion: nil)
    }
    
    
    class func showDefaultAlertView(title: String?,message:String,viewController: UIViewController = UtilTool.topViewController(),handler: @escaping ()->()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(
            UIAlertAction(title: "取消", style: .default, handler: { (action) in
            }))
        alert.addAction(
            UIAlertAction(title: "确认", style: .default, handler: { (action) in
                handler()
            }))
        viewController.present(alert, animated: true, completion: nil)
    }
    
    class func showDefaultAlertView(message:String,viewController: UIViewController = UtilTool.topViewController(),handler: @escaping ()->(),cancelHandler:@escaping ()->()) {
        let alert = UIAlertController(title: "提示", message: message, preferredStyle: .alert)
        alert.addAction(
            UIAlertAction(title: "取消", style: .default, handler: { (action) in
                cancelHandler()
            }))
        alert.addAction(
            UIAlertAction(title: "确认", style: .default, handler: { (action) in
                handler()
            }))
        viewController.present(alert, animated: true, completion: nil)
    }
    
    
    func showTextFieldAlertView(title: String,message:String,confirmTitle: String,viewController: UIViewController = UtilTool.topViewController(),handler: @escaping ()->()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
 
        alert.addTextField { (tf) in
            tf.layer.borderColor = UIColor.white.cgColor
            tf.textAlignment = .center
            tf.placeholder = "更改本机号"
            tf.keyboardType = UIKeyboardType.phonePad
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.001) {
                tf.resignFirstResponder()
            }
        }
        alert.addAction(
            UIAlertAction(title: "取消", style: .default, handler: { (action) in
            }))
        alert.addAction(
            UIAlertAction(title: confirmTitle, style: .default, handler: { (action) in
                self.tfContent = (alert.textFields?.first?.text)!
                handler()
            }))
        viewController.present(alert, animated: true, completion: nil)
    }
    
}
