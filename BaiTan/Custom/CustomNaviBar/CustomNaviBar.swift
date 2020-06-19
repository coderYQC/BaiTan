//
//  CustomNaviBar.swift
//  LynxIOS
//
//  Created by yanqunchao on 2019/3/16.
//  Copyright © 2019 Global Hengtong (Beijing) Technology Co., Ltd. All rights reserved.
//

import UIKit

typealias statusBarChangeClosure = (UIStatusBarStyle) ->()

let kNaviBtnH:CGFloat = 44

class CustomNaviBar: UIView {
  
    var titleLab: UILabel!
    var bottomLine: UILabel!
    var rightItemsView: UIView!
    var backBtn: UIButton!
    
    var titleView:UIView?{
        didSet{
            if titleView != nil {
                if !self.subviews.contains(titleView!){
                    self.addSubview(titleView!)
                }
                titleView!.centerX = self.centerX
                titleView?.backgroundColor = .clear
                titleView!.top = self.height - titleView!.height
            }
        }
    }
    var isOnlyChangeBackgroundColor:Bool = false
    var isChangeTitleLabelBackgroundColor:Bool = false
 
    var statusBarChange:statusBarChangeClosure?
    var leftBtnClick:ClickClosure?
    var statusBarStyle: UIStatusBarStyle? = UIStatusBarStyle.default {
        didSet{
            self.statusBarChange?(statusBarStyle!)
        }
    }
    var rightBtns:[UIButton] = []
    var title:String = "" {
        didSet {
            self.titleLab.text = title
        }
    }
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        //顶部页面标题文字颜色和字体大小
//        self.bottomLine.backgroundColor = UIColor.lightGray
//        self.lineH.constant = 0.5
//        self.rightItemsWConst.constant = 50
//        self.titleWConst.constant = JWidth - 100
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backBtn = UIButton().frame(0, self.height - kNaviBtnH, 60, kNaviBtnH).superView(self).addAction({[weak self] (_) in
            self?.leftBtnClick?()
        })
        self.rightItemsView = UIView().frame(self.width - 60, self.height - kNaviBtnH, 60, kNaviBtnH).superView(self)
        self.titleLab = UILabel().frame(self.backBtn.left, self.height - kNaviBtnH, self.width - self.backBtn.width - self.rightItemsView.width, kNaviBtnH).font(20).textColor(.black).superView(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
    func configureRightBtns(_ btnImages:[String], _ closure:IntClosure?) {
        self.rightItemsView.width = 35 * CGFloat(btnImages.count) + 10
        self.rightItemsView.left = self.width - self.rightItemsView.width
        self.titleLab.width = JWidth - self.rightItemsView.width * 2
        self.titleLab.centerX = self.centerX
        self.rightBtns.removeAll()
        if btnImages.count == 1 {
            let btn = UIButton()
                .frame(self.rightItemsView.bounds)
            .image(btnImages.first!)
            .backgroundColor(.clear)
            .adjustsImageWhenHighlighted(false)
            .contentMode(.center)
            .superView(self.rightItemsView)
            .addAction { (btn) in
                closure?(0)
            }
            self.rightBtns.append(btn)
        }else{
            for (i,img) in btnImages.enumerated(){
                let btn = UIButton()
                .frame(35 * CGFloat(i), 0, 35,kNaviBtnH)
                .image(img)
                .backgroundColor(.clear)
                .contentMode(.center)
                .superView(self.rightItemsView)
                .addAction { (btn) in
                    closure?(i)
                }  
                self.rightBtns.append(btn)
            }
        }
        
    }
    var scale:CGFloat = 1 {
        didSet{
            if self.isOnlyChangeBackgroundColor {
                self.backgroundColor = UIColor.init(white: 1, alpha: scale > 1 ? 1 : scale)
                bottomLine?.alpha = scale > 1 ? 1 : scale
                if self.isChangeTitleLabelBackgroundColor {
                    self.titleLab.alpha = scale > 1 ? 1 : scale
                }
            }else{
                if scale < 0.5 {
                    self.statusBarStyle? = UIStatusBarStyle.lightContent
                    titleLab?.textColor = UIColor(white: 1 , alpha: 1)
                }else{
                    self.statusBarStyle? = UIStatusBarStyle.default
                    titleLab?.textColor = UIColor(white: 1 - (scale > 1 ? 1 : scale) , alpha: 1)
                }
                self.backgroundColor = UIColor.init(white: 1, alpha: scale > 1 ? 1 : scale)
                bottomLine?.alpha = scale > 1 ? 1 : scale
                backBtn?.setImage(backBtn?.imageView?.image?.imageChangeColor(color: (titleLab?.textColor)!), for: .normal)
//                rightBtn?.setImage(rightBtn.imageView?.image?.imageChangeColor(color: (titleLab?.textColor)!), for: .normal)
                
            } 
         }
    }
}
