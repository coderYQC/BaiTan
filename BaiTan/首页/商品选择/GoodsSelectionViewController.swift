//
//  GoodsSelectionViewController.swift
//  BaiTan
//
//  Created by yanqunchao on 2020/6/15.
//  Copyright © 2020 yanqunchao. All rights reserved.
//

import UIKit
import SVProgressHUD
let kGoodsSelectionSegmentH:CGFloat = 45

let kGoodsSelectionTableViewH:CGFloat = JHeight + Constants.statusBarHeight

let kGoodsSelectionCollectionViewH:CGFloat = JHeight - kGoodsSelectionSegmentH - Constants.naviBarHeight
 
let kGoodsSelectionTableHeaderViewH:CGFloat = 300 + Constants.fixNaviBarHeight
 
let kChooseGoodsFix:CGFloat = kGoodsSelectionTableHeaderViewH - kGoodsSelectionSegmentH - Constants.naviBarHeight
 
let kSellerContetnViewH:CGFloat = kGoodsSelectionTableViewH - (78 + Constants.statusBarHeight) - (70 + Constants.fixTabbarHeight)

class GoodsSelectionViewController: BaseViewController {
    var vcCanScroll = true
    var curContentCell:SectionCollectionViewCell!
    var chooseGoodsCell:ChooseGoodsView!
    var evalCell:UserEvaluationView!
    var sellerCell:SellerDetailView!
    var selTitleBtnIndex = 0
    var curTableViewOffsetY:CGFloat = 0
    let vm = FoodViewModel()
    var id:Int = 0
    var isDismiss:Bool = false
    var isAutoSetOffsetY:Bool = false
    lazy var myTableView:BaseTableView = {
        let myTableView = BaseTableView(frame: CGRect(x: 0, y:-Constants.statusBarHeight, width: JWidth, height: kGoodsSelectionTableViewH),style: .plain)
        myTableView.isChooseFood = true
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.backgroundColor = UIColor(white: 1, alpha: 1)
        myTableView.separatorStyle = .none
        myTableView.showsVerticalScrollIndicator = false
        myTableView.backgroundColor = .clear
             //刷新
        return myTableView
    }()
 
