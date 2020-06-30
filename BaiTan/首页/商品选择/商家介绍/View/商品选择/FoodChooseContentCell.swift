//
//  FoodChooseContentCell.swift
//  BaiTan
//
//  Created by yanqunchao on 2020/6/19.
//  Copyright © 2020 yanqunchao. All rights reserved.
//

import UIKit
import YQCKit
import SwiftyJSON

class FoodChooseContentCell: UITableViewCell {

    var goodsTableView:QCTableView!
    
    var cellCanScroll:Bool = false
    
//    var defaultData:[GroupModel]? {
//        didSet {
//          self.goodsTableView.configuerDefaultDataArray(dataArray: defaultData!)
//        }
//    }
    override func awakeFromNib() {
        super.awakeFromNib()
          
         self.goodsTableView = QCTableView(frame: kGoodsSelectionSectionViewFrame, tableViewStyle: .plain, cellCls: UITableViewCell.self, secHVCls:GoodsSectionHeader.self)
         .cell({ (cell, indexPath, model) in
            cell.contentView.backgroundColor = .randomColor()
         })
         .cellHeight({ (indexPath, model) -> (CGFloat) in
             return 196 * ((JWidth - 90) / 295)
         })
         .cellDidSelect({ (indexPath, model) in
         })
         .didScroll({[weak self] (scrollView, offset) in
//            print("++++++++++++++++++\(offset.y)")
            self?.handleScrollViewOffsetWithTwoScrollViews(scrollView: scrollView)
            
         })
         .didEndDragging({[weak self] (_, _) in
            
         })
         .didEndScroll({[weak self] (_, _) in
             print("右侧停止滚动了")
         })
         .backgroundColor(Constants.APP_BACKGROUND_COLOR)
        
//        self.contentView.addSubview(self.goodsTableView)
        
        self.goodsTableView.tableView.showsVerticalScrollIndicator = false
        
        self.goodsTableView.configuerDefaultDataArray(dataArray: ["","","","","",""])
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func handleScrollViewOffsetWithTwoScrollViews(scrollView:UIScrollView){
 
         if self.cellCanScroll == false {
             scrollView.contentOffset = CGPoint(x: 0, y: 0)
         }
         if scrollView.contentOffset.y <= 0 {
             self.cellCanScroll = false
             scrollView.contentOffset = CGPoint(x: 0, y: 0)
             NotificationCenter.default.post(name: Notification.Name("leaveTop4"), object: nil)
         }
    }
}
