//
//  UtilTool.swift
//  LynxIOS
//
//  Created by 叶波 on 2018/5/7.
//  Copyright © 2018年 叶波. All rights reserved.
//

//工具类

import UIKit
import SwiftyJSON
import SVProgressHUD
import Alamofire
import WebKit

enum VersionResult: Int {
    case equal = 0
    case ascend = 1
    case descend = 2
    case unknown = 3
}


class UtilTool: NSObject {

    static fileprivate let userFileName:String = "userInfo.plist"
    static var totalTime:Int = 0
    static var uuidTotalTime:Int = 0
    
    static var isFirstIn:Bool = true
    static var hasAlerted:Bool = false
    
    //MARK:/************格式转换***********/
    //价格格式转换
    class func changePrice(_ price:Int)->String {
        return String(format: "%.\(Double(price/100)==Double(price)/100.0 ? 0 : 2)f", arguments: [Double(price)/100.0]).qc_trimRedundantZero()
    }
    /// 时间戳转日期
    /// - Parameter num: 时间戳,格式
    /// - Returns: 日期
    class func secondsToDate(num:Int,format:String)->String{
        let timeStamp = Double(num)/1000.0
        //转换为时间
        let timeInterval:TimeInterval = TimeInterval(timeStamp)
        let date = NSDate(timeIntervalSince1970: timeInterval)
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = format //自定义日期格式
        let time = dateformatter.string(from: date as Date)
        return time
    }
    
    /// 0时区转东八区
    class func dateConvertString(date:Date,dateFormat:String = "yyyy-MM-dd HH:mm") -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = dateFormat
        let date = formatter.string(from: date)
        return date
    }
    
    /// 日期转时间戳
    /// - Parameter date: 日期
    /// - Returns: 时间戳
    class func dateToSeconds(date:String,format:String)->Int{
        let datefmatter = DateFormatter()
        datefmatter.dateFormat = format
        let dat = datefmatter.date(from: date)
        if dat == nil {
            return 0
        }
        let dateStamp:TimeInterval = dat!.timeIntervalSince1970
        let dateStr:Int = Int(dateStamp)
        return dateStr
    }
    
    
    /// 根据时间戳获取倒计时时间
    ///
    /// - Parameter time: 相差时间戳
    /// - Returns: 时间字符串
    class func changeEndTime(secondsCountDown:Int) -> (Int,String) {
        // 重新计算 时/分
        
        let time:Int = secondsCountDown / 1000
        let str_day =  String(format: "%02d", time / 86400)
        let str_hour =  String(format: "%02d", (time % 86400) / 3600)
        let str_minute =  String(format: "%02d", ((time % 86400)  % 3600)  / 60)
        let str_second =  String(format: "%02d", ((time % 86400)  % 3600) % 60)
        
        let timeString = str_day + "天 " + str_hour + ":" + str_minute + ":" + str_second

        if time <= 0 {
            return (0,"00")
        }
        
        return (Int(str_second)!,timeString)
    }
    
    class func getAddressMsgByLatLng(coordinate:CLLocationCoordinate2D,success:@escaping DataClosure,fail:@escaping FailClosure){
        
        let params = ["location":"\(coordinate.latitude),\(coordinate.longitude)","output":"json","ak":Constants.BMK_AK,"coordtype":"wgs84ll","mcode":"com.yanqunchao.BaiTan"]
        var paramsStr = ""
           for (index,dic) in params.enumerated() {
               if index == 0 {
                   paramsStr += "?\(dic.key)=\(dic.value)"
               } else {
                   paramsStr += "&\(dic.key)=\(dic.value)"
               }
           }
        let fullUrl = APIConst.HOST_getMsgByLatLng + paramsStr
        
        Alamofire.request( fullUrl,method:.get,parameters:nil).responseJSON { response in
            if(response.result.isSuccess){
                let result = response.result.value as? [String:Any] ?? [:]
                
                success(JSON(result))
            }else{
                 
            }
        }
    }
  //设置价格属性字符串
     class func getPriceAttributeStr(prefixStr:String="￥",prePrice:Int = 0,postPrice:Int = 0,unit:String = "",suffixStr:String="",prePriceColor:UIColor = Constants.APP_PRICE_COLOR,postPriceColor:UIColor=Constants.k99Color,prefixStrFontSize:CGFloat = 11)->NSMutableAttributedString{
         
         if postPrice == 0 {
             let prePriceStr = UtilTool.changePrice(prePrice)
             let priceFullStr =  prefixStr + prePriceStr + unit
             
             let attributeString = NSMutableAttributedString.init(string:priceFullStr)
             
             let fullRange = NSRange.init(location: 0, length: priceFullStr.count)
             //设置全局字体
             attributeString.addAttribute(.font, value: UIFont.systemFont(ofSize: prefixStrFontSize), range: fullRange)
             //设置全局字体颜色
             attributeString.addAttribute(.foregroundColor, value: prePriceColor, range: fullRange)
             
             let range = NSRange.init(location: prefixStr.count, length: prePriceStr.count)
             attributeString.addAttribute(.foregroundColor, value: prePriceColor, range: range)
             attributeString.addAttribute(.font, value: UIFont.DINAlternateBold(size: 18), range: range)
             
             return attributeString
         }else{
             let prePriceStr = UtilTool.changePrice(postPrice)
             let postPriceStr = UtilTool.changePrice(prePrice)
             let postFullPriceStr = prefixStr + postPriceStr
             let preFullPriceStr = prefixStr + prePriceStr + unit
             let priceFullStr = preFullPriceStr + "  " + postFullPriceStr
             
             let attributeString = NSMutableAttributedString.init(string:priceFullStr)
             
             let fullRange = NSRange.init(location: 0, length: priceFullStr.count)
             //设置全局字体
             attributeString.addAttribute(.font, value: UIFont.systemFont(ofSize: prefixStrFontSize), range: fullRange)
             
             let preRange = NSRange.init(location: 0, length: preFullPriceStr.count)
             //设置活动价颜色
             attributeString.addAttribute(.foregroundColor, value: prePriceColor, range: preRange)
             
             let range = NSRange.init(location: prefixStr.count, length: prePriceStr.count)
             //设置活动价字体大小
             attributeString.addAttribute(.font, value: UIFont.DINAlternateBold(size: 18), range: range)
             
             let postRange = NSRange(location: priceFullStr.count - postFullPriceStr.count, length: postFullPriceStr.count)
             //设置原价价颜色
             attributeString.addAttribute(.foregroundColor, value: postPriceColor, range: postRange)
             //设置删除线
              attributeString.addAttribute(NSAttributedStringKey.strikethroughStyle, value: NSNumber.init(value: 1), range: postRange)
             
             return attributeString
         }
     }
     