    lazy var tableHeaderView:GoodsSelectionHeaderView = {
        let headerView = GoodsSelectionHeaderView(frame: CGRect(x: 0, y: 0, width: JWidth, height:  kGoodsSelectionTableHeaderViewH))
        headerView.selectBtnIndexClosure = {[weak self] index in
            
            self?.curTableViewOffsetY = self!.myTableView.contentOffset.y
            
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
         collectionView.registerCell(UserEvaluationView.self)
         collectionView.registerCell(SellerDetailView.self)

         collectionView.delegate = self
         collectionView.dataSource = self
         collectionView.isPagingEnabled = true
         collectionView.bounces = false
         collectionView.backgroundColor = Constants.APP_BACKGROUND_COLOR
         return collectionView
     }()
    
    lazy var sellerView:UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: JWidth, height: 150 + Constants.fixNaviBarHeight))
        let iv = UIImageView(frame: view.bounds).image("2").contentMode(.scaleToFill)
        let cover = UIView(frame: view.bounds).backgroundColor(UIColor(white: 0, alpha: 0.3))
        view.addSubview(iv)
        view.addSubview(cover)
        return view
    }()
    
    lazy var bottomBGView:UIView = {
        let view = UIView(frame: CGRect(x: 0, y: self.sellerView.bottom, width: JWidth, height: kGoodsSelectionTableViewH - self.sellerView.bottom)).backgroundColor(UIColor(white: 0, alpha:0.05))
        return view
    }()
    lazy var naviBar:CustomNaviBar = {
        let naviBar = CustomNaviBar(frame: CGRect(x: 0, y: 0, width: JWidth, height: Constants.naviBarHeight)).backgroundColor(UIColor(white: 1, alpha: 0)).backgroundColor(UIColor(white: 1, alpha: 0))
        naviBar.backBtn.setImage(UIImage(named: "navi_back")?.imageChangeColor(color: UIColor.white), for: .normal)
        naviBar.backBtn.addTap { (_) in
            UtilTool.popViewController()
        }
        naviBar.configureRightBtns(["searchIcon","collectionIcon","shoppingCartIcon","moreIcon"]) { (index) in
             
        }
        return naviBar
    }()
   
    
    lazy var sellerContentView:SellerContentView = {
        let view = SellerContentView(frame: CGRect(x: 10, y: 78 + Constants.statusBarHeight, width: JWidth - 20, height: kSellerContetnViewH))
             
        view.upBtn.addTap {[weak self] (_) in
            self?.myTableView.setContentOffset(CGPoint(x: 0, y: -Constants.statusBarHeight), animated: true)
        }
        return view
    }()
    
    
    lazy var minusBtn:UIButton = {
        let minusBtn = UIButton(frame: CGRect(x: 12, y: JHeight - (140 + (UtilTool.iPhoneX() ? 14 : 0)), width: 105, height: 35)).backgroundImage("fullMinusBtn")
               .cornerRadiusWithClip(17.5)
           return minusBtn
       }()
       
       lazy var packageView:UIImageView = {
           let packageView = UIImageView(frame: CGRect(x: 12, y: JHeight - (103 + (UtilTool.iPhoneX() ? 14 : 0)), width: JWidth - 24, height: 93)).image("packageView").cornerRadiusWithClip(20)
           return packageView
       }()
       
     
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fd_prefersNavigationBarHidden = true
        self.view.backgroundColor = .white
        self.navigationItem.title = "商品选择"
        self.view.addSubview(self.sellerView)
        self.view.addSubview(self.bottomBGView)
        self.view.addSubview(self.sellerContentView)
        
        self.view.addSubview(self.myTableView)
        self.myTableView.tableHeaderView = self.tableHeaderView
        self.view.addSubview(self.naviBar)
         
        self.view.addSubview(self.minusBtn)
        self.view.addSubview(self.packageView)
        
        kNotificationCenter.addObserver(forName: NSNotification.Name(rawValue: "leaveTop2"), object: nil, queue: nil) {[weak self] (noti) in
                  
            self?.vcCanScroll = true
            self?.myTableView.isScrollEnabled = true
            if self?.curContentCell != nil {
                self?.curContentCell.cellCanScroll = false
            }
            print("+++++++++++++++++")
        }
        
        kNotificationCenter.addObserver(forName: NSNotification.Name(rawValue: "leaveTop3"), object: nil, queue: nil) {[weak self] (noti) in
              
            self?.vcCanScroll = true
            self?.myTableView.isScrollEnabled = true
            if self?.curContentCell != nil {
                self?.curContentCell.leftCellCanScroll = false
            }
        }
        self.loadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        isDismiss = true
        curTableViewOffsetY = self.myTableView.contentOffset.y
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isDismiss = false
    }
    
    
    
    func loadData(){
        SVProgressHUD.show()
        self.vm.loadMenuListData(id:id,success: {
            SVProgressHUD.dismiss()
            if self.vm.menuList.count > 0 {
                self.chooseGoodsCell.categoryTableView.configuerDefaultDataArray(dataArray: self.vm.menuList)
                self.chooseGoodsCell.categoryTableView.tableView.selectRow(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .top)
                self.chooseGoodsCell.goodsTableView.configuerDefaultDataArray(dataArray: self.vm.goodsList)
            }
        }) { (err) in
            SVProgressHUD.showError(withStatus: err)
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
         
            let offsetY = -(myTableView.contentOffset.y + Constants.statusBarHeight)
   
            if scrollView == self.collectionView1{
                myTableView.isScrollEnabled = false
                myTableView.contentOffset = CGPoint(x: 0, y: curTableViewOffsetY)
                
                if -offsetY < kChooseGoodsFix {
                   resetTableviewContentOffsetY()
                }
            } else {
                 print("*****************")
                if scrollView == myTableView {
                    if isDismiss {//滑动返回时，禁止滑动
                        myTableView.contentOffset = CGPoint(x: 0, y: curTableViewOffsetY)
                    }else{
                        if self.isAutoSetOffsetY {//下拉隐藏时纠正回弹
                            if scrollView.contentOffset.y > curTableViewOffsetY {
                                myTableView.contentOffset = CGPoint(x: 0, y: curTableViewOffsetY)
                            }
                        }else{
                            
                            if -offsetY >= kChooseGoodsFix {
                                print("--------------------")
                                //滑到顶端
                                myTableView.contentOffset = CGPoint(x: 0, y: kChooseGoodsFix - Constants.statusBarHeight)
                                self.tableHeaderView.segmentHeaderView.backgroundColor = UIColor(white: 0.97, alpha: 1)
                                if self.vcCanScroll {
                                    self.vcCanScroll = false
                                    if self.curContentCell != nil {
                                        self.curContentCell.cellCanScroll = true
                                        self.curContentCell.leftCellCanScroll = true
                                    }
                                }
                            } else { //脱离顶端
                                
                                 print("===================")
                                self.tableHeaderView.segmentHeaderView.backgroundColor = UIColor(white: 1, alpha: 1)
                                 if self.vcCanScroll == false {
                                     myTableView.contentOffset =  CGPoint(x: 0, y: kChooseGoodsFix - Constants.statusBarHeight)
                                 }
                            }
                        }
                    }
                   
                }
        }
            
        let scrollViewOffseX:CGFloat = self.collectionView1.contentOffset.x
        let scale = scrollViewOffseX / JWidth
        self.tableHeaderView.dotView.left = self.tableHeaderView.dotCenterX + scale * self.tableHeaderView.btnCenterDistance
        
        var alpha = -offsetY / kChooseGoodsFix
        
        if self.vcCanScroll == false {
            alpha = 1
        }
        if -offsetY > Constants.naviBarHeight {
           self.changeNaviBtnColor(scale: alpha)
        }else{
           self.changeNaviBtnColor(scale: 0)
        }
         
        self.naviBar.backgroundColor = UIColor(white: 0.97, alpha: alpha)
        
        let bgAlpha = offsetY / (kGoodsSelectionCollectionViewH - Constants.statusBarHeight)
        self.bottomBGView.backgroundColor = UIColor(white: 0, alpha: 0.05 + 0.25 * bgAlpha)
         
        self.minusBtn.alpha = 1 - bgAlpha * 2
        self.packageView.alpha =  1 - bgAlpha * 2
        
        
        self.minusBtn.left =  12 - self.collectionView1.contentOffset.x
        self.packageView.left =  12 - self.collectionView1.contentOffset.x
        
        
        self.sellerContentView.frontView.alpha = (offsetY / 200)
        
        if offsetY / 200 >= 0.85 {
            self.sellerContentView.sellerNameLab.alpha = 0
        }else {
            self.sellerContentView.sellerNameLab.alpha = 1
        }
        
    }
    func changeNaviBtnColor(scale:CGFloat){
        let scale = scale > 1 ? 1 : scale
        self.naviBar.backBtn.setImage(self.naviBar.backBtn.imageView?.image?.qc_imageChangeColor(color: UIColor(white: 1 - 0.6 * scale, alpha: 1)), for: .normal)
        for btn in self.naviBar.rightBtns {
            btn.setImage(btn.imageView?.image?.qc_imageChangeColor(color: UIColor(white: 1 - 0.6 * scale, alpha: 1)), for: .normal)
        }
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        curTableViewOffsetY = self.myTableView.contentOffset.y
    }
          
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
      
         handleScrollable()
         
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
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
              
        handleScrollable()
        
            if scrollView == self.myTableView {
                let scrollToScrollStop = !scrollView.isTracking && !scrollView.isDragging && !scrollView.isDecelerating
                if (scrollToScrollStop) {
                   scrollViewDidEndScroll()
                }
            }
         
        if scrollView == self.myTableView {
            if scrollView.contentOffset.y + Constants.statusBarHeight < -100 {
                isAutoSetOffsetY = true
                print("111111111111111")
                self.curTableViewOffsetY = self.myTableView.contentOffset.y
                DispatchQueue.main.async {
                    self.myTableView.setContentOffset(CGPoint(x: 0, y: -kGoodsSelectionCollectionViewH), animated: true)
                }
                UtilTool.dispatchAfter(seconds: 0.4) {
                    self.isAutoSetOffsetY = false
                }
            }
        }
    }
 
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
            if scrollView == self.collectionView1 {
               selTitleBtnIndex = Int(scrollView.contentOffset.x / JWidth)
               setCurSelCell(index: selTitleBtnIndex)
               self.tableHeaderView.setCurSelBtn(index: selTitleBtnIndex)
            }
  
        handleScrollable()
           
        }
      
    func handleScrollable(){
        self.collectionView1.isScrollEnabled = true
        self.myTableView.isScrollEnabled = true
        self.chooseGoodsCell.isTapLeftCell = false
    }
    func scrollViewDidEndScroll() {
//            print("停止滚动了！！！")
//            print("scrollViewDidEndScroll 04")
           handleScrollable()
    }
         
    func setCurSelCell(index:Int) {
        
        handleScrollable()
        
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
            self.chooseGoodsCell.leftScrollView?.contentOffset = CGPoint(x: 0, y: 0)
         }
         if self.evalCell != nil && self.evalCell.scrollView != nil && self.evalCell.scrollView!.contentOffset.y != 0  {
              self.evalCell.scrollView!.contentOffset = CGPoint(x: 0, y: 0)
         }
        if self.sellerCell != nil && self.sellerCell.scrollView != nil && self.sellerCell.scrollView!.contentOffset.y != 0  {
             self.sellerCell.scrollView!.contentOffset = CGPoint(x: 0, y: 0)
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
           let sectionCell = collectionView.yqc_dequequeResuableCell(UserEvaluationView.self, indexPath)
            self.curContentCell = sectionCell
            self.evalCell = sectionCell
            return sectionCell
        }else{
            let sectionCell = collectionView.yqc_dequequeResuableCell(SellerDetailView.self, indexPath)
            self.curContentCell = sectionCell
            self.sellerCell = sectionCell
            return sectionCell
        }
   }
}
