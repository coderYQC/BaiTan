//
//  CategoryCell.swift
//  BaiTan
//
//  Created by yanqunchao on 2020/6/15.
//  Copyright © 2020 yanqunchao. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {

    @IBOutlet weak var titleLab: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.backgroundColor = selected ? .white : Constants.kBtnDisableColor 
    }
    
}