//    ///压缩图片
//    class func getNewCompressedImageData(image:UIImage,maxLength:CGFloat) -> Data {
//        var quality:CGFloat = 0.5
//        var data = UIImageJPEGRepresentation(image, quality)!
//        var length = CGFloat(data.count)
//
//        while length > maxLength && quality > 0.01  {
//            quality = quality - 0.05
//            data = UIImageJPEGRepresentation(image, quality)!
//            length = CGFloat(data.count)
//        }
//        return data
//    }
    
//    class func saveAdvertisementData(data: JSON, dataName: String) -> String? {
//
//        if let jsonData = try? data.rawData() {
//            let fullPath = NSHomeDirectory().appending("/Documents/").appending(dataName)
//            (jsonData as NSData).write(toFile: fullPath, atomically: true)
//            //print("fullPath=\(fullPath)")
//            return fullPath
//        }
//
//        return nil
//    }
//    class func saveImage(currentImage: UIImage, newSize: CGSize, imageName: String) -> String? {
//        //压缩图片尺寸
//        UIGraphicsBeginImageContext(newSize)
//        currentImage.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
//
//        if let newImage = UIGraphicsGetImageFromCurrentImageContext() {
//            //UIImageJPEGRepresentation此方法可将图片压缩，但是图片质量基本不变，第二个参数即图片质量参数。
//            if let imageData = UIImageJPEGRepresentation(newImage, 1) as NSData? {
//                let fullPath = NSHomeDirectory().appending("/Documents/").appending(imageName)
//                imageData.write(toFile: fullPath, atomically: true)
//                 //print("fullPath=\(fullPath)")
//                return fullPath
//            }
//        }
//        return nil
//    }
    
    
    /// 获取当前时间戳
    class func getNowTime()->Int{
        let now = Date()
        let timeInterval:TimeInterval = now.timeIntervalSince1970
        let timeStamp = Int(timeInterval)
        return timeStamp
    }
    /// 获取当前毫秒时间戳
    class func getNowMilliTime()->Int{
        let now = Date()
        let timeInterval:TimeInterval = now.timeIntervalSince1970
        let timeStamp = CLongLong(round(timeInterval*1000))
        return Int(timeStamp)
    }
    /// 获取当前详细时间
    class func getCurrentDetailDate()->DateComponents{
        let calendar = Calendar.current
        let components = calendar.dateComponents(([.year, .month, .day, .hour, .minute, .second]), from: Date())
        return components
    }
    
    /// 时间戳转Date
    class func timeStampToDate(timeStamp:Int) ->Date
    {
        let timeStamp = Double(timeStamp)/1000.0
        let timeInterval:TimeInterval = TimeInterval(timeStamp)
        return NSDate(timeIntervalSince1970: timeInterval) as Date
    }
    
    class func getWeekDay(dateTime:String)->String{
        let dateFmt = DateFormatter()
        dateFmt.dateFormat = "yyyy-MM-dd"
        let date = dateFmt.date(from: dateTime)
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "EEEE"
        let weekStr = outputFormatter.string(from: date ?? Date()) 
        return weekStr
    }
    
    class func getDatesWithStartDate(_ startDate:String, endDate:String)->([String]) {
        let calendar = Calendar(identifier: .gregorian)
        let matter = DateFormatter()
        matter.dateFormat = "yyyy-MM-dd"
        var start = matter.date(from: startDate)
        let end = matter.date(from: endDate)
        var componentArray:[String] = []
        var result = start?.compare(end!)
        var comps:DateComponents?
        while result != ComparisonResult.orderedDescending {
            comps = calendar.dateComponents([Calendar.Component.year,Calendar.Component.month,Calendar.Component.day], from: start!)
            let startStr = UtilTool.dateConvertString(date: start!,dateFormat: "yyyy-MM-dd")
            componentArray.append(startStr)
            //后一天
            comps!.day = comps!.day! + 1
            start = calendar.date(from: comps!)
            result = start!.compare(end!)
        }
        return componentArray
    }
    
    class func getDateWithDaysLater(_ dayCount:Int,_ nowDate:Date)->String{
        let calendar = Calendar(identifier: .gregorian)
        let matter = DateFormatter()
        matter.dateFormat = "yyyy-MM-dd"
        var comps = calendar.dateComponents([Calendar.Component.year,Calendar.Component.month,Calendar.Component.day], from: nowDate)
        comps.day = comps.day! + dayCount
        let resultDate = calendar.date(from: comps)
        return UtilTool.dateConvertString(date: resultDate!,dateFormat: "yyyy-MM-dd")
    }
    
