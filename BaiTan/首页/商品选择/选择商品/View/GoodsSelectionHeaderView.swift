//
//  GoodsSelectionHeaderView.swift
//  BaiTan
//
//  Created by yanqunchao on 2020/6/15.
//  Copyright © 2020 yanqunchao. All rights reserved.
//

import UIKit
let kGoodsSelectionSegmentTitleArr = ["点菜","评价","商家"]

class GoodsSelectionHeaderView: UIView {
    
    var titleBtnArr = [UIButton]()
    var selTitleBtnIndex = 0
    var selectBtnIndexClosure:IntClosure?
    var btnCenterDistance:CGFloat = 0
    var dotCenterX:CGFloat = 0
    
    lazy var dotView:UIView = {
        let dotView = UIView(frame: CGRect(x: 0, y: 0, width: 13, height: 2)).backgroundColor(Constants.APP_MAIN_COLOR)
        return dotView
    }()
    
    lazy var segmentHeaderView:UIView = {
      
        let headerView =  UIView(frame: CGRect(x: 0, y: 0, width: JWidth, height: kGoodsSelectionSegmentH)).backgroundColor(.white)
     
        headerView.addSubview(self.dotView)
      
        let btnHeight:CGFloat = kGoodsSelectionSegmentH
        let btnWidth:CGFloat = 80
        let space:CGFloat = 10
        let startX:CGFloat = 10
 
        self.btnCenterDistance = btnWidth + space
         
        for (i,title) in kGoodsSelectionSegmentTitleArr.enumerated() {
            let btn = UIButton()
                  .frame(CGRect(x: (space + btnWidth) * CGFloat(i) + startX, y: 0, width: btnWidth, height: btnHeight))
                  .titleColor(Constants.k96Color)
                  .titleColor_Sel(Constants.k33Color)
                  .adjustsImageWhenHighlighted(false)
                  .title(title)
                  .textFont(UIFont.DINAlternateBold(size: 16))
                  .addAction {[weak self] (btn) in
                       self?.setCurSelBtn(index: i)
                  }
                  self.titleBtnArr.append(btn)
                  headerView.addSubview(btn)
            
                  if i == 0 {
                      self.dotView.top = btn.bottom - 2
                      dotCenterX = btn.centerX - self.dotView.width * 0.5
                      self.dotView.centerX = dotCenterX
                  }
            }
            setCurSelBtn(index: self.selTitleBtnIndex)
        return headerView
    }()
    
     func setCurSelBtn(index:Int) {
         self.selTitleBtnIndex = index
         selectBtnIndexClosure?(self.selTitleBtnIndex)
         for (btnIndex,titleBtn) in self.titleBtnArr.enumerated() {
             if index == btnIndex {
                titleBtn.isSelected(true).dispose()
             } else {
                titleBtn.isSelected(false).dispose()
             }
         }
     }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.init(white: 0, alpha: 0)
        self.addSubview(self.segmentHeaderView)
        self.segmentHeaderView.top = kGoodsSelectionTableHeaderViewH - kGoodsSelectionSegmentH
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
