//
//  Extension.swift
//  LynxIOS
//
//  Created by yanqunchao on 2019/5/23.
//  Copyright © 2019 Global Hengtong (Beijing) Technology Co., Ltd. All rights reserved.
//

import Foundation
extension NSObject {
    // MARK:返回className
    var className:String{
        get{
            let name =  type(of: self).description()
            if(name.contains(".")){
                return name.components(separatedBy: ".")[1];
            }else{
                return name;
            }
        }
    }
    func qc_getIvar(name: String) -> Any? {
        guard let _var = class_getInstanceVariable(type(of: self), name) else {
            return nil
        }
        return object_getIvar(self, _var)
    }
    

}
