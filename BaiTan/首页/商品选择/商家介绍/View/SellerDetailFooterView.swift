//
//  SellerDetailFooterView.swift
//  BaiTan
//
//  Created by yanqunchao on 2020/6/18.
//  Copyright © 2020 yanqunchao. All rights reserved.
//

import UIKit
import YQCKit

class SellerDetailFooterView: UIView {

    var goodsTableView:QCTableView!
    var cellCanScroll:Bool = false 
    override func awakeFromNib() {
        super.awakeFromNib()
       
//        self.goodsTableView = QCTableView(frame: kGoodsSelectionSectionViewFrame, tableViewStyle: .plain)
//                   .cell({ (cell, indexPath, model) in
//
//                    cell.backgroundColor = .randomColor()
//                   })
//                   .cellHeight({ (indexPath, model) -> (CGFloat) in
//                       return 196 * ((JWidth - 90) / 295)
//                   })
//                   .cellDidSelect({ (indexPath, model) in
//                   })
//                   .didScroll({[weak self] (scrollView, offset) in
//
//
//                    self?.handleScrollViewOffset(scrollView)
//
//                   })
//                   .didEndDragging({[weak self] (_, _) in
//
//                   })
//                   .didEndScroll({[weak self] (_, _) in
//                       print("右侧停止滚动了")
//                   })
//                   .backgroundColor(Constants.APP_BACKGROUND_COLOR)
//
//               self.goodsTableView.tableView.showsVerticalScrollIndicator = false
//        self.goodsTableView.configuerDefaultDataArray(dataArray: ["","","","","","","","","","","","","","",""])
//        self.addSubview(self.goodsTableView)
//        goodsTableView.tableView.isScrollEnabled = false
    }
//   
//    func handleScrollViewOffset(_ scrollView:UIScrollView){
//            
//        print("3层scrollView")
//        
//            if self.cellCanScroll == false {
//                scrollView.contentOffset = CGPoint(x: 0, y: 0)
//            }
//            if scrollView.contentOffset.y <= 0 {
//                 
//                print("3层scrollView脱离顶部")
//                self.cellCanScroll = false
//                scrollView.contentOffset = CGPoint(x: 0, y: 0)
//                NotificationCenter.default.post(name: Notification.Name("leaveTop4"), object: nil)
//            }
//       }
}
