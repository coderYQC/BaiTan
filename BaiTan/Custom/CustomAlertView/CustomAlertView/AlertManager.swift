//
//  AlertManager.swift
//  FlashDelivery
//
//  Created by yanqunchao on 2020/5/24.
//  Copyright © 2020 yanqunchao. All rights reserved.
//

import UIKit

class AlertManager: NSObject {
    
    static func shared() -> AlertManager {
        return AlertManager()
    }
    
    private override init() { }
    
    var alertView:CustomAlertView!
    
    func showAlertView(message:String,handler: @escaping ()->()) {
        self.alertView =  (CustomAlertView.viewFromXib() as! CustomAlertView)
        self.alertView.frame = CGRect(x: 0, y: 0, width: JWidth - 40, height: 160)
        self.alertView.title = "温馨提示"
        self.alertView.message = message
        self.alertView.largeBtn.isHidden = false
        self.alertView.largeBtnClick = {
            handler()
            self.alertView.hideInWindow()
        }
        self.alertView.showInWindow()
    }
    func showAlertView(title:String,message:String,handler: @escaping ()->()) {
        self.alertView =  (CustomAlertView.viewFromXib() as! CustomAlertView)
        self.alertView.frame = CGRect(x: 0, y: 0, width: JWidth - 40, height: 160)
        self.alertView.title = title
        self.alertView.message = message
        self.alertView.largeBtn.isHidden = false
        self.alertView.largeBtnClick = {
            handler()
            self.alertView.hideInWindow()
        }
        self.alertView.showInWindow()
    }
    func showAlertView(title: String, message:String, cancelTitle:String, confirmTitle: String,handler: @escaping ()->(),cancelHandler:@escaping ()->()) {
        self.alertView =  (CustomAlertView.viewFromXib() as! CustomAlertView)
        self.alertView.frame = CGRect(x: 0, y: 0, width: JWidth - 40, height: 160)
        self.alertView.title = title
        self.alertView.message = message
        self.alertView.largeBtn.isHidden = true
        self.alertView.leftBtnTitle = cancelTitle
        self.alertView.rightBtnTitle = confirmTitle
        self.alertView.leftBtnClick = {
            cancelHandler()
            self.alertView.hideInWindow()
        }
        self.alertView.rightBtnClick = {
            handler()
            self.alertView.hideInWindow()
        }
        self.alertView.showInWindow()
    }
}
