
//
//  ArrayExtension.swift
//  LynxIOS
//
//  Created by yanqunchao on 2020/3/4.
//  Copyright © 2020 Global Hengtong (Beijing) Technology Co., Ltd. All rights reserved.
//

import Foundation

extension Array {
    // 去重
    func filterDuplicates<E: Equatable>(_ filter: (Element) -> E) -> [Element] {
        var result = [Element]()
        for value in self {
            let key = filter(value)
            if !result.map({filter($0)}).contains(key) {
                result.append(value)
            }
        }
        return result
    }
}
