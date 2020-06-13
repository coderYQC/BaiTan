//
//  AccountManager.swift
//  FlashDelivery
//
//  Created by yanqunchao on 2020/5/18.
//  Copyright © 2020 yanqunchao. All rights reserved.
//

 

import UIKit
import SwiftyJSON
import SVProgressHUD
 
class AccountManager: NSObject {
    var account: AccountModel!
    var isLogin: Bool?
    
    static let shared = AccountManager()
    
    override init() {
        super.init()
          account = AccountModel()
          loadAccountInfoFromDisk()
    }
 
    func saveAccountInfoToDisk() {
        kUserDefaults.set(self.account.mobilePhone, forKey: "mobilePhone")
        kUserDefaults.set(self.account.realName, forKey: "realName")
        kUserDefaults.set(self.account.nickName, forKey: "nickName")
        kUserDefaults.set(self.account.ageGroup, forKey: "birthday")
        kUserDefaults.set(self.account.ownPic, forKey: "ownPic")
        kUserDefaults.set(self.account.sex, forKey: "sex")
        kUserDefaults.set(self.account.isLogin, forKey: "isLogin")
        kUserDefaults.set(self.account.memberId, forKey: "memberId")
        kUserDefaults.set(self.account.sessionId, forKey: "sessionId")
        kUserDefaults.set(self.account.score, forKey: "score")
        kUserDefaults.set(self.account.memberType, forKey: "memberType")
        kUserDefaults.set(self.account.gradeId, forKey: "gradeId")
       
        self.loadAccountInfoFromDisk()
    }
    func loadAccountInfoFromDisk() {
         self.account.mobilePhone = kUserDefaults.value(forKey: "mobilePhone") as? String ?? ""
         self.account.realName = kUserDefaults.value(forKey: "realName") as? String ?? ""
         self.account.nickName = kUserDefaults.value(forKey: "nickName") as? String ?? ""
         self.account.ageGroup = kUserDefaults.value(forKey: "birthday") as? String ?? ""
         self.account.ownPic = kUserDefaults.value(forKey: "ownPic") as? String ?? ""
         self.account.sex = kUserDefaults.value(forKey: "sex") as? Int ?? 3
         self.account.isLogin = kUserDefaults.value(forKey: "isLogin") as? Bool ?? false
         self.account.memberId = kUserDefaults.value(forKey: "memberId") as? String ?? ""
         self.account.sessionId = kUserDefaults.value(forKey: "sessionId") as? String ?? ""
         self.account.score = kUserDefaults.value(forKey: "score") as? Int ?? 0
         self.account.memberType = kUserDefaults.value(forKey: "memberType") as? String ?? ""
         self.account.gradeId = kUserDefaults.value(forKey: "gradeId") as? Int ?? 0
    }
    
    func resetAccountInfo() {
        kUserDefaults.set("", forKey: "mobilePhone")
        kUserDefaults.set("", forKey: "realName")
        kUserDefaults.set("", forKey: "nickName")
        kUserDefaults.set("", forKey: "birthday")
        kUserDefaults.set("", forKey: "ownPic")
        kUserDefaults.set("", forKey: "memberId")
        kUserDefaults.set(3, forKey: "sex")
        kUserDefaults.set(false, forKey: "isLogin")
        kUserDefaults.set("", forKey: "sessionId")
        kUserDefaults.set(0, forKey: "score")
        kUserDefaults.set("", forKey: "memberType")
        kUserDefaults.set(0, forKey: "gradeId")
        loadAccountInfoFromDisk()
    }
    
    func logout() {
        //重置用户信息
        resetAccountInfo()
        kNotificationCenter.post(name: Notification.Name.init(rawValue: kLogoutSuccess), object: nil)
//        //解绑账号(后台推送)
//        CloudPushSDK.unbindAccount { (res: CloudPushCallbackResult?) in
//            if (res?.success)! {
//                print("==================> 解绑账号成功")
//            } else {
//                print("==================> 解绑账号失败")
//            }
//        }
    }
    func getUserInfo(sessionId: String, success: @escaping AnyClosure, failure: @escaping FailClosure) {
//        personalModel.getSetData().subscribe(onNext: { (personal) in
//            print("\(personal)")
//            self.account.mobilePhone = personal["mobilePhone"].stringValue
//            self.account.ownPic = personal["ownPic"].stringValue
//            self.account.realName = personal["realName"].stringValue
//            self.account.nickName = personal["nickName"].stringValue
//            self.account.sex = personal["sex"].intValue
//            self.account.memberId = personal["memberId"].stringValue
//            self.account.ageGroup = personal["birthday"].stringValue
//            self.account.memberType = personal["gradeName"].stringValue
//            self.account.score = personal["customeScore"].intValue
//            self.account.gradeId = personal["gradeId"].intValue
//            self.account.isLogin = true
//            self.saveAccountInfoToDisk()
//        
//            success(personal)
////            //绑定账号(后台推送)
////            CloudPushSDK.bindAccount(self.account.mobilePhone, withCallback: { (res: CloudPushCallbackResult?) in
////                if (res?.success)! {
////                    print("==================> 绑定账号成功:\(String(describing: self.account.mobilePhone))")
////                } else {
////                    print("==================> 绑定账号失败")
////                }
////            })
//            
////            kUserDefaults.removeObject(forKey: "hasTapCouper")
////            kUserDefaults.removeObject(forKey: "hasThirdAnniversary")
////            kUserDefaults.removeObject(forKey: "freeLuck")
////
//            kNotificationCenter.post(name: Notification.Name.init(rawValue: kLoginSuccess), object: nil)
// 
//        },onError:{ (error) in 
//            failure((error as NSError).domain)
//        }).disposed(by: disposed)
        
    }
    
}
