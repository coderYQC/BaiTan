//
//  UILabelExtension.swift
//  LynxIOS
//
//  Created by 严群超 on 2018/10/10.
//  Copyright © 2018年 Global Hengtong (Beijing) Technology Co., Ltd. All rights reserved.
//

import UIKit

extension UILabel {
    public func addDeletingLine(text:String,deletingLinecolor:UIColor) -> NSMutableAttributedString {
        let attr = NSMutableAttributedString(string: text)
        attr.addAttribute(NSAttributedStringKey.strikethroughStyle, value: NSNumber(value: 1), range: NSMakeRange(0, text.count))
        attr.addAttribute(NSAttributedStringKey.strikethroughColor, value: deletingLinecolor,range: NSMakeRange(0, text.count))
        return attr
    }
    public func setLabelSpace(str:String,font:UIFont,lineSpace:CGFloat,paragraphSpacing:CGFloat? = nil) {
        self.numberOfLines = 0
        let paraStyle = NSMutableParagraphStyle.init()
        paraStyle.lineBreakMode = .byCharWrapping
        paraStyle.alignment = .left
        paraStyle.hyphenationFactor = 1
        paraStyle.firstLineHeadIndent = 0
        paraStyle.paragraphSpacingBefore = 0
        paraStyle.headIndent = 0
        paraStyle.tailIndent = 0
        paraStyle.lineSpacing = lineSpace
        if paragraphSpacing != nil {
            paraStyle.paragraphSpacing = paragraphSpacing!
        }
        let dic = [kCTFontAttributeName:font,kCTParagraphStyleAttributeName:paraStyle]
        let attributeStr = NSAttributedString(string: str, attributes: dic as [NSAttributedStringKey : Any])
        self.attributedText = attributeStr
    } 
}
