//
//  FilterBestCell.swift
//  BaiTan
//
//  Created by yanqunchao on 2020/6/11.
//  Copyright © 2020 yanqunchao. All rights reserved.
//

import UIKit
import SwiftyJSON
class FilterBestCell: UITableViewCell {
    
    @IBOutlet weak var titleLab: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    var model:FilterBestModel = FilterBestModel(){
        didSet{
            self.titleLab.text = model.title
            self.titleLab.textColor = model.isSelected ? Constants.APP_MAIN_COLOR : Constants.k33Color
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated) 
    }
    
}
