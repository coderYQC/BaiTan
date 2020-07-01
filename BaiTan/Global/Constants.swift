//
//  Constants.swift
//  FlashDelivery
//
//  Created by yanqunchao on 2020/5/18.
//  Copyright © 2020 yanqunchao. All rights reserved.
//

import UIKit
import ESTabBarController_swift

let kAPP_BG_RGB_VAL:CGFloat = 242

class Constants: NSObject {
     
    //橘黄色 ee9f39
        static let APP_TABBARITEM_SEL_COLOR = UIColor.colorFromRGB(0x292336)
        //红色（显示价钱）
        static let APP_PRICE_COLOR = UIColor.colorFromRGB(0xF55555)
        // 蓝色
        static let APP_MAIN_COLOR = UIColor.rgb(r: 250, g: 200, b: 60)
        //【偏向浅蓝色】
        static let kLightBlueColor = UIColor.colorFromRGB(0xE7F2FF)
   
    static let APP_BACKGROUND_COLOR = UIColor.init(red: kAPP_BG_RGB_VAL / 255.0, green: kAPP_BG_RGB_VAL / 255.0, blue: kAPP_BG_RGB_VAL / 255.0, alpha: 1)
        static let kBtnDisableColor = UIColor.colorFromRGB(0xE6E6E6)
        static let kOrangeColor = UIColor.colorFromRGB(0xFFAC29)
        
        //------------------灰色系----------------/
        static let k01Color = UIColor.colorFromRGB(0x010101)//分类页分类栏一级文字颜色//深黑色
        static let APP_FONT_COLOR = UIColor.colorFromRGB(0x333333)
        static let k33Color = UIColor.colorFromRGB(0x333333)
        static let k74Color = UIColor.colorFromRGB(0x747474)//主题文字颜色
        static let k96Color = UIColor.colorFromRGB(0x969696)  //深灰
        static let k99Color = UIColor.colorFromRGB(0x999999)  //深灰
        
        static let kC8Color = UIColor.colorFromRGB(0xC8C8C8)//底部按钮和文字默认颜色//灰色
        static let kf0Color = UIColor.colorFromRGB(0xf0f0f0)
        static let kf5Color = UIColor.colorFromRGB(0xF5F5F5)//
        static let k9bColor = UIColor.colorFromRGB(0x9B9B9B)//
        static let k66Color = UIColor.colorFromRGB(0x666666)//
        static let kDBColor = UIColor.colorFromRGB(0xDBDBDB)//
        
        //紫色
        static let kDarkTextColor =  UIColor.colorFromRGB(0x292336)//偏黑色
        static let kLightGrayTextColor =  UIColor.colorFromRGB(0xb4b4b4)//灰色颜色
        static let kb2Color =  UIColor.colorFromRGB(0xb2b2b2)//灰色颜色
        static let kb4Color = UIColor.colorFromRGB(0xb4b4b4)
        static let kGoldenColor = UIColor.colorFromRGB(0xB59F78)
        static let k7CColor = UIColor.colorFromRGB(0x7C7C7C)
        static let kBlueTextColor = UIColor.colorFromRGB(0x0091FF)
        
    //    static let kPriceRedColor = UIColor.colorFromRGB(0xf80c12)
        
//        static let kPriceRedColor = APP_MAIN_COLOR
        
        //菊花背景色
        static let HUD_BACKGROUND_COLOR = kf0Color
        
       /*******************   第三方配置相关   **************************************/
         
         //正式集群地址
         static let FORMAL_HOST = "https://m.hengtn.com/rest/"//正式环境
         static let FORMAL_HOST_ACCESSORY = "https://depot.hengtn.com/"//配件正式地址
         static let FORMAL_HOST_SensorsAnalyticsURL =  "https://da.hengtn.com/sa?project=production"//神策
         static let WXMiniProgramAPPID = "gh_594b1cd804dd"//大众工匠(正式)//小程序分享参数
         static let WXAPI_KEY = "wx2f0257e46500e8e3"  //微信支付Key
         static let ACTIVITY_HOST = "https://m.hengtn.com/"  //活动

    
    
         static var isLocationAnimating:Bool = false 
    
     
        static var HOST:String!{
            
            return FORMAL_HOST
        }
        
        //APPSTORE的appid
        static let STOREAPPID = "1387400675"
         
        static let WXAPI_AppSecret = "ed63bc5fccf2a59af18220da91bd59c0"
        
        //qq
        static let QQ_APP_ID="1106937136"
        static let QQ_APP_KEY="ECjmOpKOz9wSFXMj"
     
        //支付宝
        static let ALI_SCHEME = "aliHengtn"
         
