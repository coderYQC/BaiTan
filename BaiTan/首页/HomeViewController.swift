//
//  HomeViewController.swift
//  BaiTan
//
//  Created by yanqunchao on 2020/5/18.
//  Copyright © 2020 yanqunchao. All rights reserved.
//

import UIKit
import YQCKit
import SwiftyJSON

let kNaviViewHeight:CGFloat = 140

let kTableViewHeight = JHeight - Constants.tabBarHeight + Constants.statusBarHeight

let kContentCellHeight = kTableViewHeight - kInputVH - kSegmentHeadViewH - Constants.statusBarHeight

 

let kOtherViewH:CGFloat = kBannerViewH + kActivityItemsViewH

let kHeaderViewH:CGFloat = Constants.statusBarHeight + kLocationViewH + kInputVH + kSegmentHeadViewH + kRecommendSearchViewH + kOtherViewH

let fixY:CGFloat = kHeaderViewH - kSegmentHeadViewH - (Constants.statusBarHeight + kInputVH)

let kFilterBestViewH:CGFloat = 300
let kFilterVelocityViewH:CGFloat = 145
let kFilterCategoryViewH:CGFloat = 320
let kFilterAllViewH:CGFloat = 400

enum MoveDirection: Int  {
    case none = 0
    case up = 1
    case down = 2
    case right = 3
    case left = 4
}

class HomeViewController: BaseViewController {
    
    var titleBtnArr = [UIButton]()
    var selTitleBtnIndex = 0
    var vcCanScroll = true
    var findGoodsSectionCell:SectionCollectionViewCell!
    var nearbySellerSectionCell:SectionCollectionViewCell!
    var curContentCell:SectionCollectionViewCell!
    var sectionCellArr = [SectionCollectionViewCell]()
    var curSelectBtn: UIButton!
    var lastTableViewOffsetY:CGFloat = 0
    var homeDataArray:[GoodsModel] = []
    
    var isTapStatusBar:Bool = false
     
    var direction: MoveDirection = .none
    
    var bannerCanScroll:Bool = false
    
    var showFilterView:Bool = false
    var curFilterView:BaseFilterView?
    var isAnimatingFilterView:Bool = false
    var curFilterBtn:CustomFilterBtn?
    var isToTop:Bool{
        return self.myTableView.contentOffset.y >= (fixY - Constants.statusBarHeight)
    }
    var findGoodsViewIndex:Int {
        return kSegmentTitleArr.index(of: "发现好货")!
    }
    lazy var filterContentView:FilterBackgroundView = {
        let view = FilterBackgroundView(frame: CGRect(x: 0, y: 0, width: JWidth, height: JHeight)).backgroundColor(UIColor(white: 0, alpha: 0.3)).clipsToBounds(true)
        view.emptyView.addTap {[weak self] (_) in
            self?.curFilterBtn?.isSelected = false
            self?.hideCurFilterContentView(isAnimation: true)
        }
        return view
    }()
    
    lazy var filterBestView:FilterBestView = {
        let view = FilterBestView(frame:CGRect(x: 0, y: 0, width: JWidth, height: kFilterBestViewH))
        view.selectBestDataClosure = {[weak self] model in
            self?.curFilterBtn?.title = model.title
            self?.curFilterBtn?.isSelected = false
            self?.curFilterBtn?.hasValue = true
            self?.curFilterBtn?.isDefault = false
            self?.hideCurFilterContentView()
        }
        return view
    }()
    lazy var filterVelocityView:FilterVelocityView = {
        let view = FilterVelocityView(frame:CGRect(x: 0, y: 0, width: JWidth, height: kFilterVelocityViewH))
        return view
    }()
    lazy var categoryFilterView:CategoryFilterView = {
        let view = CategoryFilterView(frame:CGRect(x: 0, y: 0, width: JWidth, height: kFilterCategoryViewH))
        return view
    }()
    lazy var allFilterView:FilterAllView = {
       let view = FilterAllView(frame:CGRect(x: 0, y: 0, width: JWidth, height: kFilterAllViewH))
       return view
    }()
    lazy var gifHeader:CustomGifHeader = {
       
        return CustomGifHeader.init {[weak self] in
            let curIndex = self!.selTitleBtnIndex
                       
            UtilTool.dispatchAfter(seconds: 1) {
                self?.myTableView.mj_header.endRefreshing()
            if curIndex == 0 {
               kNotificationCenter.qc_postNotication(name: kRefreshGoodsData)
            }else{
               kNotificationCenter.qc_postNotication(name: kRefreshNearbyDynamicsData)
            }

            self?.getInputKeyWords()

            }
        }
    }()
    
