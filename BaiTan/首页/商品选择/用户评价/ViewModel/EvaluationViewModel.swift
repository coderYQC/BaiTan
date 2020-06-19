//
//  EvaluationViewModel.swift
//  BaiTan
//
//  Created by yanqunchao on 2020/6/18.
//  Copyright © 2020 yanqunchao. All rights reserved.
//

import UIKit
import YQCKit
import SwiftyJSON
class EvaluationViewModel: QCListViewModel {
    override func loadMainData(isMore: Bool = false, param: [String : Any]) {
          super.loadMainData(isMore: isMore, param: param)
           
        UtilTool.dispatchAfter(seconds: 0.2) {
              self.handlePagableData(array: self.createModel(count: self.page == 3 ? 5 : 10))
          }
      }
    
    func createModel(count:Int)->[JSON] {
        var array:[JSON] = []
         for i in 0...count {
            let model = JSON()
            array.append(model)
         }
        return array
        
    }
}
