//
//  GoodsSelectionViewController.swift
//  BaiTan
//
//  Created by yanqunchao on 2020/6/15.
//  Copyright © 2020 yanqunchao. All rights reserved.
//

import UIKit
let kGoodsSelectionSegmentH:CGFloat = 40

let kGoodsSelectionTableViewH:CGFloat = JHeight + Constants.statusBarHeight

let kGoodsSelectionCollectionViewH:CGFloat = JHeight - Constants.statusBarHeight - kGoodsSelectionSegmentH - kInputVH
 
let kGoodsSelectionTableHeaderViewH:CGFloat = 300 + Constants.fixNaviBarHeight


let kChooseGoodsFix:CGFloat = kGoodsSelectionTableHeaderViewH - kGoodsSelectionSegmentH - (Constants.statusBarHeight + kInputVH)

class GoodsSelectionViewController: BaseViewController {
    var vcCanScroll = true
    var curContentCell:SectionCollectionViewCell!
    var chooseGoodsCell:ChooseGoodsView!
    var evalCell:ChooseGoodsView!
    var sellerCell:ChooseGoodsView!
    var selTitleBtnIndex = 0
    lazy var myTableView:BaseTableView = {
        let myTableView = BaseTableView(frame: CGRect(x: 0, y:-Constants.statusBarHeight, width: JWidth, height: kGoodsSelectionTableViewH ),style: .plain)
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.backgroundColor = Constants.APP_BACKGROUND_COLOR
        myTableView.separatorStyle = .none
        myTableView.showsVerticalScrollIndicator = false
             //刷新
        return myTableView
    }()
 
    lazy var tableHeaderView:GoodsSelectionHeaderView = {
        let headerView = GoodsSelectionHeaderView(frame: CGRect(x: 0, y: 0, width: JWidth, height:  kGoodsSelectionTableHeaderViewH))
        headerView.selectBtnIndexClosure = {[weak self] index in 
            self?.collectionView1.setContentOffset(CGPoint(x: JWidth * CGFloat(index), y: 0), animated: true)
        }
        return headerView
    }()
    lazy var collectionView1:UICollectionView = {
             let layout = UICollectionViewFlowLayout()
             layout.minimumLineSpacing = 0
             layout.minimumInteritemSpacing = 0
             layout.itemSize = CGSize(width: JWidth, height: kGoodsSelectionCollectionViewH)
             layout.scrollDirection = .horizontal
             
             let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: JWidth, height: kGoodsSelectionCollectionViewH), collectionViewLayout: layout)
             collectionView.showsHorizontalScrollIndicator = false
             collectionView.showsVerticalScrollIndicator = false
             collectionView.registerCell(ChooseGoodsView.self)
             collectionView.delegate = self
             collectionView.dataSource = self
             collectionView.isPagingEnabled = true
             collectionView.bounces = false
             collectionView.backgroundColor = Constants.APP_BACKGROUND_COLOR
             return collectionView
         }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fd_prefersNavigationBarHidden = true
        self.navigationItem.title = "商品选择"
        self.view.addSubview(UIView())
        self.view.addSubview(self.myTableView)
        self.myTableView.tableHeaderView = self.tableHeaderView
         
        kNotificationCenter.addObserver(forName: NSNotification.Name(rawValue: "leaveTop2"), object: nil, queue: nil) {[weak self] (noti) in
                  
            self?.vcCanScroll = true
            self?.myTableView.isScrollEnabled = true
            if self?.curContentCell != nil {
                self?.curContentCell.cellCanScroll = false
            }
        }
    
        kNotificationCenter.addObserver(forName: NSNotification.Name(rawValue: "leaveTop3"), object: nil, queue: nil) {[weak self] (noti) in
              
            self?.vcCanScroll = true
            self?.myTableView.isScrollEnabled = true
            if self?.curContentCell != nil {
                self?.curContentCell.leftCellCanScroll = false
            }
        }
    }
}



