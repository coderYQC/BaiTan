//
//  HerizonalPanGestureRecognizer.swift
//  LynxIOS
//
//  Created by 叶波 on 2018/7/9.
//  Copyright © 2018年 叶波. All rights reserved.
//

import UIKit
import UIKit.UIGestureRecognizerSubclass  //这个extension可以使手势可以继承。否则你没法重写必要的方法。

class HerizonalPanGestureRecognizer: UIPanGestureRecognizer {
    
    var origLoc:CGPoint! //记录开始时的坐标
    
    override init(target: Any?, action: Selector?) {
        super.init(target: target, action: action)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        origLoc = touches.first?.location(in: view?.superview)
        super.touchesBegan(touches, with: event)
    }
    
    //所有的识别逻辑都是在这里进行。第一次调用时状态是 Possible
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        if self.state == .possible{
            let loc:CGPoint! = touches.first?.location(in: view?.superview)
            let deltaX = fabs(loc.x-origLoc.x)
            let deltaY = fabs(loc.y - origLoc.y)
            
            //开始识别时， 如果竖直移动距离>水平移动距离，直接Failed
            if deltaX <= deltaY{
                state = .failed
            }
        }
        
        super.touchesMoved(touches, with: event)
    }
    
    //通过重写。现在只有x 产生偏移。
    override func translation(in view: UIView?) -> CGPoint {
        var proposedTranslation = super.translation(in: view)
        proposedTranslation.y = 0
        return proposedTranslation
    }
}