//    + (NSArray*)getDatesWithStartDate:(NSString *)startDate endDate:(NSString *)endDate {
//
//    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier: NSCalendarIdentifierGregorian];
//
//    //字符串转时间
//    NSDateFormatter *matter = [[NSDateFormatter alloc] init];
//    matter.dateFormat = @"yyyy-MM-dd";
//    NSDate *start = [matter dateFromString:startDate];
//    NSDate *end = [matter dateFromString:endDate];
//
//    NSMutableArray *componentAarray = [NSMutableArray array];
//    NSComparisonResult result = [start compare:end];
//    NSDateComponents *comps;
//    while (result != NSOrderedDescending) {
//    comps = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay |  NSCalendarUnitWeekday fromDate:start];
//    [componentAarray addObject:start];
//
//    //后一天
//    [comps setDay:([comps day]+1)];
//    start = [calendar dateFromComponents:comps];
//
//    //对比日期大小
//    result = [start compare:end];
//    }
//    return componentAarray;
//    }
    
    
    
    
    
    
    class func changeUrl(urlString:String) ->String {
        if (!urlString.hasPrefix("http:") && !urlString.hasPrefix("https:")) {
            return "https://"
        } else {
            return urlString
        }
    }
    /// JSONString转换为数组
    class func getArrayFromJSONString(jsonString:String) ->Array<Any>{
        let jsonData:Data = jsonString.data(using: .utf8)!
        let arr = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        if arr != nil {
            return arr as! Array
        }
        return []
    }
    
    /// JSONString转换为字典
    class func getDictionaryFromJSONString(jsonString:String) ->NSDictionary{
        let jsonData:Data = jsonString.data(using: .utf8)!
        let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        if dict != nil {
            return dict as! NSDictionary
        }
        return NSDictionary()
    }
    
    //MARK: object转json字符串(序列化)
    class func toJSONString(data:Any) -> String{
        let data = try?JSONSerialization.data(withJSONObject: data, options: JSONSerialization.WritingOptions.prettyPrinted)
        let strJson = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
        return strJson! as String
    }
    
    class func toParamsString(paramsDic:[String:Any]) -> String{
     
        var paramsString = ""
        for (i, key) in paramsDic.keys.enumerated() {
            let val = paramsDic[key]
            if i == 0 {
               paramsString += "?\(key)=\(val!)"
            }else{
               paramsString += "&\(key)=\(val!)"
            }
        }
        return paramsString
    }
    
//    - (NSString *)URLRequestStringWithURL:(NSString *)urlstr{
//
//    NSMutableString *URL = [NSMutableString stringWithFormat:@"%@",urlstr];
//    //获取字典的所有keys
//    NSArray * keys = [self allKeys];
//
//    //拼接字符串
//    for (int j = 0; j < keys.count; j ++){
//    NSString *string;
//    if (j == 0){
//    //拼接时加？
//    string = [NSString stringWithFormat:@"?%@=%@", keys[j], self[keys[j]]];
//
//    }else{
//    //拼接时加&
//    string = [NSString stringWithFormat:@"&%@=%@", keys[j], self[keys[j]]];
//    }
//    //拼接字符串
//    [URL appendString:string];
//
//    }
  
    //MARK:/************检测与判断***********/
    //检查是否登录
//    class func checkLogin() -> Bool {
//        if !Constants.isLogin {
//            UtilTool.topViewController().navigationController?.pushViewController(UtilTool.getVcBySbAndVcName(sb: "login", vc: "login"), animated: true)
//            return false
//        }else {
//            return true
//        }
//    }
 
//    class func getIDFA()->String {
//        var idfa = ""
//        if #available(iOS 10, *) {
//            if ASIdentifierManager.shared().isAdvertisingTrackingEnabled {
//                idfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString
//            }else{
//                idfa = ""
//            }
//        }else {
//           idfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString
//        }
//
//        return idfa
//    }
  
//    /// 获取UUID
//    class func getUUIDByKeyChain()->String{
//        var strUUID = KeyChainStore.load("com.hengtn.dzgjuser.udid") as? String ?? ""
//        if  strUUID == ""  {
//            strUUID = ASIdentifierManager.shared().advertisingIdentifier.uuidString
//            
//            if strUUID.count == 0 || strUUID == "00000000-0000-0000-0000-000000000000" {
//                strUUID = UdeskSDKUtil.soleString()
//            }
//            KeyChainStore.save("com.hengtn.dzgjuser.udid", data: strUUID)
//        }
//        return strUUID
//    }
//    
    //判断是否是iPhoneX
    class func iPhoneX() -> Bool {
        if UIScreen.main.bounds.height >= 812 {
            return true
        }
        return false
    }
    
