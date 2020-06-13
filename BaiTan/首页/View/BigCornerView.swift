//
//  BigCornerView.swift
//  BaiTan
//
//  Created by yanqunchao on 2020/6/7.
//  Copyright © 2020 yanqunchao. All rights reserved.
//

import UIKit

class BigCornerView: UIView {

    override init(frame:CGRect) {
        super.init(frame: frame)
        let bgView = UIView(frame: CGRect(x: 0, y: 0, width: JWidth, height: 30 + Constants.fixNaviBarHeight))
        bgView.backgroundColor = Constants.APP_MAIN_COLOR
        self.addSubview(bgView)
        let upView = UIView(frame: CGRect(x: -JWidth * 5 * 0.5, y: 0, width: JWidth * 6, height: frame.height + Constants.fixNaviBarHeight)).cornerRadius(JWidth * 3)
        upView.backgroundColor = Constants.APP_MAIN_COLOR
        self.addSubview(upView)

    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
