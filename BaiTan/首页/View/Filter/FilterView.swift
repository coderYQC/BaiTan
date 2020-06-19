//
//  FilterView.swift
//  BaiTan
//
//  Created by yanqunchao on 2020/6/11.
//  Copyright © 2020 yanqunchao. All rights reserved.
//

import UIKit
let filterWords:[String] = ["综合排序","品类","速度","全部筛选"]
let filterRecommendWords:[String] = ["30分钟内","满减优惠","减配送费","会员红包"]
var btns:[CustomFilterBtn] = []
let kFilterBtnH:CGFloat = 30
let kFilterRecommendViewH:CGFloat = 45
class FilterView: UIView {
    var selectedFilterBtnClosure:((CustomFilterBtn)->())?
    var filterBtnView:UIView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.filterBtnView = UIView(frame: CGRect(x: 0, y: 0, width: JWidth, height: kFilterBtnH))
        self.addSubview(self.filterBtnView)
        let w = (JWidth - 20 - 30) / 4
        for (i,word) in filterWords.enumerated() {
            let btn = CustomFilterBtn(frame: CGRect(x: 10 + CGFloat(i) * (w + 10), y: 0, width: w, height: kFilterBtnH))
            btn.isSelected = false
            btn.isContentCenter = (i == 1 || i == 2)
            btn.hasValue = (i == 0)
            btn.isDefault = (i != 0)
            btn.tag = i
            btn.title = word
            filterBtnView.addSubview(btn)
            
            btn.addTap {[weak self] (_) in
                for button in btns{
                    if btn != button {
                        button.isSelected = false
                    }
                    if button.isDefault {
                        button.hasValue = false
                    }else{
                        button.hasValue = true
                    }
                }
                btn.isSelected = !btn.isSelected
                
                if btn.isSelected {
                   btn.hasValue = true
                }else{
                   if btn.isDefault {
                       btn.hasValue = false
                   }else{
                       btn.hasValue = true
                   }
                }
//                print("点击了第\(i)个筛选条件")
                self?.selectedFilterBtnClosure?(btn)
            }
            btns.append(btn)
        }
          
        let bottomView = UIView(frame: CGRect(x: 0, y: kFilterBtnH, width: JWidth, height: kFilterRecommendViewH))
        for (i,word) in filterRecommendWords.enumerated() {
       
            let btn = UIButton(frame: CGRect(x: 10 + CGFloat(i) * (w + 10), y: 5, width: w, height: kFilterBtnH)).title(word).textFont(12).titleColor(Constants.k66Color)
                .cornerRadiusWithClip(5)
                .backgroundColor(Constants.kBtnDisableColor)
            bottomView.addSubview(btn)
            
            btn.addTap {[weak self] (_) in
                
            }
        }
        
        self.addSubview(bottomView)
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
}
