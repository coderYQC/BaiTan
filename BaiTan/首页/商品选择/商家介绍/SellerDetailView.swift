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
        return headerView
    }()
    
    var footerView:SellerDetailFooterView = {
        let footerView = SellerDetailFooterView.viewFromXib() as! SellerDetailFooterView
        footerView.frame = CGRect(x: 0, y: 0, width: JWidth, height: 324 * jScale)
        return footerView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isHomeCell = false
        self.tableView = QCTableView(frame: kGoodsSelectionSectionViewFrame, cellCls: EvaluationCell.self, vmCls: EvaluationViewModel.self).refreshControl(onlyFooterRefresh: true)
            .headerView(headerView).footerView(self.footerView)
            .didScroll({[weak self] (scrollView, _) in
                self?.handleScrollViewOffset(scrollView: scrollView)
            })
        self.addSubview(self.tableView)
        
        
        self.scrollView = self.tableView.tableView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