    lazy var myTableView:BaseTableView = {
        let myTableView = BaseTableView(frame: CGRect(x: 0, y:-Constants.statusBarHeight, width: JWidth, height: kTableViewHeight),style: .plain)
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.backgroundColor = Constants.APP_BACKGROUND_COLOR
        myTableView.separatorStyle = .none
        myTableView.showsVerticalScrollIndicator = false
             //刷新
        myTableView.mj_header = self.gifHeader
        
        myTableView.mj_header.ignoredScrollViewContentInsetTop =  -Constants.statusBarHeight + (UtilTool.iPhoneX() ? 20 : 10)
        
        myTableView.mj_header.height += Constants.statusBarHeight
        
        return myTableView
    }()
    
    lazy var headerView:HomeHeaderView = {
        let headerView = HomeHeaderView(frame: CGRect(x: 0, y: 0, width: JWidth, height:kHeaderViewH))
        headerView.selectBtnIndexClosure = {[weak self] index in
            self?.isTapStatusBar = false
            self?.collectionView1.setContentOffset(CGPoint(x: JWidth * CGFloat(index), y: 0), animated: true)
            if index != self!.findGoodsViewIndex && self!.showFilterView {
                self?.curFilterBtn?.isSelected = false
                self?.hideCurFilterContentView(isAnimation: false)
            }
        }
        headerView.bannerView.delegate = self
        return headerView
    }()
    
    let geoCodeSearch = BMKGeoCodeSearch()
       
    /// 定位管理对象
    fileprivate var locationService = BMKLocationService()
 
    /// 定位点经纬度
    fileprivate var lat : Double!
    fileprivate var lng : Double!

    fileprivate var myLocationCoor :CLLocationCoordinate2D?
    var currentAddres:String = ""
    
//    override var preferredStatusBarStyle: UIStatusBarStyle{
//        return .lightContent
//    }
    lazy var collectionView1:UICollectionView = {
           let layout = UICollectionViewFlowLayout()
           layout.minimumLineSpacing = 0
           layout.minimumInteritemSpacing = 0
           layout.itemSize = CGSize(width: JWidth, height: kContentCellHeight)
           layout.scrollDirection = .horizontal
           
           let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: JWidth, height: kContentCellHeight), collectionViewLayout: layout)
           collectionView.showsHorizontalScrollIndicator = false
           collectionView.showsVerticalScrollIndicator = false
           collectionView.registerCell(FindGoodsView.self)
           collectionView.registerCell(NearbyStallOwnerView.self)
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
        self.view.addSubview(self.myTableView)
        self.view.bringSubview(toFront: self.statusBarVi)
        self.myTableView.tableHeaderView = self.headerView
        self.myTableView.collectionView = self.collectionView1
        self.navigationItem.title = "首页"
        
        
        self.filterBestView.backgroundColor = .white
        self.filterVelocityView.backgroundColor = .white
        self.categoryFilterView.backgroundColor = .white
        self.allFilterView.backgroundColor = .white
        self.filterContentView.backgroundColor = UIColor(white: 0, alpha: 0.3) 
        
        locationService.delegate = self
        geoCodeSearch.delegate = self
        
        kNotificationCenter.addObserver(forName: NSNotification.Name(rawValue: "leaveTop"), object: nil, queue: nil) {[weak self] (noti) in
            self?.vcCanScroll = true
            self?.myTableView.isScrollEnabled = true
            if self?.curContentCell != nil {
                self?.curContentCell.cellCanScroll = false
            }
        }
        
