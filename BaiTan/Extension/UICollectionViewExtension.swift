//
//  UICollectionViewExtension.swift
//  LynxIOS
//
//  Created by admin on 2019/3/15.
//  Copyright © 2019 Global Hengtong (Beijing) Technology Co., Ltd. All rights reserved.
//

import UIKit

extension UICollectionView {
     
    func registerCell<T:UICollectionViewCell>(_ cell:T.Type) {
        if cell.getNibPath() != nil {
            self.register(UINib.init(nibName: cell.getResuableID(), bundle: nil), forCellWithReuseIdentifier: cell.getResuableID())
        }else{
            self.register(cell, forCellWithReuseIdentifier: cell.getResuableID())
        }
    }
    
    func yqc_dequequeResuableCell<T:UICollectionViewCell>(_ cellClass:T.Type,_ indexPath:IndexPath)->T {
        return dequeueReusableCell(withReuseIdentifier: cellClass.getResuableID(), for: indexPath) as! T
    }
    
    func registerReusableHeaderView<T:UICollectionReusableView>(_ view:T.Type) {
        if view.getNibPath() != nil {
            self.register(UINib.init(nibName: view.getResuableID(), bundle: nil), forSupplementaryViewOfKind: "UICollectionElementKindSectionHeader", withReuseIdentifier: view.getResuableID())
        }else{
            self.register(T.self, forSupplementaryViewOfKind: "UICollectionElementKindSectionHeader", withReuseIdentifier: view.getResuableID())
        }
    }
    func registerReusableFooterView<T:UICollectionReusableView>(_ view:T.Type) {
        if view.getNibPath() != nil {
            self.register(UINib.init(nibName: view.getResuableID(), bundle: nil), forSupplementaryViewOfKind: "UICollectionElementKindSectionFooter", withReuseIdentifier: view.getResuableID())
        }else{
            self.register(T.self, forSupplementaryViewOfKind: "UICollectionElementKindSectionFooter", withReuseIdentifier: view.getResuableID())
        }
    }
    func yqc_dequequeResuableHeader<T:UICollectionReusableView>(_ viewClass:T.Type,_ indexPath:IndexPath)->T {
        return dequeueReusableSupplementaryView(ofKind: "UICollectionElementKindSectionHeader", withReuseIdentifier: T.getResuableID(), for: indexPath) as! T
    }
    func yqc_dequequeResuableFooter<T:UICollectionReusableView>(_ viewClass:T.Type,_ indexPath:IndexPath)->T {
        return dequeueReusableSupplementaryView(ofKind: "UICollectionElementKindSectionFooter", withReuseIdentifier: T.getResuableID(), for: indexPath) as! T
    }
    
}
