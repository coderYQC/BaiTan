


//
//  NearbyDynamicsView.swift
//  BaiTan
//
//  Created by yanqunchao on 2020/6/6.
//  Copyright © 2020 yanqunchao. All rights reserved.
//

import UIKit
import YQCKit
import SwiftyJSON
class NearbyStallOwnerView: SectionCollectionViewCell {
     var tableView:QCTableView!
    lazy var headerView:NearbyDynamicsHeaderView = {
        let headerView = NearbyDynamicsHeaderView(frame: CGRect(x: 0, y: 0, width: JWidth, height: 200 + Constants.fixNaviBarHeight))
        return headerView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.tableView = QCTableView(frame: kHomeSectionViewFrame, tableViewStyle: .grouped, cellCls: NearbyStallOwnerCell.self, vmCls: NearbyStallOwnerViewModel.self)
            .refreshControl(onlyFooterRefresh: true)
            .cell({ (cell, indexPath, model) in
                let cell = cell as! NearbyStallOwnerCell
                let model = model as! JSON
                cell.model = model
            })
            .cellHeight({ (indexPath, model) -> (CGFloat) in
                let model = model as! JSON
                return NearbyStallOwnerCell.getCellHeight(model: model)
            })
            .scrollDragDirection({[weak self] (scrollView, direction) in
                
            })
            .didEndScroll({[weak self] (scrollView, offset) in
                self?.scrollViewDidEndScroll()
            }) 
            .didScroll({[weak self] (scrollView, offset) in
                self?.handleScrollViewOffset(scrollView: scrollView)
            })
            .backgroundColor(Constants.APP_BACKGROUND_COLOR)
            .onlyFooterRefresh()
        self.tableView.tableView.showsVerticalScrollIndicator = false
        self.addSubview(self.tableView)
        self.scrollView = self.tableView.tableView
        
        kNotificationCenter.qc_addNotication(observer: self, name: kRefreshNearbyDynamicsData) {[weak self] (_) in
            self?.tableView.onlyFooterRefresh().dispose()
        }
    }
    
     
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    } 
    
    
}
