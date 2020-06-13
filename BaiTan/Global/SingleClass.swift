//
//  SingleClass.swift
//  FlashDelivery
//
//  Created by yanqunchao on 2020/5/24.
//  Copyright © 2020 yanqunchao. All rights reserved.
//

import UIKit

class SingleClass: NSObject {
    static let shared = SingleClass()
    private override init() { }
    /// 位置名
    var cityName : String = ""
    /// 城市ID
    var cityId : Int = 0
}
