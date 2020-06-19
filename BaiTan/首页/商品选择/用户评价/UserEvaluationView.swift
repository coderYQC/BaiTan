//
//  UserEvaluationView.swift
//  BaiTan
//
//  Created by yanqunchao on 2020/6/18.
//  Copyright © 2020 yanqunchao. All rights reserved.
//

import UIKit
import YQCKit
let kEvalHeaderViewH:CGFloat = 253 * jScale
let kMenuH:CGFloat = 42 * jScale
class UserEvaluationView: SectionCollectionViewCell {
    var tableView:QCTableView!
    var headerView:EvaluationHeaderView = {
        let headerView = EvaluationHeaderView.viewFromXib() as! EvaluationHeaderView
        headerView.frame = CGRect(x: 0, y: 0, width: JWidth, height: kEvalHeaderViewH)
        return headerView
    }()
    
     var evalMenuView:EvalueMenuView = {
           let evalMenuView = EvalueMenuView.viewFromXib() as! EvalueMenuView
           evalMenuView.frame = CGRect(x: 0, y: -kMenuH, width: JWidth, height: kMenuH)
           return evalMenuView
       }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .randomColor()
        self.isHomeCell = false
            
        self.tableView = QCTableView(frame: kGoodsSelectionSectionViewFrame, cellCls: EvaluationCell.self, vmCls: EvaluationViewModel.self).refreshControl(onlyFooterRefresh: true)
            .headerView(headerView)
            .cell({ (cell, indexPath, model) in
                
            })
            .cellHeight({ (indexPath, model) -> (CGFloat) in
                return 462 * jScale
            })
            .didScroll({[weak self] (scrollView, offset) in
                
                self?.handleScrollViewOffset(scrollView: scrollView)
                
                var isUp:Bool = true
                if offset.y >= kEvalHeaderViewH - kMenuH {
                    isUp = false
                }else{
                    isUp = true
                }
                UIView.animate(withDuration: 0.25) {
                    self?.evalMenuView.top = isUp ? -kMenuH : 0
                } 
            })
            .onlyFooterRefresh()
         
        self.addSubview(self.tableView)
        self.addSubview(self.evalMenuView)
        
        self.scrollView = self.tableView.tableView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
