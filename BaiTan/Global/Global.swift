//
//  Global.swift
//  FlashDelivery
//
//  Created by yanqunchao on 2020/5/18.
//  Copyright © 2020 yanqunchao. All rights reserved.
//
 
import Foundation
import SwiftyJSON 
typealias ClickClosure = ()->()//不需要任何回调内容
typealias ArrayClosure = ([JSON])->()//返回array
typealias DataClosure = (JSON)->()//返回data
typealias FailClosure = (String)->()//失败回调
typealias AnyClosure = (Any)->()//返回任意格式
typealias AddressClosure = (JSON) -> ()
typealias BoolClosure = (Bool) -> ()
typealias dataClosure = (Data) -> ()
typealias StringClosure = (String)->()
typealias ArrayAnyClosure = ([AnyObject])->()

typealias DictionaryClosure = ([String: Any])->()

typealias StringArrayClosure = ([String])->()
typealias IntArrayClosure = ([Int])->()
typealias ErrorClosure = (Error)->()
typealias IntClosure = (Int)->()
typealias ParamsDic = [String: Any] 




let JRect = UIScreen.main.bounds
let JHeight = JRect.size.height
let JWidth = JRect.size.width
let jScale:CGFloat = JRect.size.width / 375
let jScaleH = JRect.size.height / 667
let jBorderWidth: CGFloat = 16.0
let kBtnNorW = JWidth - 2*jBorderWidth
let kBtnNorH : CGFloat = 44.0
let kStatusBarHeight:CGFloat = Constants.statusBarHeight//电池栏h高度
let kNaviBarHeight:CGFloat = Constants.statusBarHeight + 44//x是 44+44 = 88  6sp是 20+44 = 64

let kIphoneXMoreHeight = Constants.statusBarHeight - 20

let kWindowFrame = CGRect(x: 0, y: 0, width: JWidth, height: JHeight)

let kTabBarHeight:CGFloat = Constants.tabBarHeight//x是 83  6sp是 49
 
let MyAlertManager = AlertManager.shared()
let kNotificationCenter = NotificationCenter.default
let kUserDefaults = UserDefaults.standard



let kLoginOutdateErrMsg = "SESSIONID FAILURE"
let kLoginOutdateErrMsg2 = "invalid sessionId"
