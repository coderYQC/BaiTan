//
//  AppDelegate.swift
//  BaiTan
//
//  Created by yanqunchao on 2020/6/6.
//  Copyright © 2020 yanqunchao. All rights reserved.
//

import UIKit
import SVProgressHUD
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,BMKGeneralDelegate {

    var window: UIWindow? 
      

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //转菊花属性
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.custom)
        SVProgressHUD.setBackgroundColor(Constants.HUD_BACKGROUND_COLOR)
        SVProgressHUD.setFont(UIFont.systemFont(ofSize: 13))
        SVProgressHUD.setForegroundColor(Constants.APP_FONT_COLOR)
        SVProgressHUD.setMinimumDismissTimeInterval(1)//设置转菊花最小的消失时间
        SVProgressHUD.setMaximumDismissTimeInterval(10)//设置转菊花最大的消失时间
        SVProgressHUD.setDefaultMaskType(.clear)
   
        let mapManager = BMKMapManager()
      
        let ret = mapManager.start(Constants.BMK_AK, generalDelegate: self)
        if ret == false {
           JPrint(msg:"manager start failed!")
        }
        self.window?.rootViewController = MainProvider.customAnimateRemindStyle(implies: false)
         
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
         
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
         
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
      
    }
     
}


