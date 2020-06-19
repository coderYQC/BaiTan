//
//  SellerContentView.swift
//  BaiTan
//
//  Created by yanqunchao on 2020/6/17.
//  Copyright © 2020 yanqunchao. All rights reserved.
//

import UIKit
let kSellerName:String = "CoCoNote可可音符（第一档口漂亮广场美食城店）"

class SellerContentView: UIView {
    lazy var backView:UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.width, height: 300)).cornerRadiusWithClip(10)
//        view.addSubview(self.sellerItemView)
        return view
    }()
    
    lazy var frontView:UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.width, height: 300)).cornerRadiusWithClip(10).backgroundColor(.white).alpha(0)
        view.addSubview(self.sellerNameLab1)
        return view
    }()
     
    lazy var sellerIcon:UIButton = {
        let sellerIcon = UIButton(frame: CGRect(x: self.width - 65, y: -22, width: 55, height: 55)).cornerRadius(8).shadowOpacity(0.3).shadowOffset(CGSize(width: 0, height: 1)).shadowColor(Constants.k96Color).backgroundColor(.white).image("sellerIcon")
        sellerIcon.imageView?.cornerRadiusWithClip(9).dispose()
        return sellerIcon
    }()
    lazy var sellerNameLab:UILabel = {
        let lab = UILabel(frame: CGRect(x: 10, y: 10, width: self.width - 85, height: 23)).font(UIFont.systemFont(ofSize: 20, weight: .bold)).textColor(Constants.k33Color)
        return lab
    }()
    lazy var sellerNameLab1:UILabel = {
        let lab = UILabel().origin(CGPoint(x: 10, y: 10)).numberOfLines(2).font(self.sellerNameLab.font).textColor(self.sellerNameLab.textColor)
        lab.width = self.width - 85
        return lab
    }()
    
    lazy var sellerItemView:UIView = {
        let view = UIView(frame: CGRect(x: 10, y: self.sellerNameLab.bottom + 4, width: sellerNameLab1.width, height: 14)).backgroundColor(.red)
        return view
    }()
     
    lazy var upBtn:UIButton = {
        let upBtn = UIButton(frame: CGRect(x: 10, y: self.height - 40, width: self.width - 20, height: 40)).image("upArrow")
        return upBtn
    }()
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.backgroundColor(.white).cornerRadius(10).shadowOpacity(0.2).shadowOffset(CGSize(width: 0, height: 1)).shadowColor(Constants.k96Color).dispose()
        self.addSubview(backView)
        self.addSubview(frontView)
        self.addSubview(self.sellerNameLab)
        self.sellerNameLab1.text = kSellerName
        self.sellerNameLab.text = kSellerName
        self.sellerNameLab.height = "  ".heightWithFont(font: self.sellerNameLab1.font, maxWidth: self.sellerNameLab1.width)
        self.sellerNameLab1.height = kSellerName.heightWithFont(font: self.sellerNameLab1.font, maxWidth: self.sellerNameLab1.width)
        
        self.addSubview(sellerIcon)
        self.addSubview(self.upBtn)
        self.sellerNameLab.text = kSellerName
        self.sellerNameLab1.text = kSellerName
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
