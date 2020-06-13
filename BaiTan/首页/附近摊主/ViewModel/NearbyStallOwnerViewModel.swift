//
//  NearbyDynamicsViewModel.swift
//  BaiTan
//
//  Created by yanqunchao on 2020/6/6.
//  Copyright © 2020 yanqunchao. All rights reserved.
//

import UIKit
import YQCKit
import SwiftyJSON

class NearbyStallOwnerViewModel: QCListViewModel {
    
    override func loadMainData(isMore: Bool = false, param: [String : Any]) {
        super.loadMainData(isMore: isMore, param: param)
         
        UtilTool.dispatchAfter(seconds: 1) {
            self.handlePagableData(array: self.createModel(count: self.page == 5 ? 5 : 10))
        }
    }
    
    func createModel(count:Int)->[JSON] {
        var array:[JSON] = []
         for i in 0...count {
            var model = JSON()
            model["icon"].string = i % 3 == 0 ? "headIcon0" : (i % 3 == 1 ? "headIcon1" : "headIcon2")
         
            model["name"].string = i % 3 == 0 ? "adorKableraccoon" : (i % 3 == 1 ? "似乎你" : "林慕容")
            model["age"].int = i % 3 == 0 ? 20 : (i % 3 == 1 ? 18 : 28)
            model["sign"].string = i % 3 == 0 ? "你的手是我不能触及的倾城温暖，我的心是你不曾知晓的兵荒马乱" : (i % 3 == 1 ? "人情世故，总是那么复杂，人的一生一半就在犯贱，还有一半就在娱乐。" : "沉默是金。")
            model["sellCount"].int = i % 3 == 1000 ? 20 : (i % 3 == 1 ? 3002 : 201)
            model["distance"].int = i % 3 == 1000 ? 20 : (i % 3 == 1 ? 150 : 300)
            array.append(model)
         }
        return array
        
    }
}