//        kNotificationCenter.addObserver(forName: NSNotification.Name(rawValue: kSectionCellDidEndScroll), object: nil, queue: nil) {[weak self] (noti) in
//            self?.isTapStatusBar = true
//        }
//
        UtilTool.dispatchAfter(seconds: 0.3) {
             self.locationService.startUserLocationService()
        }
    }
    func loadData(){
        kNotificationCenter.qc_postNotication(name: kRefreshGoodsData)
        self.getInputKeyWords()
        self.getBannerImages()
        self.getFilterBestData()
    }
    func getFilterBestData(){
         let titleArr = ["综合排序","销量优先","距离优先","速度优先","评分优先","起送价最低","配送费最低","人均高到低","人均低到高"]
        var bestArray:[FilterBestModel] = []
        for (i,title) in titleArr.enumerated() {
            let model = FilterBestModel()
            model.id = i+100
            model.title = title
            model.isSelected = (i == 0)
            bestArray.append(model)
            if i == 0 {
                self.filterBestView.currentModel = model
            }
        }
        self.filterBestView.tableView.configuerDefaultDataArray(dataArray: bestArray)
    }
    func getBannerImages(){
        
        print("获取banner图片")
        self.headerView.bannerImages = ["bannerImage","bannerImage","bannerImage","bannerImage","bannerImage"]
    }
    func getInputKeyWords(){
        var stringArray:[String] = []
        for i in 0..<3 {
            if i == 0 {
               stringArray.append("菠萝蜜" + " | " + "山竹")
            } else if i == 1{
               stringArray.append("IphoneSE2" + " | " + "华为Pro")
            }else{
                stringArray.append("太阳镜" + " | " + "Nike")
            }
        }
        self.headerView.marqueeView.dataArray = stringArray
    }
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(true)
    }

    override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(true)
    }
     
    func handleSelectedAddress(isUp:Bool){
      
    }
}


