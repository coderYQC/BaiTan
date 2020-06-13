
//
//  LoadViewManager.swift
//  LynxIOS
//
//  Created by 严群超 on 2018/7/19.
//  Copyright © 2018年 叶波. All rights reserved.
//

//分类页缺省页封装
import UIKit

class LoadViewManager: NSObject {
    static var bgView : UIView? = nil
    static var imgView :UIImageView? = nil
    static var titleLab :UILabel? = nil
    static var button :UIButton? = nil
    static var indicatorView :UIActivityIndicatorView? = nil
    
    class func showLoadingViewOnView(view: UIView?) {
        bgView?.removeFromSuperview()
        bgView = UIView.init(frame: (view?.bounds)!)
        bgView?.backgroundColor = Constants.APP_BACKGROUND_COLOR
        indicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        indicatorView?.hidesWhenStopped = true
        bgView?.addSubview(indicatorView!)
        indicatorView?.startAnimating()
        indicatorView?.centerX = (bgView?.centerX)!
        indicatorView?.centerY = (bgView?.centerY)!
        let indicatorMaxY = (indicatorView?.bottom)! + 18
        titleLab = UILabel(frame: CGRect(x: 0, y: indicatorMaxY, width: (bgView?.width)!, height: 10))
        titleLab?.text = "正在加载..."
        titleLab?.font = UIFont.systemFont(ofSize: 13)
        titleLab?.textColor = UIColor.colorFromRGB(0x9a9a9a)
        titleLab?.textAlignment = .center
        bgView?.addSubview(titleLab!)
        view?.addSubview(bgView!)
        view?.bringSubview(toFront: bgView!)
    }
    
    
    class func showLoadFailedOnView(view: UIView?, target: Any?, action: Selector) {
        bgView?.removeFromSuperview()
        bgView = UIView.init(frame: (view?.bounds)!)
        bgView?.backgroundColor = Constants.APP_BACKGROUND_COLOR
        
        let image = UIImage(named: "NO_NET")
        imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: (image?.size.width)!, height: (image?.size.height)!))
        imgView?.centerX = (bgView?.centerX)!
        imgView?.centerY = (bgView?.centerY)! - 80
        imgView?.image = image
        bgView?.addSubview(imgView!) 
        let imgMaxY = (imgView?.bottom)! + 18
        titleLab = UILabel(frame: CGRect(x: 0, y: imgMaxY, width: (bgView?.width)!, height: 12))
        titleLab?.text = "网络请求失败,请检查网络"
        titleLab?.font = UIFont.systemFont(ofSize: 13)
        titleLab?.textColor = UIColor.colorFromRGB(0x9a9a9a)
        titleLab?.textAlignment = .center
        bgView?.addSubview(titleLab!)
        
        button = UIButton(type: .custom)
        button?.frame = CGRect(x: ((bgView?.width)! - 100) * 0.5, y: (titleLab?.bottom)! + 40, width: 100, height: 30)
        button?.centerX = (titleLab?.centerX)!
        button?.addTarget(target, action: action, for: .touchUpInside)
        button?.setTitle("重新加载", for: .normal)
        button?.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button?.setTitleColor(UIColor.colorFromRGB(0x9a9a9a), for: .normal)
        button?.layer.borderColor =  UIColor.colorFromRGB(0x9a9a9a).cgColor
        button?.layer.borderWidth = 1
        button?.layer.cornerRadius = 5
        button?.layer.masksToBounds = true
        bgView?.addSubview(button!)
        
        view?.addSubview(bgView!)
        view?.bringSubview(toFront: bgView!)
        
    }
  
    class func hideLoadView() {
        self.indicatorView?.stopAnimating()
        bgView?.removeFromSuperview()
    }

}
