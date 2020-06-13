//
//  TestAlertContentView.swift
//  LynxIOS
//
//  Created by yanqunchao on 2019/6/19.
//  Copyright © 2019 Global Hengtong (Beijing) Technology Co., Ltd. All rights reserved.
//

import UIKit

class TestAlertContentView: YQCAlertContentView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func dismiss(_ sender: Any) {
        dismiss()
    }
    
    @IBAction func ensureBtnClicked(_ sender: Any) {
        dismiss()
    }
}