        //百度地图AK
        static let BMK_AK = "ojV2E59lBYcqzVGHVRao71pw9cgGep3k"
        
         
        //推送
        static let PUSH_AppKey : String = "24999439"
        static let PUSH_AppSecret : String = "4cf803be148fd6c5bf28ffbfc50cce1f"
      
       
       /*******************   网络相关   **************************************/
        
        
        // 网络常用语
        static let kNetWorkError : String = "网络繁忙，请稍后再试"
        static let kCodeSended : String = "验证码已发送，请接收"
      
        static let returnCode = "returnCode"
        static let returnMsg = "returnMsg"
        
        static let returnStatus = "status"
        
        
        static let returnData = "data"
        static let userSessionId="sessionId"
        static let userIsLogin = "isLogin"
 
         
        enum returnCodeEnum {
            case SUCCESS
            case fail
        }
        
        static var sessionId:String!{
            return AccountManager.shared.account.sessionId ?? ""
        }
        
        static var mineVcTabbarIndex:Int!

        
        //是否开启地址切换
        static var openSwitchHost: Bool! {
            return false
        }
//        static var HOST:String!{
//             return FORMAL_HOST
//        }
        
         
//        static var isLogin:Bool!{
//            return AccountManager.sharedStructInstance.account.isLogin ?? false
//        }
//
//        static var latitude:String!{
//            return UserDefaults.standard.value(forKey: userLatitude) as? String ?? ""
//        }
//
//        static var longitude:String!{
//            return UserDefaults.standard.value(forKey: userLongitude) as? String ?? ""
//        }
//
        /*******************   尺寸相关   **************************************/
        static var kVcHeight:CGFloat! = JHeight
        
        static var kMasterOrderContentHeight: CGFloat! {
            return kVcHeight - kNaviBarHeight - 70
        }
        static var kVcFrame: CGRect! {
            return CGRect(x: 0, y: kNaviBarHeight, width: JWidth, height:  kVcHeight - kNaviBarHeight)
        }
        static var kVcBounds: CGRect! {
            return CGRect(x: 0, y: 0, width: JWidth, height: kVcHeight - kNaviBarHeight)
        }
        
        static var kVcFrameWithoutNaviBar: CGRect! {
            return CGRect(x: 0, y: -statusBarHeight, width: JWidth, height: kVcHeight + statusBarHeight)
        }
        
        static var kVcWithBottomViewFrame: CGRect! {
            return CGRect(x: 0, y: kNaviBarHeight, width: JWidth, height: kVcHeight - kNaviBarHeight -  kTabBarHeight)
        }
        static var kVcWithNewBottomViewFrame: CGRect! {
              return CGRect(x: 0, y: kNaviBarHeight, width: JWidth, height: kVcHeight - kNaviBarHeight -  kTabBarHeight -
              kBottomViewPadding)
        }
        static var kVcWithBottomViewBounds: CGRect! {
            return CGRect(x: 0, y: 0, width: JWidth, height:kVcHeight - kNaviBarHeight -  kTabBarHeight)
        }
        
        static var kBottomViewFrame: CGRect! {
            return CGRect(x: 0, y: kVcHeight -  kTabBarHeight, width: JWidth, height: tabBarHeight)
        }
        static var kBottomBtnFrame: CGRect! {
            return CGRect(x: 0, y: 0, width: JWidth, height: 49)
        }
        static var kVcSafeHeight: CGFloat! {
            return kVcHeight - kNaviBarHeight - kMoreHeightOfIphoneX
        }
        
        static var kMoreHeightOfIphoneX: CGFloat! {
            return (UtilTool.iPhoneX() ? 34  : 0)
        }
        
        static var kVcWithCornerBottomViewFrame: CGRect! {
            return CGRect(x: 0, y: kNaviBarHeight, width: JWidth, height: kVcHeight - kNaviBarHeight -  kTabBarHeight - 15)
        }
        static var kCornerBottomViewFrame: CGRect! {
            return CGRect(x: 0, y: kVcHeight -  kTabBarHeight - 15, width: JWidth, height: tabBarHeight + 15)

        }
        
        //tabBar高度
        static var tabBarHeight:CGFloat!{
            if UtilTool.iPhoneX() {
                return 83
            } else {
                return 49
            }
        }
        
        //naviBarHeight高度
        static var naviBarHeight:CGFloat!{
            return Constants.statusBarHeight + 44
        }
        
        //statusBarHeight高度
        static var statusBarHeight:CGFloat!{
            if UtilTool.iPhoneX() {
                return 44
            } else {
                return 20
            }
        }
        
        static var isNormalStatusBar:Bool!{
            if UtilTool.iPhoneX() {
                return UIApplication.shared.statusBarFrame.height == 44
            } else {
                return UIApplication.shared.statusBarFrame.height == 20
            }
        }
    
        static var fixTabbarHeight:CGFloat!{
            if UtilTool.iPhoneX() {
                return 34
            } else {
                return 0
            }
        }
        static var fixNaviBarHeight:CGFloat!{
            if UtilTool.iPhoneX() {
                return 24
            } else {
                return 0
            }
        }
}
