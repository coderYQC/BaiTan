//
//  BaseViewController.swift
//  FlashDelivery
//
//  Created by yanqunchao on 2020/5/18.
//  Copyright © 2020 yanqunchao. All rights reserved.
//
 
import UIKit
import FDFullscreenPopGesture//添加全屏侧滑
import SVProgressHUD
import SnapKit
let kBottomViewPadding:CGFloat = 15

open class BaseViewController: UIViewController {
    
    public var statusBarVi = UIView()
    
    private var startTimeInterval = 0
    
    public var isFirstIn = true
    public var VcHeight:CGFloat?
    var bottomview:UIView?
    
    var clickClosure:(()->())?
    var clickClosure2:(()->())?
    var barItemClickClosure:(()->())?
    var offset:CGFloat = 0
    var bottomViewH:CGFloat {
        return kTabBarHeight + kBottomViewPadding
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        Constants.kVcHeight = self.view.height
        
        let navBarHairlineImageView = self.findHairlineImageViewUnder(sView: self.navigationController!.navigationBar)
        navBarHairlineImageView.isHidden = true
        
        if #available(iOS 11.0, *) { //高于 iOS 11.0
          self.automaticallyAdjustsScrollViewInsets = true
        } else {
          self.automaticallyAdjustsScrollViewInsets = false
        }
        self.setStatusBar()
        
        if navigationController?.viewControllers != nil {
            if (navigationController?.viewControllers.count)! >  1 {
                self.navigationItem.leftBarButtonItem = UIBarButtonItem.barButton(type: .Left, image: UIImage(named:"navi_back")!, target: self, action: #selector(back))
            }
        }
        // 接收状态栏高度发生变化的通知
        NotificationCenter.default.addObserver(self, selector:#selector(adjustStatusBar), name: Notification.Name.UIApplicationDidChangeStatusBarFrame, object: nil)
    }
    
    public func setStatusBar(){
        self.statusBarVi.backgroundColor = UIColor.white
        view.addSubview(statusBarVi)
        self.statusBarVi.snp.makeConstraints { (make) in
            make.width.equalTo(view.width)
            make.height.equalTo(kStatusBarHeight)
            make.centerX.equalTo(view.centerX)
            make.top.equalTo(view.top)
        }
    }
    
    @objc func adjustStatusBar() {
        
    }
    
    override open  func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         
    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
         
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
         
    }
    
    override open  func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
         
    }
    
    //首次加载失败的处理
    public func showLoadFailedViewAtFirstTime() {
        LoadViewManager.showLoadFailedOnView(view: self.view, target: self, action: #selector(loadMainData))
    }
    public func hideLoadFailedView() {
        LoadViewManager.hideLoadView()
    }
    @objc public  func loadMainData(){
        if self.isFirstIn {
            LoadViewManager.showLoadingViewOnView(view: self.view)
        }else{
            SVProgressHUD.show()
        }
    }
    
    public func handleSuccessLoadedView(){
        SVProgressHUD.dismiss()
        if self.isFirstIn {
            self.isFirstIn = false
            self.hideLoadFailedView()
        }
    }
    public func handleFailLoadedView(error:String){
        SVProgressHUD.dismiss()
        if self.isFirstIn {
            self.showLoadFailedViewAtFirstTime()
        }else{
            SVProgressHUD.showError(withStatus: error)
        }
    }
    
    override open func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        var viewHeight = self.view.height
        var tabbarHeight:CGFloat = 0
        if navigationController?.viewControllers != nil &&  (navigationController?.viewControllers.count)! >  1 {
            tabbarHeight = 0
        }else{
            tabbarHeight = Constants.tabBarHeight
        }
        if viewHeight < JHeight - tabbarHeight - ( Constants.isNormalStatusBar ? 0 : 20) {
            viewHeight = JHeight - tabbarHeight - (Constants.isNormalStatusBar ? 0 : 20)
        }
        Constants.kVcHeight = viewHeight
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
//        kNotificationCenter.removeAllNotication(self)
        JPrint(msg: "\(self)释放VC,页面销毁")
    }
     
    func findHairlineImageViewUnder(sView: UIView) ->UIImageView {
           if sView.isKind(of: UIImageView.self) && sView.bounds.height <= 1 {
               return sView as! UIImageView
           }
           for sview in sView.subviews {
               let imgs = self.findHairlineImageViewUnder(sView: sview)
               if imgs.isKind(of: UIImageView.self) && imgs.bounds.height <= 1 {
                   return imgs
               }
           }
           return UIImageView.init()
       }
    
    @objc func back(){
        _ = navigationController?.popViewController(animated: true)
    }
    
    func configureBottomView(btnTitle:String,btnBgColor:UIColor = Constants.kDarkTextColor, action:(()->())?){
        self.clickClosure = action
        self.bottomview = UIView().backgroundColor(.white)

        UIButton(type: .custom).frame(CGRect (x: 15, y: 10, width: JWidth - 30, height: 44)).backgroundColor( Constants.APP_MAIN_COLOR).title(btnTitle).titleColor(.white).textFont(16).cornerRadius(22).superView(self.bottomview!).addTap { (_) in
                          action?()
                      }
        self.view.addSubview(self.bottomview!)

        self.bottomview!.snp.makeConstraints { (make) in
            make.width.equalTo(view.width)
            make.height.equalTo(bottomViewH)
            make.bottom.equalTo(view.bottom).offset(offset)
            make.left.equalTo(view.left)
        }
        let topLine = UILabel().backgroundColor(UIColor(white: 0, alpha: 0.1)).superView(self.bottomview!)
        topLine.snp.makeConstraints { (make) in
            make.width.equalTo(view.width)
            make.height.equalTo(0.5)
            make.top.equalTo(self.bottomview!.top)
            make.left.equalTo(view.left)
        }
    }

    func configureBottomView(btnTitle1:String, action1:(()->())?,btnTitle2:String,action2:(()->())?){

        self.bottomview = UIView().backgroundColor(.white)
        self.view.addSubview(self.bottomview!)
        self.bottomview!.snp.makeConstraints { (make) in
            make.width.equalTo(view.width)
            make.height.equalTo(bottomViewH)
            make.bottom.equalTo(view.bottom).offset(offset)
            make.left.equalTo(view.left)
        }
        let topLine = UILabel().backgroundColor(UIColor(white: 0, alpha: 0.1)).superView(self.bottomview!)
        topLine.snp.makeConstraints { (make) in
            make.width.equalTo(view.width)
            make.height.equalTo(0.5)
            make.top.equalTo(self.bottomview!.top)
            make.left.equalTo(view.left)
        }

        UIButton(type: .custom).frame(CGRect (x: 22, y: 10, width: 114, height: 44)).backgroundColor( .white).title(btnTitle1).titleColor(Constants.APP_MAIN_COLOR).textFont(16).cornerRadius(22).borderColor(Constants.APP_MAIN_COLOR).borderWidth(1).superView(self.bottomview!).addTap { (_) in
                   action1?()
               }

        UIButton(type: .custom).frame(CGRect (x: 144, y: 10, width: JWidth - 166, height: 44)).backgroundColor( Constants.APP_MAIN_COLOR).title(btnTitle2).titleColor(.white).textFont(16).cornerRadius(22).superView(self.bottomview!).addTap { (_) in
                   action2?()
               }

    }
}

