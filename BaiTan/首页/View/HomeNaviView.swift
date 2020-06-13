//
//  HomeNaviView.swift
//  BaiTan
//
//  Created by yanqunchao on 2020/6/6.
//  Copyright © 2020 yanqunchao. All rights reserved.
//

import UIKit

class HomeNaviView: UIView {
    var titleBtnArr = [UIButton]()
    var selTitleBtnIndex = 0
    var selectBtnIndexClosure:IntClosure?
    lazy var dotView:UIView = {
        let dotView = UIView(frame: CGRect(x: 0, y: 0, width: 13, height: 4)).cornerRadius(2).backgroundColor(Constants.k33Color)
        return dotView
    }()
    var marqueeView:MarqueeView!
    
    lazy var segmentHeaderView:UIView = {
      self.titleBtnArr.removeAll()

      let btnHeight:CGFloat = 32
      let headerView =  UIView(frame: CGRect(x: 0, y: 0, width: JWidth, height: btnHeight))
      let btnWidth:CGFloat = 100
      var titleArr = ["发现好货","附近动态"]
       
      let startX  =  (JWidth - CGFloat(titleArr.count) * btnWidth) / 2
        
        for (i,title) in titleArr.enumerated() {
        let btn = UIButton()
            .titleColor(Constants.k33Color)
            .adjustsImageWhenHighlighted(false)
            .title(title)
            .addAction {[weak self] (btn) in
                self?.setCurSelBtn(index: i)
            }
            .frame(CGRect(x: btnWidth * CGFloat(i) + startX, y: 0, width: btnWidth, height: btnHeight))
            self.titleBtnArr.append(btn)
            headerView.addSubview(btn)
      }
        headerView.addSubview(self.dotView)
        self.dotView.top = headerView.height - 0.5
      setCurSelBtn(index: self.selTitleBtnIndex)
      return headerView
    }()
    func setCurSelBtn(index:Int) {
        self.selTitleBtnIndex = index
        selectBtnIndexClosure?(self.selTitleBtnIndex) 
        for (btnIndex,titleBtn) in self.titleBtnArr.enumerated() {
            if index == btnIndex {
                titleBtn.textFont(UIFont.systemFont(ofSize: 22,weight: .bold)).isSelected(true).dispose()
                self.dotView.centerX = titleBtn.centerX
            } else {
                titleBtn.textFont(UIFont.systemFont(ofSize: 18,weight: .regular)).isSelected(false).dispose()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(white: 1, alpha: 0.01)
        
        let upView = UIView(frame: CGRect(x: 0, y: 0, width: JWidth, height: 88 + Constants.fixNaviBarHeight)).cornerRadius(20, [.bottomLeft,.bottomRight])
        upView.backgroundColor = Constants.APP_MAIN_COLOR
        self.addSubview(upView)
       
        let inputView = UIButton(frame: CGRect(x: 20, y: upView.bottom - 15, width: JWidth - 40, height: 42)).cornerRadius(21).shadowOffset(CGSize(width: 0, height: 1)).shadowColor(Constants.k99Color).shadowOpacity(0.3)
        inputView.backgroundColor = .white
        self.addSubview(inputView)
        
        self.marqueeView = (MarqueeView.viewFromXib() as! MarqueeView)
        self.marqueeView.frame = inputView.bounds
        inputView.addSubview(marqueeView)
        
        segmentHeaderView.bottom = inputView.top - 20
        self.addSubview(segmentHeaderView)
              
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