//    //MD5加密
//    class func md5String(str:String) -> String{
//        let cStr = str.cString(using: String.Encoding.utf8);
//        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: 16)
//        CC_MD5(cStr!,(CC_LONG)(strlen(cStr!)), buffer)
//        let md5String = NSMutableString();
//        for i in 0 ..< 16{
//            md5String.appendFormat("%02x", buffer[i])
//        }
//        free(buffer)
//        return md5String as String
//    }
//
//
//    //判断是否是密码
//    class func validatePwd(pwd: String) -> Bool {
//        let pwdRegex = "^[A-Za-z0-9]{6,20}$"
//        let pwdTest = NSPredicate(format: "SELF MATCHES %@", pwdRegex)
//        return pwdTest.evaluate(with:pwd)
//    }
//    //判断是否是手机号码
//    class func validateMobilePhone(phone: String) -> Bool {
//        let regex = "^(1[3-9][0-9])\\d{8}$"
//        let predicate : NSPredicate = NSPredicate.init(format: "SELF MATCHES %@", regex)
//        if predicate.evaluate(with: phone) {
//            return true
//        }
//        return false
//    }
//
//    //判断是否是身份证号码
//    class func validateIdCard(cardNum: String) -> Bool {
//        let regex = "^(\\d{14}|\\d{17})(\\d|[xX])$"
//        let predicate : NSPredicate = NSPredicate.init(format: "SELF MATCHES %@", regex)
//        if predicate.evaluate(with: cardNum) {
//            return true
//        }
//        return false
//    }
//
    //判断是否是空字符串 validate证实，验证；确认；使生效
    class func validateEmptyString(string: String) -> Bool {
        let whitespace = NSCharacterSet.whitespacesAndNewlines
        return string.trimmingCharacters(in: whitespace).count > 0 ? false : true
    }
    
//    //检测版本更新
//    class func checkVersion(isAlert: Bool = false,finishClosure:@escaping ClickClosure) {
//
//
//        //appid是你的app在AppStore提交时候的获得的
//        let appidUrl = APIConst.HOST_checkVersion!
//
//        let url = URL(string: appidUrl)
//        var request = URLRequest(url: url!)
//        request.httpMethod = "get"
//        let queue = OperationQueue()
//        NSURLConnection.sendAsynchronousRequest(request, queue: queue) { (response : URLResponse?,  data : Data?, errer : Error?) in
//
//
//            if response == nil {
//                if isAlert == true {
//                    SVProgressHUD.dismiss()
//                    SVProgressHUD.showError(withStatus: Constants.kNetWorkError)
//                }
//                finishClosure()
//                return
//            }
//            if errer != nil {
//                if isAlert == true {
//                    SVProgressHUD.dismiss()
//                    SVProgressHUD.showError(withStatus: Constants.kNetWorkError)
//                }
//                finishClosure()
//                return
//            }
//            if data != nil {
//
//                let receiveDic : [String: Any]?
//                do {
//                    try receiveDic = JSONSerialization.jsonObject(with: data!, options: .mutableLeaves) as? [String: Any]
//                } catch  let error as NSError {
//
//                    if isAlert == true {
//                        SVProgressHUD.dismiss()
//                        SVProgressHUD.showError(withStatus: Constants.kNetWorkError)
//                    }
//                    finishClosure()
//
//                    return
//                }
//
//                let data = receiveDic!["data"] as? [String:Any] ?? [:]
//                let appVersionMin = data["appVersionMin"] as? String ?? ""
//                let appCurrentVersion = data["appVersionCode"] as? String ?? ""
//
//                if appVersionMin == "" || appCurrentVersion == ""{
//                    if isAlert == true {
//                        SVProgressHUD.dismiss()
//                        SVProgressHUD.showError(withStatus: Constants.kNetWorkError)
//                    }
//                    finishClosure()
//                }else{
//                    //比较最低兼容版本
//                    if compareCurVersion(versionStr: appVersionMin) == .ascend {
//                        if self.hasAlerted == true {
//                            return
//                        }
//                        self.hasAlerted = true
//                        DispatchQueue.main.async {
//                            SVProgressHUD.dismiss()
//                            AlertViewManager.showAlertView(title: "版本有更新", message: "检测到新版本,是否更新?", cancelTitle: "退出", confirmTitle: "更新", handler: {
//                                self.hasAlerted = false
//                                //跳到应用商城
//                                let url = URL(string: "https://itunes.apple.com/us/app/id\(Constants.STOREAPPID)?ls=1&mt=8")
//                                if UIApplication.shared.canOpenURL(url!) == true {
//                                    UIApplication.shared.openURL(url!)
//                                }
//                            }, cancelHandler: {
//                                self.hasAlerted = false
//                                //杀死应用
//                                exit(0)
//                                //                                   finishClosure()
//                            })
//                        }
//                        return
//                    }else{
//                        SVProgressHUD.dismiss()
//                        finishClosure()
//                    }
//
//                    if self.isFirstIn || isAlert{
//                        self.isFirstIn = false
//                        //比较当前最新版本
//                        if compareCurVersion(versionStr: appCurrentVersion) == .ascend {
//                            DispatchQueue.main.async {
//                                if self.hasAlerted == true {
//                                    return
//                                }
//                                self.hasAlerted = true
//                                SVProgressHUD.dismiss()
//                                AlertViewManager.showAlertView(title: "版本有更新", message: "检测到新版本,是否更新?", cancelTitle: "取消", confirmTitle: "更新", handler: {
//                                    self.hasAlerted = false
//                                    //跳到应用商城
//                                    let url = URL(string: "https://itunes.apple.com/us/app/id\(Constants.STOREAPPID)?ls=1&mt=8")
//                                    if UIApplication.shared.canOpenURL(url!) == true {
//                                        UIApplication.shared.openURL(url!)
//                                    }
//                                }, cancelHandler: {
//                                    self.hasAlerted = false
//                                    finishClosure()
//                                })
//                            }
//                        }else{
//                            if isAlert == true {
//                                SVProgressHUD.dismiss()
//                                SVProgressHUD.showInfo(withStatus: "当前版本为最新版本哟！")
//                            }
//                        }
//                    }
//                }
//            }else{
//
//                if isAlert == true {
//                    SVProgressHUD.dismiss()
//                    SVProgressHUD.showError(withStatus: Constants.kNetWorkError)
//                }
//            }
//        }
//    }
 
    //判断是否是纯数字
    class func isPurnInt(string: String) -> Bool {
        //先判断是否包含空格
        if string.contains(" ") {
            return false
        }
        let scan: Scanner = Scanner(string: string)
        var val:Int = 0
        return scan.scanInt(&val) && scan.isAtEnd
    }
    
    //判断是否是float
    class func isPurnFloat(string: String) -> Bool {
        //先判断是否包含空格
        if string.contains(" ") {
            return false
        }
        let scan: Scanner = Scanner(string: string)
        var val:Float = 0
        return scan.scanFloat(&val) && scan.isAtEnd
    }
  
    //判断是否是url
    class func isUrlString(string: String?) -> Bool {
        //先判断是否包含空格
        if string != nil && (string!.hasPrefix("http:") || string!.hasPrefix("https:")) {
            return true
        }else {
            return false
        }
    }
    
    //MARK:/************获取方法封装***********/
    
