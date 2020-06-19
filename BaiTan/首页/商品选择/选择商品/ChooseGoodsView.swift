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
    var lastTopHeaderViewSection:Int = 0
  
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .randomColor()
        self.isHomeCell = false
         
        self.categoryTableView = QCTableView(frame: kCategoryTableViewFrame,tableViewStyle: .grouped, cellCls: CategoryCell.self)
            .cell({ (cell, indexPath, model) in
                let cell = cell as! CategoryCell
                cell.titleLab.text = (model as! String)
            })
            .cellHeight({ (indexPath, model) -> (CGFloat) in
                return 45
            })
            .cellDidSelect({[weak self] (indexPath, model) in
                print("44444444444444")
                
                if -(self!.mainTableView!.contentOffset.y + Constants.statusBarHeight) < kChooseGoodsFix {
                    self!.cellCanScroll = true
                    self!.mainTableView?.isScrollEnabled = true
                    self?.mainTableView?.setContentOffset(CGPoint(x: 0, y: kChooseGoodsFix - Constants.statusBarHeight), animated: true)
                }
                self!.isTapLeftCell = true
                
                self?.lastTopHeaderViewSection = indexPath.row
                
//                self?.categoryTableView.tableView.scrollToRow(at: IndexPath(row: indexPath.row, section: 0), at: .middle, animated: false)
//
                self?.goodsTableView.tableView.scrollToRow(at: IndexPath(row: 0, section: indexPath.row), at: .top, animated: true)
            })
            .didScroll({[weak self] (scrollView, offset) in
               
                self?.handleScrollViewOffsetWithTwoScrollViews(scrollView: scrollView)
            })
            .didEndScroll({[weak self] (_, _) in
                print("左侧停止滚动了")
                
            })
            .backgroundColor(Constants.kBtnDisableColor)
        
        self.categoryTableView.tableView.showsVerticalScrollIndicator = false
        
        self.addSubview(self.categoryTableView)
        self.leftScrollView = self.categoryTableView.tableView
        self.goodsTableView = QCTableView(frame: kGoodsTableViewFrame, tableViewStyle: .plain, cellCls: FoodCell.self, secHVCls:GoodsSectionHeader.self)
            .isTDData(true)
            .numberOfRows({ (indexPath, model) -> (Int) in
                let model = model as! GroupModel
                return model.goodsArr.count
            })
            .sectionHeaderView({ (view, section, model, _) in
                let model = model as! GroupModel
                let view = view as! GoodsSectionHeader
                view.titleLab.text = model.title
            })
            .sectionHeaderHeight({ (section, model) -> (CGFloat) in
                 return 40
            })
            .cell({ (cell, indexPath, model) in
                let model = model as! GroupModel
                let food = model.goodsArr[indexPath.row]
                (cell as! FoodCell).model = food
            })
            .cellHeight({ (indexPath, model) -> (CGFloat) in
                return 196 * ((JWidth - 90) / 295)
            })
            .cellDidSelect({ (indexPath, model) in
                let model = model as! GroupModel
                let food = model.goodsArr[indexPath.row]
                print(food["name"].stringValue)
            })
            .didScroll({[weak self] (scrollView, offset) in
                if !self!.isTapLeftCell {
                    self?.scrollowLeftTable()
                }
                self?.handleScrollViewOffsetWithTwoScrollViews(scrollView: scrollView)
            })
            .didEndDragging({[weak self] (_, _) in
//                if self!.isTapLeftCell {
//                    self?.isTapLeftCell = false
//                    self?.scrollowLeftTable()
//                }
                self?.scrollowLeftTable()
            })
            .didEndScroll({[weak self] (_, _) in
                print("右侧停止滚动了")
            })
            .backgroundColor(Constants.APP_BACKGROUND_COLOR)
        
        self.goodsTableView.tableView.showsVerticalScrollIndicator = false
        self.addSubview(self.goodsTableView)
        self.scrollView = self.goodsTableView.tableView
         
        self.categoryTableView.tableView.contentInset = UIEdgeInsetsMake(0, 0, 150 + Constants.fixTabbarHeight, 0)
        self.goodsTableView.tableView.contentInset = UIEdgeInsetsMake(0, 0, 100 + Constants.fixTabbarHeight, 0)
         
    }
 
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //滑动商品，联动左侧的菜单表格
    func scrollowLeftTable()
    {
        // 取出显示在视图且最靠上的cell的 indexPath
        if  let topHeaderViewSection = self.goodsTableView.tableView.indexPathsForVisibleRows?.first?.section {
            
            if lastTopHeaderViewSection != topHeaderViewSection {
                print("33333333333333333333")
                self.isRightScrollToIndex = true
                self.categoryTableView.tableView.selectRow(at: IndexPath(row: topHeaderViewSection, section: 0), animated: false, scrollPosition: .middle)
                self.isRightScrollToIndex = false
            }
            lastTopHeaderViewSection = topHeaderViewSection
        } 
    }
}
 
 
