//
//  BaseScrollView.swift
//  BaiTan
//
//  Created by yanqunchao on 2020/6/20.
//  Copyright © 2020 yanqunchao. All rights reserved.
//

import UIKit

class BaseScrollView: UIScrollView {

  func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
      return true
  }
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        print(self)
        return super.hitTest(point, with: event)
    }

}
