//
//  SellerDetailView.swift
//  BaiTan
//
//  Created by yanqunchao on 2020/6/18.
//  Copyright © 2020 yanqunchao. All rights reserved.
//

import UIKit
import YQCKit
class SellerDetailView: SectionCollectionViewCell {
    var tableView:QCTableView!
    var headerView:SellerDetailHeaderView = {
        let headerView = SellerDetailHeaderView.viewFromXib() as! SellerDetailHeaderView
        headerView.frame = CGRect(x: 0, y: 0, width: JWidth, height: 311 * jScale)
        headerView.backgroundColor = .red
        return headerView
    }()
    
    var footerView:SellerDetailFooterView = {
        let footerView = SellerDetailFooterView.viewFromXib() as! SellerDetailFooterView
        footerView.frame = CGRect(x: 0, y: 0, width: JWidth, height: 327 * jScale)
        return footerView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isHomeCell = false
        self.tableView = QCTableView(frame: kGoodsSelectionSectionViewFrame, cellCls: EvaluationCell.self, vmCls: EvaluationViewModel.self).refreshControl(onlyFooterRefresh: true)
            .headerView(headerView)
            .footerView(self.footerView)
            .didScroll({[weak self] (scrollView, _) in
                self?.handleScrollViewOffset(scrollView: scrollView)
            })
        self.addSubview(self.tableView)
         
        self.scrollView = self.tableView.tableView
         
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
    
//    func handleScrollViewOffset1(scrollView:UIScrollView){
//
//        if self.cellCanScroll == false{
//            scrollView.contentOffset = CGPoint(x: 0, y: 0)
//            footerView.goodsTableView.tableView.contentOffset = CGPoint(x: 0, y: 0)
//
//            print("11111111111111111111")
//        }
//        if scrollView.contentOffset.y <= 0 {
//
//            self.cellCanScroll = false
//
//            footerView.cellCanScroll = false
//            footerView.goodsTableView.tableView.contentOffset = CGPoint(x: 0, y: 0)
//            print("22222222222222222222222")
//            scrollView.contentOffset = CGPoint(x: 0, y: 0)
//
//            NotificationCenter.default.post(name: Notification.Name("leaveTop2"), object: nil)
//
//        } else if scrollView.contentOffset.y >= 200 * jScale {
//
//            scrollView.contentOffset = CGPoint(x: 0, y: 200 * jScale)
//
//            if footerView.cellCanScroll == false {
//                footerView.cellCanScroll = true
//            }
//            print("4444444444444444444")
//        }else{
//            self.cellCanScroll = true
//            footerView.cellCanScroll = false
//            footerView.goodsTableView.tableView.contentOffset = CGPoint(x: 0, y: 0)
//            print("333333333333333333333")
//        }
//    }
}
