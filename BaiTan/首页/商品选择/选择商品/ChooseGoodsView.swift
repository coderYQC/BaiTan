//
//  ChooseGoodsView.swift
//  BaiTan
//
//  Created by yanqunchao on 2020/6/15.
//  Copyright © 2020 yanqunchao. All rights reserved.
//

import UIKit
import YQCKit
import SwiftyJSON

let kGoodsSelectionSectionViewFrame:CGRect = CGRect(x: 0, y: 0, width: JWidth, height: kGoodsSelectionCollectionViewH)

let kGoodsTableViewFrame:CGRect = CGRect(x: 90, y: 0, width: JWidth - 90, height: kGoodsSelectionCollectionViewH)
let kCategoryTableViewFrame:CGRect = CGRect(x: 0, y: 0, width: 90, height: kGoodsSelectionCollectionViewH)

class ChooseGoodsView: SectionCollectionViewCell {
 
    var goodsTableView:QCTableView!
    var categoryTableView:QCTableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .randomColor()
        self.isHomeCell = false
        
        self.categoryTableView = QCTableView(frame: kCategoryTableViewFrame,tableViewStyle: .grouped, cellCls: CategoryCell.self)
            .cell({ (cell, indexPath, model) in
                (cell as! CategoryCell).titleLab.text = "分类\(indexPath.row)"
            })
            .cellHeight({ (indexPath, model) -> (CGFloat) in
                return 60
            })
            .cellDidSelect({[weak self] (indexPath, model) in
                self!.cellCanScroll = true
                self?.mainTableView?.setContentOffset(CGPoint(x: 0, y: kChooseGoodsFix), animated: true)
                self?.goodsTableView.tableView.scrollToRow(at: IndexPath(row: 0, section: indexPath.row), at: .top, animated: true)
            })
            .didScroll({[weak self] (scrollView, offset) in
              
            })
            .scrollDirection({[weak self] (scrollView, direction) in
                self?.handleScrollViewOffsetWithDirection(scrollView: scrollView,isUp: direction == .up)
            })
            .backgroundColor(Constants.APP_BACKGROUND_COLOR)
        
        self.categoryTableView.tableView.showsVerticalScrollIndicator = false
        
        self.addSubview(self.categoryTableView)
        self.leftScrollView = self.categoryTableView.tableView
        self.categoryTableView.defaultData(["","","","","","","","","","","","",""]).dispose()
         
        self.goodsTableView = QCTableView(frame: kGoodsTableViewFrame, tableViewStyle: .plain, cellCls: UITableViewCell.self, secHVCls:GoodsSectionHeader.self)
            .isTDData(true)
            .numberOfRows({ (indexPath, model) -> (Int) in
                let model = model as! [String]
                return model.count
            })
            .sectionHeaderView({ (view, section, model, _) in
                let view = view as! GoodsSectionHeader
                view.backgroundColor = .red
                view.titleLab.text = "分类\(section!)"
            })
            .sectionHeaderHeight({ (section, model) -> (CGFloat) in
                 return 40
            })
            .cell({ (cell, indexPath, model) in
                cell.textLabel!.text = "商品\(indexPath.row)"
            })
            .cellHeight({ (indexPath, model) -> (CGFloat) in
                return 70
            })
            .scrollDragDirection({[weak self] (scrollView, direction) in
                
            })
            .scrollDirection({[weak self] (scrollView, direction) in
                self?.handleScrollViewOffsetWithDirection(scrollView: scrollView,isUp: direction == .up)
            })
            .backgroundColor(Constants.APP_BACKGROUND_COLOR)
        self.goodsTableView.tableView.showsVerticalScrollIndicator = false
        self.addSubview(self.goodsTableView)
        self.scrollView = self.goodsTableView.tableView
         
        self.goodsTableView.defaultData([["","","","",""],["","","","","","",""],["","","","","","",""],["","","","","","",""],["","","","",""],["","","","",""],["","","","","","",""],["","","","","",""],["","",""],["","","","","","",""],["","","","","","",""],["","","","","","",""],["","","","","","",""]]).dispose()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
