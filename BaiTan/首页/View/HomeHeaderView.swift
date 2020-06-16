
//
//  HomeHeaderView.swift
//  BaiTan
//
//  Created by yanqunchao on 2020/6/9.
//  Copyright © 2020 yanqunchao. All rights reserved.
//

import UIKit
let kSegmentHeadViewH:CGFloat = 45
let kInputVH:CGFloat = 60
let kLocationViewH:CGFloat = 40
let kRecommendSearchViewH:CGFloat = 30
let kCoverH:CGFloat = Constants.statusBarHeight + kLocationViewH + kInputVH
let kRecommendInputWords:[String] = ["太阳镜","凉皮","手持风扇","雨伞","苹果手机"]
let kBannerViewH:CGFloat = floor(87 *  (JWidth - 20) / 345)
let kItemSpace:CGFloat = 6
let kActivityItemW = (JWidth - 20 - kItemSpace) / 2
let kActivityItemsViewH = floor(kActivityItemW * 0.68) + 20
let kRightItemH:CGFloat = floor((kActivityItemsViewH - 20 - kItemSpace) / 2)

let kItemsFrames:[CGRect] = [CGRect(x: 0, y: 0, width: kActivityItemW, height: kActivityItemsViewH - 20),CGRect(x: kActivityItemW + kItemSpace, y: 0, width: kActivityItemW, height: kRightItemH),CGRect(x: kActivityItemW + kItemSpace, y:kItemSpace + kRightItemH, width: kActivityItemW, height: kRightItemH)]

let kItemImgs:[String] = ["itemLeft","itemRightTop","itemRightBottom"]
 
let kSegmentTitleArr = ["发现好货","附近摊主"]
      
class HomeHeaderView: UIView {
 
    var titleBtnArr = [UIButton]()
    var selTitleBtnIndex = 0
    var selectBtnIndexClosure:IntClosure?
    var btnCenterDistance:CGFloat = 0
    var dotCenterX:CGFloat = 0
    
    lazy var dotView:UIView = {
        let dotView = UIView(frame: CGRect(x: 0, y: 0, width: 13, height: 4)).cornerRadius(2).backgroundColor(Constants.APP_MAIN_COLOR)
        return dotView
    }()
    
    lazy var addressBtn:UIButton = {
        let addressBtn = UIButton(frame:CGRect(x: 0, y: 0, width: 100, height: kLocationViewH)).titleColor(Constants.k33Color).textFont(UIFont.systemFont(ofSize: 16, weight: .medium)).image(UIImage(named: "home_nav_arrow")!.qc_imageChangeColor(color: Constants.k33Color)).title("获取定位中...")
            .layoutButton(.right, 3, true).addAction { (_) in
                print("点击了定位按钮")
        }
        return addressBtn
    }()
    
    lazy var locationCover:UIView = {
        let cover = UIView(frame: CGRect(x: 0, y: 0, width: JWidth, height: kCoverH)).backgroundColor(.white).isUserInteractionEnabled(false)
        return cover
    }()
    
    lazy var locationBg:UIView = {
        let locationBg = UIView(frame: CGRect(x: 0, y: 0, width: JWidth, height: Constants.statusBarHeight + kLocationViewH + kInputVH)).backgroundColor(Constants.APP_MAIN_COLOR)
        return locationBg
    }()
    
    lazy var locationView:UIView = {
        let locationView = UIView(frame: CGRect(x: 0, y: Constants.statusBarHeight, width: JWidth, height: kLocationViewH))
        let locIcon = UIImageView(frame: CGRect(x: 10, y: 0, width: 20, height: kLocationViewH)).image("home_nav_location").contentMode(.scaleAspectFit).superView(locationView)
        locIcon.image = locIcon.image?.qc_imageChangeColor(color: Constants.k33Color)
        self.addressBtn.left = locIcon.right
        locationView.addSubview(self.addressBtn)
        return locationView
    }()
    lazy var segmentHeaderView:UIView = {
      self.titleBtnArr.removeAll()
       
      let headerView =  UIView(frame: CGRect(x: 0, y: 0, width: JWidth, height: kSegmentHeadViewH)).backgroundColor(Constants.APP_BACKGROUND_COLOR)
        
     headerView.addSubview(self.dotView)
        
        let btnHeight:CGFloat = 32
        let btnWidth:CGFloat = 90
        let space:CGFloat = 30
        let startX:CGFloat = 10
        
        
        self.btnCenterDistance = btnWidth + space
      
        for (i,title) in kSegmentTitleArr.enumerated() {
        let btn = UIButton()
            .frame(CGRect(x: (space + btnWidth) * CGFloat(i) + startX, y: 5, width: btnWidth, height: btnHeight))
            .titleColor(Constants.k96Color)
            .titleColor_Sel(Constants.k33Color)
            .adjustsImageWhenHighlighted(false)
            .title(title)
            .textFont(UIFont.DINAlternateBold(size: 22))
            .addAction {[weak self] (btn) in
                self?.setCurSelBtn(index: i)
            }
         
            self.titleBtnArr.append(btn)
            headerView.addSubview(btn)
            if i == 0 {
                self.dotView.top = btn.bottom
                dotCenterX = btn.centerX - self.dotView.width * 0.5
                self.dotView.centerX = dotCenterX
            }
      }
      setCurSelBtn(index: self.selTitleBtnIndex)
      return headerView
    }()
    
