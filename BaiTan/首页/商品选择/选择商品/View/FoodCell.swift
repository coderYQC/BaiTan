//
//  FoodCell.swift
//  BaiTan
//
//  Created by yanqunchao on 2020/6/16.
//  Copyright © 2020 yanqunchao. All rights reserved.
//

import UIKit
import SwiftyJSON
class FoodCell: UITableViewCell {

    @IBOutlet weak var iconView: UIImageView!
    
    @IBOutlet weak var descLab: UILabel!
    @IBOutlet weak var nameLab: UILabel!
    @IBOutlet weak var sellCountLab: UILabel!
    @IBOutlet weak var priceLab: UILabel!
    
    @IBOutlet weak var cornerLab: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
         
    }

    var model:JSON = JSON() {
        didSet{ 
            self.iconView.kfImage("https://elm.cangdu.org/img/\(model["image_path"].stringValue)")
            self.nameLab.text = model["name"].stringValue
            self.descLab.text = model["description"].stringValue
            self.sellCountLab.text = model["tips"].stringValue
            
            let specfood = model["specfoods"].arrayValue.first!
            
            let price = specfood["price"].intValue
            let original_price = specfood["original_price"].intValue
            self.priceLab.attributedText = UtilTool.getPriceAttributeStr(prefixStr: "￥", prePrice: original_price, postPrice: price, unit: "", suffixStr: "")
            
            let attributes = model["attributes"].arrayValue
            self.cornerLab.isHidden = attributes.count > 0
            if attributes.count > 0 {
                let attribute = attributes.first!
                let icon_name = attribute["icon_name"].stringValue
                let icon_color = attribute["icon_color"].stringValue
                self.cornerLab.text = " \(icon_name) "
                self.cornerLab.backgroundColor = UIColor(hexString: "#\(icon_color)")
            }
 
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
 
