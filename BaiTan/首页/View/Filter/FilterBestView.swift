//
//  FilterBestView.swift
//  BaiTan
//
//  Created by yanqunchao on 2020/6/11.
//  Copyright © 2020 yanqunchao. All rights reserved.
//

import UIKit
import YQCKit
import SwiftyJSON
class FilterBestView: BaseFilterView {
    var tableView:QCTableView!
    var currentModel:FilterBestModel?
    var selectBestDataClosure:((FilterBestModel)->())?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.tableView = QCTableView(frame: CGRect(x: 0, y: 0, width: JWidth, height: frame.height), tableViewStyle: .grouped, cellCls: FilterBestCell.self).backgroundColor(.white)
            .cellHeight({ (_, _) -> (CGFloat) in
                return 50
            }).cell({[weak self] (cell, indexPath, model) in
                let cell = cell as! FilterBestCell
                let model = model as! FilterBestModel
                cell.model = model
            }).cellDidSelect({[weak self] (_, model) in
                self?.currentModel?.isSelected = false
                let model = model as! FilterBestModel
                model.isSelected = true
                self?.currentModel = model
                self?.tableView.reloadData()
                self?.selectBestDataClosure?(self!.currentModel!)
            })
        self.tableView.tableView.showsVerticalScrollIndicator = false
        self.addSubview(self.tableView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
