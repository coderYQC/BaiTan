//
//  SectionWebViewCell.swift
//  LynxIOS
//
//  Created by 严群超 on 2018/10/19.
//  Copyright © 2018年 Global Hengtong (Beijing) Technology Co., Ltd. All rights reserved.
//

import UIKit
import YQCKit
class SectionCollectionViewCell: UICollectionViewCell{
 
    var cellCanScroll:Bool = false
    var scrollView:UIScrollView?
    var filterCanAnimation:Bool = false
    lazy var filterView:FilterView = {
        let filterView = FilterView(frame: CGRect(x: 0, y: 0, width: JWidth, height: kFilterViewH)).backgroundColor(Constants.APP_BACKGROUND_COLOR)
        return filterView
    }()
     
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func scrollViewDidEndScroll(){
        NotificationCenter.default.post(name: Notification.Name(kSectionCellDidEndScroll), object: nil)
    }
    func handleScrollViewOffset(scrollView:UIScrollView){
 
        if self.cellCanScroll == false{
            scrollView.contentOffset = CGPoint(x: 0, y: 0)
        }
        if scrollView.contentOffset.y <= 0 {
            self.cellCanScroll = false
            scrollView.contentOffset = CGPoint(x: 0, y: 0)
            NotificationCenter.default.post(name: Notification.Name("leaveTop"), object: nil)
        }
     
       }
    
    var isMore30:Bool?
            
    //筛选视图动画
    func filterViewAnimation(isUp:Bool){
        print(scrollView!.contentOffset.y)
        if scrollView!.contentOffset.y >= kFilterBtnH{
            UIView.animate(withDuration: 0.2) {
                if isUp == true {
                    self.filterView.top = -kFilterBtnH
                }else {
                    self.filterView.top = 0
                }
            }
        } else{
            if (!isUp && self.filterView.top != 0) || isUp{
                self.filterView.top = -scrollView!.contentOffset.y
            }
        }
    }
}
