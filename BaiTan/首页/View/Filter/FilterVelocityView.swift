//
//  FilterVelocityView.swift
//  BaiTan
//
//  Created by yanqunchao on 2020/6/11.
//  Copyright © 2020 yanqunchao. All rights reserved.
//

import UIKit
let kFilterBottomBtnTitles = ["重置","确定"]
let kDistanceTitles = ["30分钟内","40分钟内","50分钟内","60分钟内","1km内","2km内","3km内","5km内"]

let kBtnH:CGFloat = 30
let kBtnHSpace:CGFloat = 8
let kBtnVSpace:CGFloat = 8
let kMargin:CGFloat = 10


class FilterVelocityView: BaseFilterView {
     
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        let kBtnW:CGFloat = (JWidth - kBtnHSpace * 2 - kMargin * 3) / 4
        for (i,title) in kDistanceTitles.enumerated() {
            let row:CGFloat = floor(CGFloat(i) / 4)
            let col:CGFloat = floor(CGFloat(i % 4))
            let btn = UIButton().frame(kMargin + col * (kBtnHSpace + kBtnW),16 +  (kBtnVSpace + kBtnH) * row, kBtnW, kBtnH).title(title).textFont(13).showsTouchWhenHighlighted(false).titleColor_Sel(.white).titleColor(Constants.k66Color).backgroundColor(Constants.kBtnDisableColor).cornerRadiusWithClip(3).addAction { (btn) in
                btn.isSelected = !btn.isSelected
                btn.backgroundColor( btn.isSelected ? Constants.APP_MAIN_COLOR : Constants.kBtnDisableColor).dispose()
            }
            self.addSubview(btn)
        }
         
        for (i,title) in kFilterBottomBtnTitles.enumerated() {
            UIButton(frame: CGRect(x: CGFloat(i) * JWidth / 2, y: height - 45, width: JWidth / 2, height: 45))
                .title(title)
                .textFont(UIFont.systemFont(ofSize: 17, weight: i == 0 ? .regular : .semibold))
                .titleColor(Constants.k33Color)
                .backgroundColor(i == 0 ? .white : Constants.APP_MAIN_COLOR)
                .superView(self)
                .addTap { (_) in
                    
            }
             
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