    func setCurSelBtn(index:Int) {
        self.selTitleBtnIndex = index
        selectBtnIndexClosure?(self.selTitleBtnIndex)
        for (btnIndex,titleBtn) in self.titleBtnArr.enumerated() {
            if index == btnIndex {
               titleBtn.isSelected(true).dispose()
            } else {
               titleBtn.isSelected(false).dispose()
            }
        }
    }
    lazy var marqueeView:MarqueeView = {
        let marqueeView = (MarqueeView.viewFromXib() as! MarqueeView).backgroundColor(Constants.kBtnDisableColor).cornerRadiusWithClip(18)
        marqueeView.frame = CGRect(x: 10, y: 12, width: JWidth - 20, height: 36)
        return marqueeView
    }()
    
    lazy var inputV:UIView = {
        let inputView = UIView(frame: CGRect(x: 0, y: Constants.statusBarHeight + kLocationViewH, width: JWidth, height: kInputVH)).backgroundColor(Constants.APP_BACKGROUND_COLOR).cornerRadius(30, [.topLeft,.topRight])
         
        return inputView
    }()
    lazy var recommendSearchView:UIView = {
        let view = UIView(frame: CGRect(x: 0, y: Constants.statusBarHeight + kLocationViewH + kInputVH, width: JWidth, height: kRecommendSearchViewH)).backgroundColor(Constants.APP_BACKGROUND_COLOR)
        let startX:CGFloat = 10
        let font = UIFont.systemFont(ofSize: 10,weight: .regular)
        let space:CGFloat = 6
        var btnMaxX = startX
        for (i,title) in kRecommendInputWords.enumerated() {
           let btnWidth = title.widthWithFont(font: font, maxHeight: 20) + 20
          let btn = UIButton()
            .backgroundColor(Constants.kBtnDisableColor)
            .titleColor(Constants.k33Color)
            .adjustsImageWhenHighlighted(false)
            .cornerRadiusWithClip(20 * 0.5)
            .title(title)
            .textFont(font)
            .frame(CGRect(x: btnMaxX, y: 0, width: btnWidth, height: 20))
            .superView(view)
            .addAction {[weak self] (btn) in

            }
            btnMaxX = btn.right + space
        }
        return view
    }()  
    var bannerImages:[String] = [] {
        didSet{
            self.bannerView.imageArray = bannerImages
        }
    }
    lazy var bannerView:XRCarouselView = {
        let bannerView = XRCarouselView(frame:  CGRect(x: 0, y: Constants.statusBarHeight + kLocationViewH + kInputVH + kRecommendSearchViewH, width: JWidth, height:  kBannerViewH), imageBorder: 10)!
        bannerView.pagePosition = .PositionHide
        bannerView.time = 4
        bannerView.placeholderImage = UIImage(named: "default")
        bannerView.imageClickBlock = {[weak self] index in
            
            bannerView.stopTimer()
        }
        return bannerView
    }()
    
    lazy var activityItemsView:UIView = {
        let view = UIView(frame: CGRect(x: 10, y: self.bannerView.bottom + 10, width: JWidth - 20, height: kActivityItemsViewH - 20))
        for (i,frame) in kItemsFrames.enumerated() {
            let iv = UIImageView(frame: frame).image(kItemImgs[i]).contentMode(.scaleAspectFill) .cornerRadiusWithClip(10)
            view.addSubview(iv)
        }
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Constants.APP_BACKGROUND_COLOR
        self.addSubview(self.locationBg)
        self.addSubview(self.locationView)
        self.addSubview(self.recommendSearchView)
        self.addSubview(self.bannerView)
        self.addSubview(self.activityItemsView)
        self.addSubview(self.locationCover)
        self.addSubview(self.inputV)
        self.inputV.addSubview(marqueeView)
        
        segmentHeaderView.top = self.height - segmentHeaderView.height
        self.addSubview(segmentHeaderView)
    }
    func updateAddrBtn(title:String) {
        self.addressBtn.title(title).layoutButton(.right, 3, true).dispose()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
 