extension HomeViewController:UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            
             return kContentCellHeight
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
//        print("==============\(scrollView.contentOffset.y)")
         
        var offsetY = -(myTableView.contentOffset.y + Constants.statusBarHeight)
        
        if self.curContentCell?.cellCanScroll == true {
            offsetY = -(kRecommendSearchViewH + kLocationViewH + kOtherViewH)
        }
        
        if scrollView == self.collectionView1{
               myTableView.isScrollEnabled = false
               if -offsetY < fixY {
                   resetTableviewContentOffsetY()
               }
        } else {
            if scrollView == myTableView {
                if self.isTapStatusBar {//通过状态栏点击
                    print("scrollViewDidScroll 03")
                    scrollToBottom()
                }else{
                      
                    if self.isFirstIn {
                        self.isFirstIn = false
                    }else{
                       self.collectionView1.isScrollEnabled = false
                       self.headerView.bannerView.scrollView.isScrollEnabled = false
                    }
                     
                     if -offsetY >= fixY { //滑到顶端
                         myTableView.contentOffset = CGPoint(x: 0, y: fixY - Constants.statusBarHeight)
                           
                         if self.vcCanScroll {
                             self.vcCanScroll = false
                             if self.curContentCell != nil {
                                 self.curContentCell.cellCanScroll = true
                             }
                         }
                    } else { //脱离顶端
                       
                         if self.vcCanScroll == false {
                             myTableView.contentOffset =  CGPoint(x: 0, y: fixY - Constants.statusBarHeight)
                         }
                     }
                }
            }
        }
        //控制定位视图
        if -offsetY >= 0 {
            self.headerView.locationCover.top =  -offsetY
            let coverH:CGFloat = kCoverH + offsetY <  Constants.statusBarHeight ?  Constants.statusBarHeight : kCoverH + offsetY
            self.headerView.locationCover.height = coverH < Constants.statusBarHeight + kInputVH ?  Constants.statusBarHeight + kInputVH : coverH
            self.headerView.locationView.top = Constants.statusBarHeight - offsetY
        }else{
            self.headerView.locationCover.top = 0
            self.headerView.locationCover.height = kCoverH
            self.headerView.locationView.top = Constants.statusBarHeight
        }
        
        //控制定位遮罩
        var locationCoverAlpha:CGFloat = 1
        
        if -offsetY >= kLocationViewH {
            locationCoverAlpha = 1
            self.statusBarVi.alpha = 1
            self.headerView.inputV.cornerRadius(0, [.topLeft,.topRight]).dispose()
            self.headerView.inputV.top = Constants.statusBarHeight
            self.view.addSubview(self.headerView.inputV)
        }else{
            locationCoverAlpha = -offsetY / kLocationViewH
            locationCoverAlpha = locationCoverAlpha < 0 ? 0 : locationCoverAlpha
            self.statusBarVi.alpha = 0
            self.headerView.inputV.cornerRadius(30, [.topLeft,.topRight]).dispose()
            self.headerView.addSubview(self.headerView.inputV)
            self.headerView.inputV.top = Constants.statusBarHeight + kLocationViewH
             
        }
        
        self.headerView.locationCover.alpha = locationCoverAlpha
        
        let colorRGBVal = (kAPP_BG_RGB_VAL + (255 - kAPP_BG_RGB_VAL) * locationCoverAlpha) / 255.0
        self.headerView.inputV.backgroundColor =
            UIColor.init(red: colorRGBVal, green: colorRGBVal, blue: colorRGBVal, alpha: 1)
          
        //控制按钮视图
        if fixY <= -offsetY {
            self.segmentviewToTop()
        }else{
            self.segmentviewLeaveTop()
        }
        
        let scrollViewOffseX:CGFloat = self.collectionView1.contentOffset.x
        let scale = scrollViewOffseX / JWidth
        self.headerView.dotView.left = self.headerView.dotCenterX + scale * self.headerView.btnCenterDistance
        
        self.view.bringSubview(toFront: self.statusBarVi)
        
        self.showFilterContentView()
    }
    
    func segmentviewToTop(){
        self.curContentCell?.scrollView?.showsVerticalScrollIndicator = true
        
        self.headerView.segmentHeaderView.backgroundColor = .white
        self.findGoodsSectionCell?.filterView.backgroundColor = .white
        self.headerView.locationCover.alpha = 1
        self.headerView.locationCover.height = Constants.statusBarHeight + kInputVH
        
        if self.headerView.segmentHeaderView.top != Constants.statusBarHeight + kInputVH {
            self.headerView.segmentHeaderView.top = Constants.statusBarHeight + kInputVH
            self.view.addSubview(self.headerView.segmentHeaderView)
        }
    }
    
    func segmentviewLeaveTop(){
        self.curContentCell?.scrollView?.showsVerticalScrollIndicator = false
        self.statusBarVi.alpha = 0
        self.headerView.segmentHeaderView.backgroundColor = Constants.APP_BACKGROUND_COLOR
        self.findGoodsSectionCell?.filterView.backgroundColor = Constants.APP_BACKGROUND_COLOR
        if self.headerView.segmentHeaderView.top != kHeaderViewH - kSegmentHeadViewH {
           self.headerView.segmentHeaderView.top = kHeaderViewH - kSegmentHeadViewH
           self.headerView.addSubview(self.headerView.segmentHeaderView)
        }
    }
    func showFilterContentView(){
        if self.showFilterView {
            self.view.addSubview(self.filterContentView)
            let convertedPoint = self.findGoodsSectionCell.filterView.convert(self.findGoodsSectionCell.filterView.mj_origin, to: self.view)
            self.filterContentView.top = convertedPoint.y + kFilterBtnH
        }
    }
    func scrollToBottom(){
        self.myTableView.scrollRectToVisible(.zero, animated: true)
        self.findGoodsSectionCell?.scrollView?.setContentOffset(.zero, animated: true)
        self.nearbySellerSectionCell?.scrollView?.setContentOffset(.zero, animated: true)
        self.vcCanScroll = true
        self.findGoodsSectionCell?.cellCanScroll = false
        self.nearbySellerSectionCell?.cellCanScroll = false
        self.findGoodsSectionCell?.filterView.top = 0
         
    }
    
    func scrollToTop(){
        if self.vcCanScroll {
            self.myTableView.setContentOffset(CGPoint(x: 0, y: (fixY - Constants.statusBarHeight)), animated: true)
        }
    }
     
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == self.collectionView1{
            selTitleBtnIndex = Int(scrollView.contentOffset.x / JWidth)
            setCurSelCell(index: selTitleBtnIndex)
            self.headerView.setCurSelBtn(index: selTitleBtnIndex)
        }else{
            // 停止类型1、停止类型2
             let scrollToScrollStop = !scrollView.isTracking && !scrollView.isDragging && !scrollView.isDecelerating
                   if (scrollToScrollStop) {
                        scrollViewDidEndScroll()
                   }
            
        }
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        print(scrollView)
        print("scrollViewWillBeginDragging 01")
