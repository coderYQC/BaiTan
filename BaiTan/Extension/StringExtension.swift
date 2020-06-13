//
//  StringExtension.swift
//  LynxIOS
//
//  Created by 叶波 on 2018/5/7.
//  Copyright © 2018年 叶波. All rights reserved.
//

import UIKit

extension String {
    
    //根据开始位置和长度截取字符串
    func subString(start:Int, length:Int) -> String {
//        var len = length
//        if len == -1 {
//            len = self.count - start
//        }
        let st = self.index(startIndex, offsetBy:start)
        let en = self.index(startIndex, offsetBy:start + length)
        return String(self[st ..< en])
    }
    
    func toRange(_ range: NSRange) -> Range<String.Index>? {
        guard let from16 = utf16.index(utf16.startIndex, offsetBy: range.location, limitedBy: utf16.endIndex) else { return nil }
        guard let to16 = utf16.index(from16, offsetBy: range.length, limitedBy: utf16.endIndex) else { return nil }
        guard let from = String.Index(from16, within: self) else { return nil }
        guard let to = String.Index(to16, within: self) else { return nil }
        return from ..< to
    }
    
    /// 扩展字符串的size
    ///
    /// - Parameters:
    ///   - font: 字体大小
    ///   - maxSize: 最大值
    /// - Returns: 返回size
    func sizeWithFont(font:UIFont,maxSize:CGSize)->CGSize{
        let attrs = [NSAttributedStringKey.font:font]
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        return self.boundingRect(with: maxSize, options: option, attributes: attrs, context: nil).size
    }
    
    func heightWithFont(font:UIFont,maxWidth:CGFloat)->CGFloat{
        let size = CGSize(width: maxWidth, height:  CGFloat(MAXFLOAT))
        let attributes = [kCTFontAttributeName:font]
        let text = self as NSString
        let rect = text.boundingRect(with: size, options:.usesLineFragmentOrigin, attributes: attributes as [NSAttributedStringKey : Any], context:nil)
        return rect.height
    }
    
    func widthWithFont(font:UIFont,maxHeight:CGFloat)->CGFloat{
        let size = CGSize(width: CGFloat(MAXFLOAT), height: maxHeight)
        let attributes = [kCTFontAttributeName:font]
        let text = self as NSString
        let rect = text.boundingRect(with: size, options:.usesLineFragmentOrigin, attributes: attributes as [NSAttributedStringKey : Any], context:nil)
        return rect.width
    }
    func qc_trim()->String{
        return self.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
    }
    func heightWithLabelFont(font:UIFont,width:CGFloat,lineSpace:CGFloat,paragraphSpacing:CGFloat? = nil)->CGFloat {
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
        let text = self as NSString
        let size = CGSize(width: width, height:  CGFloat(MAXFLOAT))
        let rect = text.boundingRect(with: size, options:.usesLineFragmentOrigin, attributes: dic as [NSAttributedStringKey : Any], context:nil)
        return rect.size.height
    }
    /// 去除小数点后多余的0
    ///
    /// - Returns: 处理后的字符串
    func qc_trimRedundantZero()->String{
        var outNumber = self
        var i = 1
        if outNumber.contains("."){
            while i < outNumber.count{
                if outNumber.hasSuffix("0"){
                    outNumber.remove(at: outNumber.index(before: outNumber.endIndex))
                    i = i + 1
                }else{
                    break
                }
            }
            
            if outNumber.hasSuffix("."){
                outNumber.remove(at: outNumber.index(before: outNumber.endIndex))
            }
            return outNumber
        }
        else{
            return outNumber
        }
    }
}
