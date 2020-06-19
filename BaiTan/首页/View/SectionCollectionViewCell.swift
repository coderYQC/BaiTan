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
    var leftScrollView:UIScrollView?
    var filterCanAnimation:Bool = false
    var isHomeCell:Bool = true
 
    var leftCellCanScroll:Bool = false
    var lockRightScroll:Bool = false
    var lockLeftScroll:Bool = false
    
    
    var mainTableView:UITableView?
    var curRightScrollOffsetY:CGFloat = 0
    
    var isTapLeftCell:Bool = false
    var isRightScrollToIndex:Bool = false
    
    var heightArray:[CGFloat] = []
            
    var lastLeftSectedRow = 0
    
     
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
               NotificationCenter.default.post(name: Notification.Name(self.isHomeCell ? "leaveTop" : "leaveTop2"), object: nil)
           
        } 
    }
     
    
    func handleScrollViewOffsetWithTwoScrollViews(scrollView:UIScrollView){
        if scrollView == self.leftScrollView {
             
            if !self.isRightScrollToIndex {
                print("11111111111111")
                //左侧滑动，停止右侧滑动
                if lockRightScroll == false || lockLeftScroll == true {
                   self.scrollView!.setContentOffset(self.scrollView!.contentOffset, animated: false)
                   self.lockRightScroll = true
                   self.curRightScrollOffsetY = self.scrollView!.contentOffset.y
                }
                
                if self.leftCellCanScroll == false{
                    scrollView.contentOffset = CGPoint(x: 0, y: 0)
                }
                if scrollView.contentOffset.y <= 0 {
                    self.leftCellCanScroll = false
                    scrollView.contentOffset = CGPoint(x: 0, y: 0)
                    NotificationCenter.default.post(name: Notification.Name("leaveTop3"), object: nil)
                }
            } 
        }else{
            //右侧滑动，停止左侧滑动
            if !self.isRightScrollToIndex  {//如果不是让左侧scrollView滚动到指定索引
                print("222222222222222222")
                if lockRightScroll == true  || lockLeftScroll == false {//锁左侧scrollView
                    self.leftScrollView!.setContentOffset(leftScrollView!.contentOffset, animated: false)
                    lockLeftScroll = true
                }
                if self.cellCanScroll == true && self.leftCellCanScroll == false && !self.isTapLeftCell{
                    scrollView.contentOffset = CGPoint(x: 0, y: self.curRightScrollOffsetY)
                }
            }
            
            if self.cellCanScroll == false {
                scrollView.contentOffset = CGPoint(x: 0, y: 0)
            }
            if scrollView.contentOffset.y <= 0 {
                self.cellCanScroll = false
                self.leftCellCanScroll = false
                scrollView.contentOffset = CGPoint(x: 0, y: 0)
                NotificationCenter.default.post(name: Notification.Name("leaveTop2"), object: nil)
                if self.leftScrollView?.contentOffset != .zero {
                    self.leftScrollView?.contentOffset = .zero
                }
            } 
        }
    }
      
            
    //筛选视图动画
    func filterViewAnimation(isUp:Bool){
//        print(scrollView!.contentOffset.y)
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