//    //获取地址详细(系统方法)
//    class func getAddressDetail(lat:Double,lng:Double,placeMarkClosure:@escaping AnyClosure){
//
//        // 保存 Device 的现语言 (英语 法语 ，，，)
//
//        let userDefaultLanguages = kUserDefaults.object(forKey: "AppleLanguages")
//        // 强制 成 简体中文
//        kUserDefaults.set(["zh-hans"], forKey: "AppleLanguages")
//
//        let currLocation = CLLocation(latitude: lat, longitude: lng)
//
//        let geocoder = CLGeocoder()
//        geocoder.reverseGeocodeLocation(currLocation) { (placemark, error) -> Void in
//            if ((placemark?.count) ?? 0) > 0 {
//                let placeMark = placemark?.first
//                placeMarkClosure(placeMark ?? CLPlacemark())
//            }
//
//            kUserDefaults.set(userDefaultLanguages, forKey: "AppleLanguages")
//        }
//    }
    //弹出alert弹框
    class func showAlertView(message:String,successBlock:@escaping ClickClosure){
        let alertView = UIAlertController.init(title: message, message: "", preferredStyle: .alert)
        let cancel = UIAlertAction.init(title: "取消", style: .cancel, handler: nil)
        let defult = UIAlertAction.init(title: "确定", style: .default, handler: { (action) in
            successBlock()
        })
        alertView.addAction(cancel)
        alertView.addAction(defult)
        topViewController().navigationController?.present(alertView, animated: true, completion: nil)
    }
//     //弹出分享
//    class func showShare(title:String,text:String,webUrl:String,image:String, isOrderShare:Bool = false){
//        _ = showShareWithBlock(title: title, text: text, webUrl: webUrl, image: image)
//    }
//
//    class func showShareWithBlock(title:String,text:String,webUrl:String,image:String, isOrderShare:Bool = false)->ShareView{
//        let vi = ShareView.viewFromXib() as! ShareView
//        vi.frame = CGRect(x: 0, y: -kTabBarHeight+49, width: JWidth, height: JHeight)
//        vi.shareTitle = title
//        vi.shareText = text
//        vi.shareImage = image
//        vi.shareUrl = webUrl
//        vi.isOrderShare = isOrderShare
//        vi.show()
//        //白底
//        let button2 = UIButton()
//        button2.backgroundColor = UIColor.init(white: 0.94, alpha: 1.0)
//        vi.addSubview(button2)
//        button2.snp.makeConstraints { (make) in
//            make.left.equalTo(0)
//            make.right.equalTo(vi)
//            make.top.equalTo(vi.snp.bottom)
//            make.bottom.equalTo(UIApplication.shared.keyWindow!.bottom)
//        }
//        return vi
//    }
//
//    //弹出分享
//    class func showOrderShare(showType:ShowType,shareBtnClickBlock:@escaping ClickClosure){
//        let vi = OrderShareView.viewFromXib() as! OrderShareView
//        vi.frame = JRect
//        vi.show(showType: showType, shareBtnClickBlock: shareBtnClickBlock)
//    }
 
    /**----------------版本比较---------------------**/
    //比较当前版本
    class func compareCurVersion(versionStr:String) -> VersionResult{
        let currentVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
        return versionCompare(v1: versionStr, v2: currentVersion)
    }
    
   //版本比较
   class func versionCompare(v1:String,v2:String) -> VersionResult {
        //判断合法性
        if checkSeparat(vString: v1) == "" || checkSeparat(vString: v2) == ""{
            return .unknown
        }
        //获得两个数组
        var v1Arr = cutUpNumber(vString: v1) as! [String]
        if v1Arr.count == 2 {
            v1Arr.append("0")
            v1Arr.append("0")
        } else if v1Arr.count == 3{
            v1Arr.append("0")
        }
        var v2Arr = cutUpNumber(vString: v2) as! [String]
        if v2Arr.count == 2 {
            v2Arr.append("0")
            v2Arr.append("0")
        }else if v2Arr.count == 3{
            v2Arr.append("0")
        }
        //比较版本号
        return compareNumber(v1Arr: v1Arr, v2Arr: v2Arr)
    }
    
    //提取连接符
   class func checkSeparat(vString:String) -> String {
        var separated:String = ""
        if vString.contains("."){  separated = "." }
        if vString.contains("-"){  separated = "-" }
        if vString.contains("/"){  separated = "/" }
        if vString.contains("*"){  separated = "*" }
        if vString.contains("_"){  separated = "_" }
        
        return separated
    }
    //提取版本号
   class func cutUpNumber(vString:String) -> NSArray {
        let  separat = checkSeparat(vString: vString)
        let b = NSCharacterSet(charactersIn:separat) as CharacterSet
        let vStringArr = vString.components(separatedBy: b)
        return vStringArr as NSArray
    }
    
    //比较版本
    class func compareNumber(v1Arr:[String],v2Arr:[String]) -> VersionResult {
        for i in 0..<v1Arr.count{
            if  Int(v1Arr[i])! != Int(v2Arr[i])! {
                if Int(v1Arr[i])! > Int(v2Arr[i])! {
                    return .ascend
                }else{
                    return .descend
                }
            }
        }
        return .equal
    }
  
