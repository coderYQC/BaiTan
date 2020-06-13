//
//  CustomFilterBtn.swift
//  BaiTan
//
//  Created by yanqunchao on 2020/6/11.
//  Copyright © 2020 yanqunchao. All rights reserved.
//

import UIKit

class CustomFilterBtn: UIView {
    var textLabel:UILabel!
    var imageView:UIImageView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    func setupView(){
        self.textLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 10, height: self.height)).font(UIFont.systemFont(ofSize: 13)).textColor(Constants.k66Color).textAlignment(.left)
        self.addSubview(self.textLabel)
        self.imageView = UIImageView(frame: CGRect(x: self.textLabel.right + 6, y: 0, width: 10, height: self.height)).image("filterDown").contentMode(.scaleAspectFit)
        self.addSubview(self.imageView)
    }
    
    var title:String = ""{
        didSet{
            self.textLabel.text = title
            if self.isDefault || !self.hasValue {
                self.hasValue = false
            }else{
                self.hasValue = true
            }
            self.textLabel.sizeToFit()
            self.textLabel.height = self.height
            
            if self.isContentCenter {
                self.textLabel.left = (self.width - self.textLabel.width - self.imageView.width) / 2
            }else{
                self.textLabel.left = 0
            }
            self.imageView.left = self.textLabel.right + 10
        }
    }
    var isContentCenter:Bool = false
    
    var isSelected:Bool = false{
        didSet{
            if isSelected{
                self.textLabel.font(UIFont.systemFont(ofSize: 13, weight: .semibold)).textColor(Constants.k33Color).dispose()
                self.imageView.image("filterUp").dispose()
            }else{ 
                self.textLabel.font(UIFont.systemFont(ofSize: 13, weight: isDefault ? .regular : .semibold)).textColor(Constants.k66Color).dispose()
                self.imageView.image("filterDown").dispose()
            }
        }
    }
    var isDefault:Bool = true
    var hasValue:Bool = false{
        didSet{
            if hasValue {
                self.textLabel.font(UIFont.systemFont(ofSize: 13, weight: .semibold)).textColor(Constants.k33Color).dispose()
            }else{
                self.textLabel.font(UIFont.systemFont(ofSize: 13)).textColor(Constants.k66Color).dispose()
            }
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
