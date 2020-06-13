

//
//  MarqueeView.swift
//  LynxIOS
//
//  Created by yanqunchao on 2020/1/14.
//  Copyright © 2020 Global Hengtong (Beijing) Technology Co., Ltd. All rights reserved.
//

import UIKit
import SwiftyJSON
class MarqueeView: UIView,JJMarqueeViewDelegate,JJMarqueeViewDataSource {
    
    let marqueeView = JJMarqueeView.init(frame: CGRect.init(x: 0, y: 0, width: JWidth - 40, height: 36))
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        marqueeView.automaticSlidingInterval = 3
        marqueeView.delegate = self
        marqueeView.dataSource = self
    
        self.addSubview(marqueeView)
    }
    
    var dataArray:[String] = [] {
        didSet{
           marqueeView.reload()
        }
    }
    
    /// MARK: - 跑马灯View 代理 ==========
    func numberOfItems(_ marqueeView: JJMarqueeView) -> Int {
        return dataArray.count
    }
    
    func marqueeView(_ marqueeView: JJMarqueeView, cellForItemAt index: Int) -> NSAttributedString {
        
        let att = NSMutableAttributedString.init(string: dataArray[index])
        return att
    }
    
    func mqrqueeView(_ marqueeView: JJMarqueeView, didSelectCellAt index: Int) {
        print("点击了\(dataArray[index])")
    }
}
