//
//  DictionaryExtension.swift
//  LynxIOS
//
//  Created by yanqunchao on 2019/6/13.
//  Copyright © 2019 Global Hengtong (Beijing) Technology Co., Ltd. All rights reserved.
//

import Foundation

extension Dictionary {
    
    mutating func merge<S>(_ other: S)
        where S: Sequence, S.Iterator.Element == (key: Key, value: Value){
            for (k ,v) in other {
                self[k] = v
            }
    } 
}
