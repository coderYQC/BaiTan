//
//  JYHomeNavView.swift
//  LynxIOS
//
//  Created by hqht on 2019/9/10.
//  Copyright © 2019 Global Hengtong (Beijing) Technology Co., Ltd. All rights reserved.
//

import UIKit
import SwiftyJSON

class JYHomeNavView: UIView {
 
    fileprivate var myLocationCoor :CLLocationCoordinate2D?
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var locationLable: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib() 
         
    }
    
    
    @IBAction func newsBtnTap(_ sender: Any) {
         
    }
    
    @IBAction func searchBtnTap(_ sender: Any) {
        
//        let searchVc = UtilTool.getVcBySbAndVcName(sb: "category", vc: "searchController") as! SearchController
//        searchVc.searchEntrance = "首页"
//        UtilTool.pushViewController(vc: searchVc)
    }
    
    @IBAction func voiceBtnTap(_ sender: Any) {
     
    }
}


extension JYHomeNavView{
     
    @IBAction func selectLocation(_ sender: Any) {
    }
    
    func updateAddrBtn(title:String) {
        
        
//        var addr = title
//        if addr.hasSuffix("市") {
//            addr = addr.subString(start: 0, length: addr.count - 1)
//        }
//        if title.count > 6 {
//            addr = title.replacingCharacters(in: title.toRange(NSRange.init(location: 6, length: title.count - 6))!, with: "...")
//        }
//        locationLable.text = addr
    }
}
 
