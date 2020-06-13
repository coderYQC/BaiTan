
//
//  BaseFilterView.swift
//  BaiTan
//
//  Created by yanqunchao on 2020/6/11.
//  Copyright © 2020 yanqunchao. All rights reserved.
//

import UIKit

class BaseFilterView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        cornerRadius(10, [.bottomLeft,.bottomRight]).dispose()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
