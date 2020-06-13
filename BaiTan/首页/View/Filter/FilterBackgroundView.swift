//
//  FilterBackgroundView.swift
//  BaiTan
//
//  Created by yanqunchao on 2020/6/11.
//  Copyright © 2020 yanqunchao. All rights reserved.
//

import UIKit

class FilterBackgroundView: UIView {
    var emptyView:UIView = {
        let emptyView = UIView(frame: CGRect(x: 0, y: 0, width: JWidth, height: JHeight)).backgroundColor(UIColor(white: 1, alpha: 0.01))
        return emptyView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.emptyView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
