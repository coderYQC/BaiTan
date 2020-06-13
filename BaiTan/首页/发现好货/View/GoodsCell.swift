//
//  GoodsCell.swift
//  BaiTan
//
//  Created by yanqunchao on 2020/6/7.
//  Copyright © 2020 yanqunchao. All rights reserved.
//

import UIKit

class GoodsCell: UICollectionViewCell {
 
    @IBOutlet weak var productIcon: UIImageView!
    
    @IBOutlet weak var productName: UILabel!
    
    @IBOutlet weak var priceLab: UILabel!
    
    @IBOutlet weak var sellerHeadIcon: UIImageView!
    
    @IBOutlet weak var sellerNameLab: UILabel!
     
    @IBOutlet weak var bottomHConst: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.cornerRadiusWithClipNoChain(8)
    }
    class func getCellHeight(model:GoodsModel)->CGFloat {
        let cellHeight =  94 + (JWidth - 30) * 0.5 / model.sizeScale - 20
            
        let height = model.name.heightWithFont(font: UIFont.systemFont(ofSize: 16,weight: .medium), maxWidth: (JWidth - 30) * 0.5 - 16)
        
        return cellHeight + height
    }
    var goods:GoodsModel! {
        didSet{
            self.productIcon.image = UIImage(named: goods.icon)
            self.productName.text = goods.name
            self.priceLab.attributedText = UtilTool.getPriceAttributeStr(prefixStr: "￥", prePrice: goods.price)
            self.sellerNameLab.text = goods.sellerName
            self.sellerHeadIcon.image = UIImage(named: goods.sellerHeadIcon)
            self.bottomHConst.constant = 80 +  goods.name.heightWithFont(font: self.productName.font, maxWidth: (JWidth - 30) * 0.5 - 16)
        }
    }
}
