//
//  YQCAlertContentView.swift
//  LynxIOS
//
//  Created by admin on 2019/3/12.
//  Copyright © 2019 Global Hengtong (Beijing) Technology Co., Ltd. All rights reserved.
//

import UIKit

class YQCAlertContentView: UIView {
    private var parentView:YQCAlertView!
    var showAnimationClosure:ClickClosure? {
        didSet {
            self.parentView.showAnimationClosure = showAnimationClosure
        }
    }
    var dismissAnimationClosure:ClickClosure? {
        didSet {
            self.parentView.dismissAnimationClosure = dismissAnimationClosure
        }
    }
    var showInView:UIView?{
        didSet{
            parentView.showInView = showInView
        }
    }
    func show() {
        self.parentView.show()
    }
    func dismiss() {
        self.parentView.dismiss()
    }
    
    init(frame: CGRect,showFromDirection:AlertViewShowFromDirection = .Bottom,showAnimationTime:Double = 0.5) {
        super.init(frame: frame)
        parentView = YQCAlertView(frame: kWindowFrame,contentView:self)
        parentView.showAnimationTime = showAnimationTime
        parentView.showFromDirection = showFromDirection
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    } 
}
