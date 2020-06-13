//
//  NSUserDefaults+Extension.swift
//  LynxIOS
//
//  Created by 严群超 on 2018/7/26.
//  Copyright © 2018年 叶波. All rights reserved.
//

import Foundation

extension UserDefaults { //1
    
    func saveCustomObject(customObject object: NSCoding, key: String) { //2
        let encodedObject = NSKeyedArchiver.archivedData(withRootObject: object)
        self.set(encodedObject, forKey: key)
        self.synchronize()
    }
    
    func getCustomObject(forKey key: String) -> AnyObject? { //3
        let decodedObject = self.object(forKey: key) as? NSData
        
        if let decoded = decodedObject {
            let object = NSKeyedUnarchiver.unarchiveObject(with: decoded as Data)
            return object as AnyObject
        }
        return nil
    }
}
