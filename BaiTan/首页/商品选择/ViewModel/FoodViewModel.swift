//
//  FoodViewModel.swift
//  BaiTan
//
//  Created by yanqunchao on 2020/6/16.
//  Copyright © 2020 yanqunchao. All rights reserved.
//
//https://elm.cangdu.org/shopping/v2/menu?restaurant_id=1
import UIKit

class FoodViewModel: NSObject {
    var menuList:[String] = []
    var goodsList:[GroupModel] = []
    func loadMenuListData(id:Int,success:ClickClosure?,fail:FailClosure?){
        
        RequestUtil.get("https://elm.cangdu.org/shopping/v2/menu?restaurant_id=\(id+1)", params: [:], successHandler: { (data) in
            for food in data.arrayValue {
                self.menuList.append(food["name"].stringValue)
                let group = GroupModel()
                group.title = food["description"].stringValue
                group.goodsArr = food["foods"].arrayValue
                self.goodsList.append(group)
            }
            success?()
        }) { (err) in
             fail?(err)
        }
        
    }
    
}