//    //获取服务器地址
//    class func getHostData(success:@escaping ClickClosure,fail:@escaping FailClosure){
//        if Constants.openSwitchHost {
//            Alamofire.request(Get_Host,method:.get,parameters:nil,encoding:JSONEncoding.default).responseJSON { response in
//                if(response.result.isSuccess){
//                    let result = JSON(response.result.value!)
//                    handleHostData(data: result)
//                    success()
//                }else{
//
//                    SVProgressHUD.showError(withStatus:Constants.kNetWorkError)
//                }
//            }
//        } else{
//            success()
//        }
//    }
     
    
//    //注册UUID
//    class func registerUUID(){
//        let uuid = kUserDefaults.value(forKey: kUUID) as? Bool ?? false
//        if uuid == false {
//            if uuidTotalTime > 100 { // 最多重复10次
//                return
//            }
//            RequestUtil.post(APIConst.HOST_registerUUID, params: ["source":0,"appId":Constants.STOREAPPID,"uuid":getUUIDByKeyChain(),"uniKey":md5String(str: Constants.qfID)], successHandler: { (data) in
//
//                kUserDefaults.setValue(true, forKey: kUUID)
//
//            }) { (err) in
//                if err != "已安装过" {
//                    UtilTool.dispatchAfter(seconds: 10, action: {
//                        uuidTotalTime = uuidTotalTime + 10
//                        registerIDFA()
//                    })
//                }else{
//                    kUserDefaults.setValue(true, forKey: "kUUID")
//                }
//            }
//        }
//    }
  
    
    
    //保存用户的当前地理位置
