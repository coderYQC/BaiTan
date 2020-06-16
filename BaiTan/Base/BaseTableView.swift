//
//  BaseTableView.swift
//  LynxIOS
//
//  Created by 严群超 on 2018/10/19.
//  Copyright © 2018年 Global Hengtong (Beijing) Technology Co., Ltd. All rights reserved.
//

import UIKit

class BaseTableView: UITableView,UIGestureRecognizerDelegate{
    var collectionView:UICollectionView?
    var canSimultaneously:Bool = true
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }


//    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
//
//        for subView in self.subviews{
//            for subview2 in subView.subviews {
//                for subview3 in subview2.subviews {
//                    let convertedPoint = subview3.convert(point, from: self) //把父控件上的坐标点转换为子控件坐标系下的点
//                    if subview3 == self.collectionView  {
//                        if convertedPoint.y >= 0 {
//                            self.canSimultaneously = true
//                            return self
//                        }
//                    }
//                }
//            }
//        }
//
//        self.canSimultaneously = false
//        return super.hitTest(point, with: event)
//    }
}
