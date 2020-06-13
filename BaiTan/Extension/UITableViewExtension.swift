//
//  UITableViewExtension.swift
//  LynxIOS
//
//  Created by admin on 2019/3/15.
//  Copyright © 2019 Global Hengtong (Beijing) Technology Co., Ltd. All rights reserved.
//

import UIKit


extension UITableView {
 
    func registerCell<T:UITableViewCell>(_ cell:T.Type) {
        
        self.separatorStyle = .none
        
        if cell.getNibPath() != nil {
            self.register(UINib.init(nibName: cell.getResuableID(), bundle: nil), forCellReuseIdentifier: cell.getResuableID())
        }else{
            self.register(cell, forCellReuseIdentifier: cell.getResuableID())
        }
    }
    
    func yqc_dequequeResuableCell<T:UITableViewCell>(_ cellClass:T.Type)->T {
        
        var cell = dequeueReusableCell(withIdentifier: cellClass.getResuableID()) as? T
        if cell == nil {
            registerCell(T.self)
            cell = dequeueReusableCell(withIdentifier: cellClass.getResuableID()) as? T
        }
        cell!.selectionStyle = .none
        return cell!
    }
}
