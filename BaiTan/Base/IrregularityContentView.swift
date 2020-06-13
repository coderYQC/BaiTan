//
//  ExampleIrregularityContentView.swift
//  ESTabBarControllerExample
//
//  Created by lihao on 2017/2/9.
//  Copyright © 2018年 Egg Swift. All rights reserved.
//

//Tabbar元素样式

import UIKit
import ESTabBarController_swift

class IrregularityBasicContentView: BouncesContentView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //默认的文字和图片颜色
        textColor = Constants.kC8Color
//        iconColor = Constants.kC8Color
        //高亮的文字和图片颜色
        highlightTextColor = Constants.APP_TABBARITEM_SEL_COLOR
//        highlightIconColor = Constants.APP_MAIN_COLOR
        backdropColor = .white
        highlightBackdropColor = .white
        renderingMode = .alwaysOriginal
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
