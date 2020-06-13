//
//  NearbyStallOwnerCell.swift
//  BaiTan
//
//  Created by yanqunchao on 2020/6/10.
//  Copyright © 2020 yanqunchao. All rights reserved.
//

import UIKit
import SwiftyJSON

class NearbyStallOwnerCell: UITableViewCell {

    @IBOutlet weak var icon: UIImageView!
    
    @IBOutlet weak var ageLab: UILabel!
    @IBOutlet weak var nameLab: UILabel!
    
    @IBOutlet weak var distanceLab: UILabel!
    
    @IBOutlet weak var signLab: UILabel!
    
    @IBOutlet weak var sellCountLab: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }
    
    class func getCellHeight(model:JSON)->CGFloat {
        var height = model["sign"].stringValue.heightWithFont(font: UIFont.systemFont(ofSize: 13), maxWidth: JWidth - 20 - 101 - 76)
        if height > 32 {
            height = 32
        }
        return 77 + height + 10
    }
    
    var model:JSON = JSON() {
        didSet{
            self.icon.image = UIImage(named: model["icon"].stringValue)
            self.nameLab.text = model["name"].stringValue
            self.distanceLab.text = "\(model["distance"].intValue)米"
            self.ageLab.text = "\(model["age"].intValue)岁"
            self.signLab.text = model["sign"].stringValue
            self.sellCountLab.text = "已卖\(model["sellCount"])件好货"
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
 
    }
    
    override var frame: CGRect {
       didSet{
           var newFrame = frame
           newFrame.origin.y += 10
           newFrame.origin.x += 10
           newFrame.size.width -= 20
           newFrame.size.height -= 10
           super.frame = newFrame
       }
    }
}
