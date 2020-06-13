//
//  YQCAlertView.swift
//  LynxIOS
//
//  Created by admin on 2019/3/12.
//  Copyright © 2019 Global Hengtong (Beijing) Technology Co., Ltd. All rights reserved.
//

import UIKit
enum AlertViewShowFromDirection: Int  {
      case Left = 0
      case Right = 1
      case Top = 2
      case Bottom = 3
}
  
class YQCAlertView: UIView {
    var contentView: UIView!
    var showAnimationClosure:ClickClosure?
    var dismissAnimationClosure:ClickClosure?
    var showAnimationTime:Double = 0.5
    var showFromDirection:AlertViewShowFromDirection = .Bottom
  
    var showInView:UIView?{
        didSet{
            if showInView == nil {
                UIApplication.shared.keyWindow?.addSubview(self)
            }else{
                showInView?.addSubview(self)
            }
        }
    } 
    init(frame: CGRect,contentView:UIView) {
        super.init(frame: frame)
        self.addSubview(contentView)
        self.contentView = contentView
        self.backgroundColor = UIColor.init(white: 0, alpha: 0.3)
        UIApplication.shared.keyWindow?.addSubview(self)
        self.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        let touch = touches.first
        if self.contentView.frame.contains((touch?.location(in: self))!){
            return
        }
        dismiss()
    }
    
    //关闭本页面
    func dismiss(){
        if self.showFromDirection == .Bottom {
            if self.contentView.transform != CGAffineTransform(translationX: 0, y: JHeight - self.contentView.height) {
                return
            }
            UIView.animate(withDuration: showAnimationTime, animations: {
                self.contentView.transform = CGAffineTransform(translationX: 0, y: JHeight)
                self.dismissAnimationClosure?()
            }) { (finished) in
                self.isHidden = true
            }
        }else{
            if self.contentView.transform != CGAffineTransform(translationX: 0, y: 0) {
                return
            }
            UIView.animate(withDuration: showAnimationTime, animations: {
                self.contentView.transform = CGAffineTransform(translationX: -self.contentView.width, y: 0)
                self.dismissAnimationClosure?()
            }) { (finished) in
                self.isHidden = true
            }
        }
    }
    
    //展示本页面
    public func show(){
        if self.showFromDirection == .Bottom {
            if self.contentView.transform == CGAffineTransform(translationX: 0, y: 0){
                self.contentView.transform = CGAffineTransform(translationX: 0, y: JHeight)
            }
            self.isHidden = false
            UIView.animate(withDuration: showAnimationTime, animations: {
                self.contentView.transform = CGAffineTransform(translationX: 0, y: JHeight - self.contentView.height)
                self.showAnimationClosure?()
            }) { (finished) in
            }
        }else{
            if self.contentView.transform == CGAffineTransform(translationX: 0, y: 0){
                self.contentView.transform = CGAffineTransform(translationX: -self.contentView.width, y: 0)
            }
            self.isHidden = false
            UIView.animate(withDuration: showAnimationTime, animations: {
                self.contentView.transform = CGAffineTransform(translationX: 0, y: 0)
                self.showAnimationClosure?()
            }) { (finished) in
            }
        } 
    }
}
