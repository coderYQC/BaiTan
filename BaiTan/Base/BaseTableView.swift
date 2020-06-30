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
    var isChooseFood:Bool = false
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }


    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        print(self)
        if isChooseFood  {
            if point.y < kGoodsSelectionTableHeaderViewH - kGoodsSelectionSegmentH{
                return nil
            }
        }
        return super.hitTest(point, with: event)
    }
}