//        self.isTapStatusBar = false
    }
      
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        self.headerView.bannerView.scrollView.isScrollEnabled = true
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
           self.headerView.setCurSelBtn(index: selTitleBtnIndex)
        }
         print("scrollViewDidEndScrollingAnimation")
        self.headerView.bannerView.scrollView.isScrollEnabled = true
        self.collectionView1.isScrollEnabled = true
    }
    func scrollViewDidEndScroll() {
        print("停止滚动了！！！")
        print("scrollViewDidEndScroll 04")
//        self.isTapStatusBar = true
        self.headerView.bannerView.scrollView.isScrollEnabled = true
        self.collectionView1.isScrollEnabled = true
         
    }
      
    func resetTableviewContentOffsetY() {
         if  self.findGoodsSectionCell != nil  &&  self.findGoodsSectionCell.scrollView!.contentOffset.y != 0{
             self.findGoodsSectionCell.scrollView!.contentOffset = CGPoint(x: 0, y: 0)
            
            self.findGoodsSectionCell.filterView.top = 0
         }
         if self.nearbySellerSectionCell != nil && self.nearbySellerSectionCell.scrollView != nil && self.nearbySellerSectionCell.scrollView!.contentOffset.y != 0  {
              self.nearbySellerSectionCell.scrollView!.contentOffset = CGPoint(x: 0, y: 0)
         }
    }
    
    func setCurSelCell(index:Int) {
        myTableView.isScrollEnabled = true
        if index == findGoodsViewIndex {
            self.curContentCell = findGoodsSectionCell
        } else {
            self.curContentCell = nearbySellerSectionCell
        }
    }
}

extension HomeViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return kSegmentTitleArr.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
 
        if indexPath.row == findGoodsViewIndex{
            let sectionCell = collectionView.yqc_dequequeResuableCell(FindGoodsView.self, indexPath)
            self.findGoodsSectionCell = sectionCell
            self.curContentCell = self.findGoodsSectionCell
            
            self.findGoodsSectionCell.filterView.selectedFilterBtnClosure = {[weak self] btn in
                if self!.isAnimatingFilterView{
                    return
                }
                self?.isAnimatingFilterView = true
                if self?.curFilterView != nil && self?.curFilterBtn == btn{//有弹窗 并且是当前弹窗,则隐藏该弹窗，有动画
                    self?.hideCurFilterContentView()
                }else{
                    self?.curFilterBtn?.isSelected = false
                    btn.isSelected = true
                    var isAnimation:Bool = false
                    if self?.curFilterView == nil {
                        isAnimation = true
                    }else{
                        isAnimation = false
                        self?.hideCurFilterContentView(isAnimation: false)
                    }
                    if btn.tag == 0 {
                        self?.curFilterView = self?.filterBestView
                    } else if btn.tag == 1 {
                        self?.curFilterView = self?.categoryFilterView
                    } else if btn.tag == 2 {
                        self?.curFilterView = self?.filterVelocityView
                    }else {
                        self?.curFilterView = self?.allFilterView
                    }
                    self?.showCurFilterContentView(isAnimation: isAnimation)
                    self?.curFilterBtn = btn
                }
            }
            return sectionCell
        } else {
            let sectionCell = collectionView.yqc_dequequeResuableCell(NearbyStallOwnerView.self, indexPath)
            self.nearbySellerSectionCell = sectionCell
            self.curContentCell = self.nearbySellerSectionCell
            return sectionCell
        }
    }
    
    //展示筛选视图
    func showCurFilterContentView(isAnimation:Bool = true){
        if self.curFilterView == nil {return}
        self.isAnimatingFilterView = true
        self.filterContentView.backgroundColor(UIColor(white: 0, alpha: 0.3)).dispose()
        self.showFilterView = true
        if self.isToTop{//到达顶部
           self.showFilterContentView()
        }else{
           self.scrollToTop()
        }
        self.filterContentView.addSubview(self.curFilterView!)
        
        if isAnimation {
            self.curFilterView!.transform = CGAffineTransform(translationX: 0, y: -self.curFilterView!.height)
            UIView.animate(withDuration: 0.4, animations: {
                self.curFilterView!.transform = .identity
            }) { (isFinished) in
            }
            UtilTool.dispatchAfter(seconds: 0.42) {
                self.isAnimatingFilterView = false
                self.filterContentView.emptyView.top = self.curFilterView?.bottom ?? 0
                self.curContentCell.filterView.filterBtnView.top = Constants.statusBarHeight + kSegmentHeadViewH +  kInputVH
                self.view.addSubview(self.curContentCell.filterView.filterBtnView)
            }
        }else{
            self.curFilterView!.transform = .identity
            self.isAnimatingFilterView = false
            self.filterContentView.emptyView.top = self.curFilterView?.bottom ?? 0
            self.curContentCell.filterView.filterBtnView.top = Constants.statusBarHeight + kSegmentHeadViewH +  kInputVH
            self.view.addSubview(self.curContentCell.filterView.filterBtnView)
        }
    }
    //隐藏筛选视图
    func hideCurFilterContentView(isAnimation:Bool = true){
        if self.curFilterView == nil {
            return
        }
        self.isAnimatingFilterView = true
        self.curFilterView?.transform = .identity
        
        self.curContentCell.filterView.filterBtnView.top = 0
        self.curContentCell.filterView.addSubview(self.curContentCell.filterView.filterBtnView)
        
        if isAnimation {
            UIView.animate(withDuration:0.4, animations: {
                self.curFilterView!.transform = CGAffineTransform(translationX: 0, y: -self.curFilterView!.height)
                self.filterContentView.backgroundColor(UIColor(white: 0, alpha: 0.01)).dispose()
            }) { (finished) in
                self.curFilterView?.removeFromSuperview()
                self.filterContentView.removeFromSuperview()
                self.showFilterView = false
                self.curFilterView = nil
                self.isAnimatingFilterView = false
            }
        }else{
            self.curFilterView!.transform = CGAffineTransform(translationX: 0, y: -self.curFilterView!.height)
            self.filterContentView.backgroundColor(UIColor(white: 0, alpha: 0.01)).dispose()
            self.curFilterView?.removeFromSuperview()
            self.filterContentView.removeFromSuperview()
            self.showFilterView = false
            self.curFilterView = nil
            self.isAnimatingFilterView = false
        }
    }
}
extension HomeViewController : BMKMapViewDelegate,BMKLocationServiceDelegate,BMKPoiSearchDelegate,BMKGeoCodeSearchDelegate {
    
