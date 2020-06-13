//
//  CustomAlertView.swift
//  FlashDelivery
//
//  Created by yanqunchao on 2020/5/24.
//  Copyright © 2020 yanqunchao. All rights reserved.
//

import UIKit

class CustomAlertView: UIView {
    @IBOutlet weak var titleLab: UILabel!
    
    @IBOutlet weak var descLab: UILabel!
    
    @IBOutlet weak var largeBtn: UIButton!
    @IBOutlet weak var leftBtn: UIButton!
    
    @IBOutlet weak var rightBtn: UIButton!
    
    var largeBtnClick:ClickClosure?
    var leftBtnClick:ClickClosure?
    var rightBtnClick:ClickClosure?
    override func awakeFromNib() {
        super.awakeFromNib()
        self.largeBtn.isHidden = true
        self.cornerRadiusWithClip(10).dispose()
        self.largeBtn.addTap {[weak self] (_) in
            self?.largeBtnClick?()
        }
        self.leftBtn.addTap {[weak self] (_) in
            self?.leftBtnClick?()
        }
        self.rightBtn.addTap {[weak self] (_) in
            self?.rightBtnClick?()
        }
    }
    
    var title:String = "" {
        didSet{
            self.titleLab.text = title
        }
    }
    
    var message:String = "" {
        didSet{
            self.descLab.text = message
            self.height = message.heightWithFont(font: self.descLab.font, maxWidth: self.width - 40) + 145
        }
    }
    var largeBtnTitle:String = "" {
        didSet{
            self.largeBtn.setTitle(largeBtnTitle, for: .normal)
        }
    }
    var leftBtnTitle:String = "" {
        didSet{
            self.leftBtn.setTitle(leftBtnTitle, for: .normal)
        }
    }
    var rightBtnTitle:String = "" {
        didSet{
            self.rightBtn.setTitle(rightBtnTitle, for: .normal)
        }
    }
}
