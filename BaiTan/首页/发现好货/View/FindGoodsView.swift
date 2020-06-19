//
//  NearTanerView.swift
//  BaiTan
//
//  Created by yanqunchao on 2020/6/6.
//  Copyright © 2020 yanqunchao. All rights reserved.
//

import UIKit
import YQCKit
let kHomeSectionViewFrame:CGRect = CGRect(x: 0, y: 0, width: JWidth, height: kContentCellHeight - Constants.statusBarHeight)
let kFilterViewH:CGFloat = kFilterRecommendViewH + kFilterBtnH
class FindGoodsView: SectionCollectionViewCell { 
    var collectionView:QCCollectionView!
    var headerView:GoodsHeaderView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.collectionView = QCCollectionView(frame: kHomeSectionViewFrame , cellCls: GoodsCell.self, vmCls: FindGoodsViewModel.self,secHVCls: GoodsHeaderView.self)
            .sectionHeaderSize({ (section, model) -> (CGSize) in
                 return CGSize(width: JWidth, height: kFilterViewH)
            })
            .sectionHeaderView({ (headerView, section, model, _) in
                self.headerView = (headerView as! GoodsHeaderView)
            })
            .refreshControl(onlyFooterRefresh: true)
            .emptyView(emptyTitle: "暂无数据", emptyImageName: "")
            .waterFlowLayout(sectionInset: UIEdgeInsetsMake(10, 10, 10, 10), columnCount: 2, minimumLineSpacing: 10, minimumInteritemSpacing: 10, itemHeightClosure: {  (indexPath, model) -> (CGFloat) in
                let model = model as! GoodsModel
                return  GoodsCell.getCellHeight(model: model)
            })
            .cell({ (cell, indexPath, model) in
                let cell = cell as! GoodsCell
                let model = model as! GoodsModel
                cell.goods = model
            })
            .cellDidSelect({ (indexPath, model) in
                let vc = GoodsSelectionViewController()
                vc.id = indexPath.row
                UtilTool.pushViewController(vc: vc)
            })
            .didScroll({[weak self] (scrollView, offset) in
                self?.handleScrollViewOffset(scrollView: scrollView)
            })
            .scrollDragDirection({[weak self] (scrollView, direction) in
                if scrollView.contentOffset.y >= kFilterBtnH * 2{
                    self?.filterViewAnimation(isUp:direction == .up)
                }
            })
            .didEndScroll({[weak self] (scrollView, offset) in
                self?.scrollViewDidEndScroll()
            })
            .scrollDirection({[weak self]  (scrollView, direction) in
                if scrollView.contentOffset.y < kFilterBtnH * 2 {
                    self?.filterViewAnimation(isUp:direction == .up)
                }
            })
            .backgroundColor(Constants.APP_BACKGROUND_COLOR)
            .onlyFooterRefresh()
  
        self.addSubview(self.collectionView)
        self.collectionView.collectionView.showsVerticalScrollIndicator = false
        self.scrollView = self.collectionView.collectionView
          
        self.addSubview(self.filterView)
        
       kNotificationCenter.qc_addNotication(observer: self, name: kRefreshGoodsData) {[weak self] (_) in
                  self?.collectionView.onlyFooterRefresh().dispose()
              }
    }
    
   
     
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    deinit {
        kNotificationCenter.qc_removeAllNotication(observer: self)
    }
}