//    class func saveUserCurAddressInfo(lat:Double, lng:Double){
//        //保存用户经纬度
//        UserDefaults.standard.set(lat, forKey: kCurLatitude)
//        UserDefaults.standard.set(lng, forKey: kCurLongitude)
//    }
//    class func getUserCurAddressInfo()->[Double]{
//        //保存用户经纬度
//        let curLat = UserDefaults.standard.double(forKey: kCurLatitude)
//        let curLng = UserDefaults.standard.double(forKey: kCurLongitude)
//        return [curLat,curLng];
//    }
//
 
    //得到文件路径
    class func getFilePath(_ fileName:String) ->String {
        return NSHomeDirectory()+"/Documents/"+fileName
    }
    //保存数据于某文件
    class func saveDicToFile(dic:NSDictionary,fileName:String){
        dic.write(toFile: getFilePath(fileName), atomically: true)
    }
    //取出某文件的数据
    class func getDicToFile(_ fileName:String) -> NSDictionary?{
        let filePath:String = UtilTool.getFilePath(fileName)
        if FileManager.default.fileExists(atPath: filePath){
            return NSDictionary.init(contentsOfFile: filePath)!
        }else {
            return nil;
        }
    }
    //移除某文件
    class func removeDicFile(_ fileName:String){
        let filePath : String = UtilTool.getFilePath(fileName)
        if FileManager.default.fileExists(atPath: filePath){
            //如果有文件则删除
            try! FileManager.default.removeItem(atPath: filePath)
        }
    }
    
    //跳转控制器
    class func pushViewController(vc:UIViewController) {
        self.topViewController().navigationController?.pushViewController(vc, animated: true)
    }
    
    
    class func popViewController() {
        self.topViewController().navigationController?.popViewController(animated: true)
    }
    class func popToRootViewController() {
        self.topViewController().navigationController?.popToRootViewController(animated: true)
    }
    class func popToViewController(childVcCls:AnyClass) {
    
        for childVc in self.topViewController().navigationController!.childViewControllers {
            
            if childVc.isKind(of: childVcCls.self) {  self.topViewController().navigationController?.popToViewController(childVc, animated: true)
            }
        }
        
    }
    class func handleLocationError(_ error: Error!,handleResult:ClickClosure?){
        let errMsg = error.localizedDescription
        if errMsg.contains("错误 1") || errMsg.contains("错误1") || errMsg.contains("error1") || errMsg.contains("error 1"){
            handleResult?()
            showGoLocationAlert()
        }
    }
    class func showGoLocationAlert(){
//       AlertViewManager.showAlertView(title: locationUnauthodMsg, message: "请进入系统【设置】>【隐私】>【定位服务】中打开开关，并允许大众工匠使用定位服务", cancelTitle: "暂不", confirmTitle: "立即开启", handler: {
//           let url = URL(string: UIApplicationOpenSettingsURLString)
//           if UIApplication.shared.canOpenURL(url!) {
//               UIApplication.shared.openURL(url!)
//           }
//       }, cancelHandler: {
//
//       })
    }
     
    //显示xib视图
    class func getVcBySbAndVcName(sb:String,vc:String) -> UIViewController{
        return UIStoryboard(name: sb, bundle: nil).instantiateViewController(withIdentifier: vc)
    }
    class func handleAddressStr(address:JSON)->String{
        var addressStr = ""
        if address["province"].stringValue.hasSuffix("市") {
            addressStr = "\(address["province"].stringValue)\(address["area"].stringValue)\(address["accurateAddress"].stringValue)\(address["detailAdress"].stringValue)"
        }else{
            addressStr = "\(address["province"].stringValue)\(address["city"].stringValue)\(address["area"].stringValue)\(address["accurateAddress"].stringValue)\(address["detailAdress"].stringValue)"
        } 
        return addressStr
    }
    //获取当前控制器
    class func topViewController() -> UIViewController { 
        let window = UIApplication.shared.delegate?.window
        return topViewControllerWithRootViewController(rootViewController: window!!.rootViewController!)
    }
   
    class func topViewControllerWithRootViewController(rootViewController:UIViewController) -> UIViewController {
        if rootViewController.isKind(of: UITabBarController.self) {
            let tabBarController : UITabBarController = rootViewController as!UITabBarController
            return topViewControllerWithRootViewController(rootViewController: tabBarController.selectedViewController!)
        }
        else if rootViewController.isKind(of: UINavigationController.self){
            let navigationController : UINavigationController = rootViewController as!UINavigationController
            return topViewControllerWithRootViewController(rootViewController: navigationController.visibleViewController!)
        }
        else if (rootViewController.presentedViewController != nil){
            let presentedViewController : UIViewController = rootViewController.presentedViewController!
            return topViewControllerWithRootViewController(rootViewController: presentedViewController)
        }
        else{
            return rootViewController
        }
    }
    
    //验证码倒计时
    class func openCountDown(codeBtn:UIButton,first:TimeInterval=Date().timeIntervalSince1970){
        // 在global线程里创建一个时间源
        let queue = DispatchQueue.global()
        // 设定这个时间源是每秒循环一次，立即开始
        let timer = DispatchSource.makeTimerSource(flags: [], queue: queue)
        timer.schedule(deadline: .now(), repeating: .seconds(1))
        // 设定时间源的触发事件
        timer.setEventHandler {
            // 时间到了取消时间源
            if Int(Date().timeIntervalSince1970-first)==60 {
                timer.cancel()
                DispatchQueue.main.async {
                    codeBtn.setTitle("获取验证码", for: .normal)
//                    codeBtn.setTitleColor(Constants.k74Color, for: .normal)
//                    codeBtn.layer.borderColor=Constants.k74Color.cgColor
                    codeBtn.isUserInteractionEnabled = true
                    codeBtn.isEnabled=true
                }
            }else{
                let seconds = 59-Int(Date().timeIntervalSince1970-first) % 60
                DispatchQueue.main.async {
                    codeBtn.setTitle( "\(seconds)s后重发", for: .normal)
//                    codeBtn.setTitleColor(Constants.k74Color, for: .normal)
//                    codeBtn.layer.borderColor=Constants.k74Color.cgColor
                    codeBtn.isUserInteractionEnabled = false
                }
            }
        }
        timer.resume()
        
    }
    
    class func dispatchAfter(seconds:Double,action:@escaping ClickClosure) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            action()
        }
    }
    
   
    
    /// 释放当前界面并push一个新界面
    /// - Parameters:
    ///   - currentVc: 当前界面
    ///   - nextVc: 新界面
