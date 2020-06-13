//
//  AccountModel.swift
//  FlashDelivery
//
//  Created by yanqunchao on 2020/5/18.
//  Copyright © 2020 yanqunchao. All rights reserved.
//

//数据持久化-UserDefaults模型
import UIKit

@objcMembers
class AccountModel: NSObject {
    
    var mobilePhone: String?
    var realName: String?
    var nickName: String?
    var ageGroup: String?
    var ownPic: String?
    var sex: Int?
    var memberId: String?
    var isLogin: Bool?
    var sessionId: String?
    var memberType:String?
    var gradeId:Int?
    var score:Int = 0
    
    override init() {
        super.init()
    }
    init(dict : [String : Any]) {
        super.init()
        for (key,value) in dict {
            JPrint(msg: "\(key)" + "----" + "\(value)")
        }
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
