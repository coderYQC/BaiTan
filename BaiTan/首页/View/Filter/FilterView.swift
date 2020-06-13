//
//  FilterView.swift
//  BaiTan
//
//  Created by yanqunchao on 2020/6/11.
//  Copyright © 2020 yanqunchao. All rights reserved.
//

import UIKit
let filterWords:[String] = ["综合排序","品类","速度","全部筛选"]
var btns:[CustomFilterBtn] = []
class FilterView: UIView {
    var selectedFilterBtnClosure:((CustomFilterBtn)->())?
    override init(frame: CGRect) {
        super.init(frame: frame)
        for (i,word) in filterWords.enumerated() {
            let w = (JWidth - 20) / 4
            let btn = CustomFilterBtn(frame: CGRect(x: 10 + CGFloat(i) * w, y: 0, width: w, height: kFilterViewH))
            btn.isSelected = false
            btn.isContentCenter = (i == 1 || i == 2)
            btn.hasValue = (i == 0)
            btn.isDefault = (i != 0)
            btn.tag = i
            btn.title = word
            self.addSubview(btn)
            
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
                print("点击了第\(i)个筛选条件")
                self?.selectedFilterBtnClosure?(btn)
            }
            btns.append(btn)
        }
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
}