extension GoodsSelectionViewController:UITableViewDelegate,UITableViewDataSource {
 
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return kGoodsSelectionCollectionViewH
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
            cell?.contentView.addSubview(self.collectionView1)
        }
        return cell!
    }
    
     func scrollViewDidScroll(_ scrollView: UIScrollView) {
   
       
            var offsetY = -(myTableView.contentOffset.y + Constants.statusBarHeight)
        
            print("==============\(offsetY)")
                       
            if self.curContentCell?.cellCanScroll == true {
                offsetY = -(kGoodsSelectionTableHeaderViewH - kGoodsSelectionSegmentH)
            }
            if scrollView == self.collectionView1{
                   myTableView.isScrollEnabled = false
                   if -offsetY < kChooseGoodsFix {
                       resetTableviewContentOffsetY()
                   }
            } else {
                if scrollView == myTableView {
                     
//
                    if self.isFirstIn {
                        self.isFirstIn = false
                    }else{
                        self.collectionView1.isScrollEnabled = false
                    }
                    
                    if -offsetY >= kChooseGoodsFix { //滑到顶端
                             myTableView.contentOffset = CGPoint(x: 0, y: kChooseGoodsFix - Constants.statusBarHeight)
                             if self.vcCanScroll {
                                 self.vcCanScroll = false
                                 if self.curContentCell != nil {
                                     self.curContentCell.cellCanScroll = true
                                     self.curContentCell.leftCellCanScroll = true
                                 }
                             }
                       
                    } else { //脱离顶端
                         if self.vcCanScroll == false {
                             myTableView.contentOffset =  CGPoint(x: 0, y: kChooseGoodsFix - Constants.statusBarHeight)
                         }
                    }
                }
        }
            
        let scrollViewOffseX:CGFloat = self.collectionView1.contentOffset.x
          
        let scale = scrollViewOffseX / JWidth
       
        self.tableHeaderView.dotView.left = self.tableHeaderView.dotCenterX + scale * self.tableHeaderView.btnCenterDistance
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
            print(scrollView)
            print("scrollViewWillBeginDragging 01")
    //        self.isTapStatusBar = false
        }
          
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == self.collectionView1{
            selTitleBtnIndex = Int(scrollView.contentOffset.x / JWidth)
            setCurSelCell(index: selTitleBtnIndex)
            self.tableHeaderView.setCurSelBtn(index: selTitleBtnIndex)
        }else{
            // 停止类型1、停止类型2
             let scrollToScrollStop = !scrollView.isTracking && !scrollView.isDragging && !scrollView.isDecelerating
                   if (scrollToScrollStop) {
                        scrollViewDidEndScroll()
                   }
            
        }
    }
   
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
             
            self.collectionView1.isScrollEnabled = true
            
            if scrollView == self.myTableView {
                let scrollToScrollStop = !scrollView.isTracking && !scrollView.isDragging && !scrollView.isDecelerating
                if (scrollToScrollStop) {
                   scrollViewDidEndScroll()
                }
            }
        }
 
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
            if scrollView == self.collectionView1 {
               selTitleBtnIndex = Int(scrollView.contentOffset.x / JWidth)
               setCurSelCell(index: selTitleBtnIndex)
               self.tableHeaderView.setCurSelBtn(index: selTitleBtnIndex)
            }
             print("scrollViewDidEndScrollingAnimation")
            self.collectionView1.isScrollEnabled = true
        }
      
    func scrollViewDidEndScroll() {
            print("停止滚动了！！！")
            print("scrollViewDidEndScroll 04")
            self.collectionView1.isScrollEnabled = true
        }
         
    func setCurSelCell(index:Int) {
        myTableView.isScrollEnabled = true
        if index == 0 {
            self.curContentCell = chooseGoodsCell
        } else if index == 1{
            self.curContentCell = evalCell
        }else{
            self.curContentCell = sellerCell
        }
    }
    func resetTableviewContentOffsetY() {
         if  self.chooseGoodsCell != nil  &&  self.chooseGoodsCell.scrollView!.contentOffset.y != 0{
             self.chooseGoodsCell.scrollView!.contentOffset = CGPoint(x: 0, y: 0)
         }
        
         if self.evalCell != nil && self.evalCell.scrollView != nil && self.evalCell.scrollView!.contentOffset.y != 0  {
              self.evalCell.scrollView!.contentOffset = CGPoint(x: 0, y: 0)
         }
    }
}
extension GoodsSelectionViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
   
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return kGoodsSelectionSegmentTitleArr.count
   }
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
 
        if indexPath.row == 0{
          let sectionCell = collectionView.yqc_dequequeResuableCell(ChooseGoodsView.self, indexPath)
            sectionCell.mainTableView = self.myTableView
            self.curContentCell = sectionCell
            self.chooseGoodsCell = sectionCell
            return sectionCell
     
        } else if indexPath.row == 1{
           let sectionCell = collectionView.yqc_dequequeResuableCell(ChooseGoodsView.self, indexPath)
            self.curContentCell = sectionCell
            self.evalCell = sectionCell
            return sectionCell
        }else{
            let sectionCell = collectionView.yqc_dequequeResuableCell(ChooseGoodsView.self, indexPath)
            self.curContentCell = sectionCell
            self.sellerCell = sectionCell
            return sectionCell
        }
   }
}