    func didUpdate(_ userLocation: BMKUserLocation!) {
        locationService.stopUserLocationService()
        
        self.myLocationCoor = userLocation.location.coordinate
        
        let reverseGeoCodeOption = BMKReverseGeoCodeSearchOption()
        reverseGeoCodeOption.location = userLocation.location.coordinate
   
        let flag = geoCodeSearch.reverseGeoCode(reverseGeoCodeOption)
        if flag {
            NSLog("反地理编码检索成功")
        } else {
            NSLog("反地理编码检索失败")
        }
    }
     
    func onGetReverseGeoCodeResult(_ searcher: BMKGeoCodeSearch!, result: BMKReverseGeoCodeSearchResult!, errorCode error: BMKSearchErrorCode) {
        
        if error == BMK_SEARCH_RESULT_NOT_FOUND || result == nil{
            self.locationService.startUserLocationService()
        }else{
            let pois = result.poiList as! [BMKPoiInfo]
            let accuracyPoi = pois.first
            if accuracyPoi != nil {
               self.currentAddres = accuracyPoi!.name
            }else{
               self.currentAddres = ""
            }
            self.headerView.updateAddrBtn(title: self.currentAddres)
            self.loadData()
        }
    }
    func didFailToLocateUserWithError(_ error: Error!) {
        let errMsg = error.localizedDescription
        if errMsg.contains("错误 1") || errMsg.contains("错误1") || errMsg.contains("error1") || errMsg.contains("error 1"){
            
        }
    }
}
    
extension HomeViewController:XRCarouselViewDelegate {
      
    func carouselViewWillBeginDragging(){
        myTableView.isScrollEnabled = false
    }
    func carouselViewDidEndDragging(){
        if self.vcCanScroll {
            myTableView.isScrollEnabled = true
        }
    }
    func carouselViewDidEndScroll() {
        if self.vcCanScroll {
            myTableView.isScrollEnabled = true
        }
    }
}