//    class func removeAndPush(currentVc:UIViewController,nextVc:UIViewController){
//        let navArr = NSMutableArray()
//        navArr.addObjects(from: (self.topViewController().navigationController?.viewControllers)!)
//        navArr.remove(currentVc)
//        navArr.add(nextVc)
//        self.topViewController().navigationController?.setViewControllers(navArr as! [UIViewController], animated: true)
//    }
//    
    /// 移除当前界面
    /// - Parameters:
    ///   - currentVc: 当前界面
    class func removeVc(currentVc:UIViewController){
        let navArr = NSMutableArray()
        navArr.addObjects(from: (self.topViewController().navigationController?.viewControllers)!)
        navArr.remove(currentVc)
        self.topViewController().navigationController?.setViewControllers(navArr as! [UIViewController], animated: true)
    }

   //MARK:/************视频方法封装***********/
    // 获取本地视频保存目录
    class func getVideoFilePath()->String {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                                .userDomainMask,true)[0]
        let videoPath = "\(documentsPath)/video"
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: videoPath){
            do {
                try fileManager.createDirectory(atPath: videoPath, withIntermediateDirectories: true, attributes: nil)
            } catch _ {
            }
        }
        return videoPath
    }
    //判断
    class func getParamsWithUrlString(_ string: String) -> [String:String] {
        if string.contains("?") {
            let paramStr = string.components(separatedBy: "?").last
            let paramsArr = paramStr?.components(separatedBy: "&") ?? []
            if paramsArr == [] {
                return [:]
            }
            var paramsDic:[String:String] = [:]
            for param in paramsArr {
                if param.contains("=") {
                    let kv = param.components(separatedBy: "=")
                    let key = String(kv.first ?? "").removingPercentEncoding!.trimmingCharacters(in: .whitespaces)
                    let value = String(kv.last ?? "").removingPercentEncoding!.trimmingCharacters(in: .whitespaces)
                    
                    if key != "" {
                        paramsDic[key] = value
                    }
                }
            }
            return paramsDic
        }
        return [:]
    }
 
    //获得url中参数
    class public func urlStringtoParams(_ urlString:String) -> [String: Any] {
        // 1 保存参数
        var url_array = [""]
        // 2 内容中是否存在?或者//
        if urlString.contains("?") {
            url_array = urlString.components(separatedBy:"?")
        }else{
            url_array = urlString.components(separatedBy: "//")
        }
        // 3 多个参数，分割参数
        let urlComponents = url_array[1].components(separatedBy: "&")
        // 4 保存返回值
        var params = [String: Any]()
        // 5 遍历参数
        for keyValuePair in urlComponents {
            // 5.1 分割参数 生成Key/Value
            let pairComponents = keyValuePair.components(separatedBy:"=")
            // 5.2 获取数组首元素作为key
            let key = pairComponents.first?.removingPercentEncoding
            // 5.3 获取数组末元素作为value
            let value = pairComponents.last?.removingPercentEncoding
            // 5.4 判断参数是否是数组
            if let key = key, let value = value {
                // 5.5 已存在的值，生成数组
                if let existValue = params[key] {
                    // 5.8 如果是已经生成的数组
                    if var existValue = existValue as? [Any] {
                        // 5.9 把新的值添加到已经生成的数组中去
                        existValue.append(value)
                        params[key] = existValue
                    } else {
                        // 5.7 已存在的值，先将他生成数组
                        params[key] = [existValue, value]
                    }
                } else {
                    // 5.6 参数是非数组
                    params[key] = value
                }
            }
        }
        return params
    }
    
   
   
  
    /// 重新登录
    class func handleOutdateApiRequest(){

        RequestUtil.cancleAllRequest()
        SVProgressHUD.dismiss()
        AccountManager.shared.logout()

        AlertViewManager.showAlertView(title: "提示", message: "登录过期，请重新登录", confirmTitle: "重新登录", handler: {
            UtilTool.topViewController().navigationController?.popToRootViewController(animated: false)
            if UtilTool.topViewController().navigationController?.tabBarController?.selectedIndex != Constants.mineVcTabbarIndex {
               UtilTool.topViewController().navigationController?.tabBarController?.selectedIndex = Constants.mineVcTabbarIndex
            }
            UtilTool.topViewController().navigationController?.pushViewController(UtilTool.getVcBySbAndVcName(sb: "login", vc: "login"), animated: true)
         })
    }
    
    
        
        
//    class func reverseGeocodeLocation(coordinate:CLLocationCoordinate2D,success:@escaping DataClosure,fail:@escaping FailClosure){
//        RequestUtil.post(APIConst.HOST_getMsgByLatLng, params: ["lat":coordinate.latitude,"lng":coordinate.longitude], successHandler: { (object) in
//            success(JSON(UtilTool.getDictionaryFromJSONString(jsonString: object["data"].stringValue)))
//        }, failHandler: { (error) in
//            fail(error)
//        })
////         let geocoder = CLGeocoder()
////         let marsLocationP = TQLocationConverter.transformFromBaidu(toGCJ: coordinate)
////
////        //         let earthLocationP = TQLocationConverter.transformFromGCJ(toWGS:marsLocationP)
////
////         let location = CLLocation(latitude:marsLocationP.latitude, longitude:marsLocationP.longitude)
////
////         //  逆地址解析
////         geocoder.reverseGeocodeLocation(location) { (placemark, error) -> Void in
////             if ((placemark?.count) ?? 0) > 0 {
////                 successHandler?(placemark!.first)
////             }
////         }
//    }
     
    //清除网页缓存
    class func clearWebCache() {
        
        let dateFrom: NSDate = NSDate.init(timeIntervalSince1970: 0)
        
        if #available(iOS 9.0, *) {
            
            let websiteDataTypes: NSSet = WKWebsiteDataStore.allWebsiteDataTypes() as NSSet
            
            WKWebsiteDataStore.default().removeData(ofTypes: websiteDataTypes as! Set<String>, modifiedSince: dateFrom as Date) {
                
                print("清空缓存完成")
                
            }
            
        } else {
            
            let libraryPath = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0]
            
            let cookiesFolderPath = libraryPath.appendingFormat("/Cookies")
            
            let errors: NSError
            
            try? FileManager.default.removeItem(atPath: cookiesFolderPath)
            
        } 
    }
    
}


 

func address<T: AnyObject>(o: T) -> String {
    return String.init(format: "%018p", unsafeBitCast(o, to: Int.self))
}

//--debug模式下全局打印，release下无效--
func JPrint<item>(msg: item,
               logError: Bool = false,
               file: String = #file,
               method: String = #function,
               line: Int = #line)
{
    if logError {
        print("\((file as NSString).lastPathComponent)[\(line)], \(method): \(msg)")
    } else {
        #if DEBUG
        print("\((file as NSString).lastPathComponent)[\(line)], \(method): \(msg)")
        #endif
    }
}
