//
//  RequestUtil.swift
//  JupiterDriver
//
//  Created by yanqunchao on 2020/5/18.
//  Copyright © 2020 yanqunchao. All rights reserved.
//

//网络请求封装
import Foundation
import Alamofire
import SwiftyJSON
import DaisyNet
import SVProgressHUD

class RequestUtil: NSObject {
    static let serverError:String!="网络异常，请稍后再试"
    static let uploadError:String!="图片上传失败"
  
    static let sharedSessionManager: Alamofire.SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        return Alamofire.SessionManager(configuration: configuration)
    }()
    
    private override init() {
    }
    
    //post请求
    class func post(_ url:String,params:Parameters,successHandler:@escaping DataClosure,failHandler:@escaping FailClosure,isStop:Bool = false){
//
//        JPrint(msg:"post网络请求的url:\(url),post网络请求的params:\(params)")
        if isStop {
            return
        }
        request(url,  method:.post, params: params, successHandler: successHandler,failHandler: failHandler)
    }
    
    //get请求
    /*
     url:url
     other:接口是否是咱们自己的.other = true 说明是别人的接口
     params:请求体
     successHandler:回调
     failHandler:回调
     */
    class func get(_ url:String,other:Bool = false, params:Parameters,successHandler:@escaping DataClosure,failHandler:@escaping FailClosure){
        request(url,other:other, method: .get, params: params, successHandler: successHandler,failHandler: failHandler)
        JPrint(msg:"post网络请求的url:\(url),post网络请求的params:\(params)")
    }
 
    class func request(_ url:String,other:Bool = false, method:HTTPMethod = .get,params:Parameters,cacheFile:String="",isOriginData:Bool = false,successHandler: @escaping DataClosure,failHandler: @escaping FailClosure={_ in }){
        var headers:HTTPHeaders=HTTPHeaders()
        headers.updateValue(Constants.sessionId, forKey: Constants.userSessionId)
        headers.updateValue("application/json", forKey: "Content-Type")
         
        if method == .post {
            sharedSessionManager.request(url,method:method,parameters:params,encoding:JSONEncoding.default,headers:headers).responseJSON { response in
                JPrint(msg:"post网络请求的url:\(url)")
                JPrint(msg:"post网络请求的params\(params)")
                
                if(response.result.isSuccess){
                    let result = JSON(response.result.value!)
                    if other == false {
                        if result[Constants.returnCode].stringValue != "\(Constants.returnCodeEnum.SUCCESS)" {
                            JPrint(msg: "response===\(response)")
                            let errMsg = result[Constants.returnMsg].stringValue == "" ? serverError : result[Constants.returnMsg].stringValue
                            if errMsg == kLoginOutdateErrMsg || errMsg == kLoginOutdateErrMsg2 {
                                UtilTool.handleOutdateApiRequest()
                            }else{
                               failHandler(errMsg!)
                            }
                        }else{
                            successHandler(result)
                        }
                    } else {
                        
                    }
                }else{
                    JPrint(msg: "response===\(response)")
                    failHandler(serverError)
                }
            }
            
        } else if method == .get {
            var paramsStr = ""
            for (index,dic) in params.enumerated() {
                if index == 0 {
                    paramsStr += "?\(dic.key)=\(dic.value)"
                } else {
                    paramsStr += "&\(dic.key)=\(dic.value)"
                }
            }
            let fullUrl = url + paramsStr
            Alamofire.request(fullUrl,method:method,parameters:nil).responseJSON { response in
                if(response.result.isSuccess){
                    let result = JSON(response.result.value!)
                    if other == true {
                        if result["success"].boolValue == true {
                            successHandler(result)
                        }else{
                            let errMsg = result["msg"].stringValue == "" ? serverError : result["msg"].stringValue
                            failHandler(errMsg!)
                        }
                    } else {
                        if result[Constants.returnCode].stringValue != "\(Constants.returnCodeEnum.SUCCESS)" {
                            let errMsg = result[Constants.returnMsg].stringValue == "" ? serverError : result[Constants.returnMsg].stringValue
                            if errMsg == kLoginOutdateErrMsg || errMsg == kLoginOutdateErrMsg2 {
                                UtilTool.handleOutdateApiRequest()
                            }else{
                                failHandler(errMsg!)
                            }
                        }else{
                            successHandler(result)
                        }
                    }
                }else{
                    failHandler(serverError)
                }
            }
        }
    }
    
    /// post发送一段没有key的body
    class func postJson(url:String,body:Array<Any>,successHandler: @escaping DataClosure,failHandler: @escaping FailClosure){
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(Constants.sessionId, forHTTPHeaderField: Constants.userSessionId)
         
        request.httpBody = try! JSONSerialization.data(withJSONObject: body) 
        Alamofire.request(request)
            .responseJSON { response in
                JPrint(msg:"post网络请求的url:\(url)")
            
                if(response.result.isSuccess){
                    let result = JSON(response.result.value!)
                    //                    JPrint(msg: result)
                    JPrint(msg: "post网络请求结果,具体的数据data{}(想看数据打开注释)")
                    if result[Constants.returnCode].stringValue != "\(Constants.returnCodeEnum.SUCCESS)" {
                        let errMsg = result[Constants.returnMsg].stringValue == "" ? serverError : result[Constants.returnMsg].stringValue
                        if errMsg == kLoginOutdateErrMsg || errMsg == kLoginOutdateErrMsg2 {
                            UtilTool.handleOutdateApiRequest()
                        }else{
                            failHandler(errMsg!)
                        }
                    }else{
                        successHandler(result)
                    }
                }else{
                    failHandler(serverError)
                }
        }
    }
    
    /// 带缓存的网络请求
    /// - Parameters:
    ///   - url: url
    ///   - para: 请求参数
    ///   - cache: 是否缓存数据
    ///   - successHandler: 成功后回调
    ///   - failHandler: 失败后回调
    class func requestWithCache(url:String,para:Parameters,cache:Bool,successHandler:@escaping DataClosure,failHandler:@escaping FailClosure){
        JPrint(msg: para)
        var headers:HTTPHeaders=HTTPHeaders()
        headers.updateValue(Constants.sessionId, forKey: Constants.userSessionId)
        headers.updateValue("application/json", forKey: "Content-Type") 
        DaisyNet.request(url, method: .post, params: [:], dynamicParams: para, encoding: JSONEncoding.default, headers: headers).cache(cache).responseCacheAndJson { (response) in
            JPrint(msg:"post网络请求的url:\(url)")
            if response.result.isSuccess{
                //回调函数
                let result = JSON(response.result.value!)
                if result[Constants.returnCode].stringValue != "\(Constants.returnCodeEnum.SUCCESS)" {
                    let errMsg = result[Constants.returnMsg].stringValue == "" ? serverError : result[Constants.returnMsg].stringValue
                    if errMsg == kLoginOutdateErrMsg || errMsg == kLoginOutdateErrMsg2 {
                        UtilTool.handleOutdateApiRequest()
                    }else{
                        failHandler(errMsg!)
                    }
                }else{
                    successHandler(result)
                }
                //数据来源
                if response.isCacheData {
                    JPrint(msg: "数据来自缓存")
                }else{
                    JPrint(msg: "数据来自网络")
                }
                
            }else{
                failHandler(serverError)
            }
        }
    }
    
    class func downloadData(_ url:String, params:Parameters,successHandler: @escaping ((Data?)->()),failHandler: @escaping StringClosure={_ in }){
     
        var headers:HTTPHeaders=HTTPHeaders()
        headers.updateValue(Constants.sessionId, forKey: Constants.userSessionId)
        headers.updateValue("application/json", forKey: "Content-Type")
        
//        var paramsStr = ""
//        for (index,dic) in params.enumerated() {
//            if index == 0 {
//                paramsStr += "?\(dic.key)=\(dic.value)"
//            } else {
//                paramsStr += "&\(dic.key)=\(dic.value)"
//            }
//        }
//        let fullUrl = url + paramsStr
        sharedSessionManager.request(url,method:.post,parameters:params,encoding:JSONEncoding.default,headers:headers).responseData { (response) in
            if response.result.isSuccess {
               let bytes = (response.result.value)
                if bytes == nil {
                    failHandler(Constants.kNetWorkError)
                }else{
                    successHandler(bytes!)
                }
            }else{
                failHandler(Constants.kNetWorkError)
            }
        }
        
    }
    
    //上传图片
    class func upload(_ image:UIImage,successHandler:@escaping DataClosure,failHandler:@escaping FailClosure){
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            //配置图片路径
            multipartFormData.append(
                UIImageJPEGRepresentation(image, 0.1)!,
                withName: "multipartFiles",
                fileName: "head.png",
                mimeType: "image/*")
            multipartFormData.append(Constants.sessionId.data(using: String.Encoding.utf8)!, withName: Constants.userSessionId)
        }, to: APIConst.HOST_imgUpload, method: .post, headers: nil, encodingCompletion: { (encodingResult) in
            JPrint(msg: "上传图片")
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    if(response.result.isSuccess){
                        let result = JSON(response.result.value!)
                        JPrint(msg: result)
                        if result[Constants.returnCode].stringValue != "\(Constants.returnCodeEnum.SUCCESS)" {
                            let errMsg = result[Constants.returnMsg].stringValue == "" ? uploadError : result[Constants.returnMsg].stringValue
                            if errMsg == kLoginOutdateErrMsg || errMsg == kLoginOutdateErrMsg2 {
                                UtilTool.handleOutdateApiRequest()
                            }else{
                                failHandler(errMsg!)
                            }
                        }else{
                            successHandler(result)
                        }
                    }else{
                        failHandler(uploadError)
                    }
                }
            case .failure( _):
                failHandler(uploadError)
                break
            }
        })
    }
    
    //上传视频到服务器
    class func uploadVideo(mp4Path : URL,successHandler:@escaping DataClosure,failHandler:@escaping FailClosure,progressHandler:@escaping AnyClosure){
         
        Alamofire.upload(
            //同样采用post表单上传
            multipartFormData: { multipartFormData in
                multipartFormData.append(mp4Path, withName: "multipartFiles", fileName: "myVideo.mp4", mimeType: "video/mp4")
                multipartFormData.append(Constants.sessionId.data(using: String.Encoding.utf8)!, withName: Constants.userSessionId)
        },to: APIConst.HOST_imgUpload,encodingCompletion: { encodingResult in
            JPrint(msg: "上传视频到服务器")
            switch encodingResult {
            case .success(let upload, _, _):
                //json处理
                upload.responseJSON { response in
                    if(response.result.isSuccess){
                        let result = JSON(response.result.value!)
                        JPrint(msg: result)
                        if result[Constants.returnCode].stringValue != "\(Constants.returnCodeEnum.SUCCESS)" {
                            let errMsg = result[Constants.returnMsg].stringValue == "" ? uploadError : result[Constants.returnMsg].stringValue
                            if errMsg == kLoginOutdateErrMsg || errMsg == kLoginOutdateErrMsg2{
                                UtilTool.handleOutdateApiRequest()
                            }else{
                                failHandler(errMsg!)
                            }
                        }else{
                            successHandler(result)
                        }
                    }else{
                        failHandler(uploadError)
                    }
                }
                //上传进度
                upload.uploadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                    print("视频上传进度: \(progress.fractionCompleted)")
                    progressHandler(String(format: "%.0f", round(progress.fractionCompleted*100)))
                }
            case .failure(let encodingError):
                print(encodingError)
            }
        })
    }
    
    class  func cancleAllRequest() {
        RequestUtil.sharedSessionManager.session.getAllTasks { (urlSessionTask) in
            urlSessionTask.forEach({ (task)in
                task.cancel()
            })
        }
    }
}
