//
//  NearTanerViewModel.swift
//  BaiTan
//
//  Created by yanqunchao on 2020/6/6.
//  Copyright © 2020 yanqunchao. All rights reserved.
//

import UIKit
import YQCKit
class FindGoodsViewModel: QCListViewModel {
    override func loadMainData(isMore: Bool = false, param: [String : Any]) {
        super.loadMainData(isMore: isMore, param: param)
         
        
        UtilTool.dispatchAfter(seconds: 1) {
            self.handlePagableData(array: self.createModel(count: self.page == 5 ? 5 : 10))
        }
    }
    
    func createModel(count:Int)->[GoodsModel] {
        var array:[GoodsModel] = []
         for i in 0...count {
             let model = GoodsModel()
             model.name = i % 3 == 0 ? "越南红肉菠萝蜜" : (i % 3 == 1 ? "最新HuaWei/华为" : "全新带吊定树莓红茶中")
             model.icon = "image\(i % 3)"
             model.sellerName = "\(i % 2 == 0 ? "旺旺007" : "我滴黑猫")"
             model.sellerHeadIcon = "\(i % 2 == 0 ? "sellerIcon0" : "sellerIcon1")"
             model.price = 100000 + (i % 2) * 3000
            model.sizeScale = i % 3 == 0 ? 0.76 : (i % 3 == 1 ? 0.77 : 1)
             array.append(model)
         }
        return array
        
    }
}
