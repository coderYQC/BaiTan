//
//  ImageExtension.swift
//  LynxIOS
//
//  Created by 叶波 on 2018/6/13.
//  Copyright © 2018年 叶波. All rights reserved.
//
import UIKit

extension UIImage {
    /**
     *  重设图片大小
     */
    func reSizeImage(reSize:CGSize)->UIImage {
        //UIGraphicsBeginImageContext(reSize)
        UIGraphicsBeginImageContextWithOptions(reSize,false,UIScreen.main.scale)
        self.draw(in: CGRect(x:0, y:0, width:reSize.width, height:reSize.height))
        let reSizeImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return reSizeImage
    }
    
    /**
     *  等比率缩放
     */
    func scaleImage(scaleSize:CGFloat)->UIImage {
        let reSize = CGSize(width: self.size.width * scaleSize, height: self.size.height * scaleSize)
        return reSizeImage(reSize: reSize)
    }
    
    //剪切图片(中间裁剪)
    func cropToBounds(width: Double, height: Double) -> UIImage {
        let contextSize: CGSize = self.size
        
        var posX: CGFloat = 0.0
        var posY: CGFloat = 0.0
        var cgwidth: CGFloat = CGFloat(width)
        var cgheight: CGFloat = CGFloat(height)
        
        // See what size is longer and create the center off of that
        if contextSize.width > contextSize.height {
            posX = ((contextSize.width - contextSize.height) / 2)
            posY = 0
            cgwidth = contextSize.height
            cgheight = contextSize.height
        } else {
            posX = 0
            posY = ((contextSize.height - contextSize.width) / 2)
            cgwidth = contextSize.width
            cgheight = contextSize.width
        }
        // Create a new image based on the imageRef and rotate back to the original orientation
        return UIImage(cgImage: (self.cgImage?.cropping(to: CGRect(x:posX, y:posY, width:cgwidth, height:cgheight)))!,
                       scale: self.scale, orientation: self.imageOrientation)
    }
    
     func imageChangeColor(color:UIColor)->UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, 0.0)
        color.setFill()
        let bounds = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        UIRectFill(bounds)
        self.draw(in: bounds, blendMode: .overlay, alpha: 1.0)
        self.draw(in: bounds, blendMode: .destinationIn, alpha: 1.0)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
    
    func grayColor() -> UIImage?{
        guard let imageCG = self.cgImage else {
            return nil
        }
        let width = imageCG.width
        let height = imageCG.height
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        // 申请内存空间
        let pixels = UnsafeMutablePointer<UInt32>.allocate(capacity: width * height )
        //UInt32在计算机中所占的字节
        let uint32Size = MemoryLayout<UInt32>.size
        let context = CGContext.init(data: pixels,
                                     width: width,
                                     height: height,
                                     bitsPerComponent: 8,
                                     bytesPerRow: uint32Size * width,
                                     space: colorSpace,
                                     bitmapInfo: CGBitmapInfo.byteOrder32Little.rawValue | CGImageAlphaInfo.premultipliedLast.rawValue)
        
        context?.draw(imageCG, in: CGRect(x: 0, y: 0, width: width, height: height))
        for y in 0 ..< height {
            for x in 0 ..< width {
                let rgbaPixel = pixels.advanced(by: y * width + x)
                //类型转换 -> UInt8
                let rgb = unsafeBitCast(rgbaPixel, to: UnsafeMutablePointer<UInt8>.self)
                // rgba 所在位置 alpha 0, blue  1, green 2, red 3
                let gray = UInt8(0.3  * Double(rgb[3]) +
                    0.59 * Double(rgb[2]) +
                    0.11 * Double(rgb[1]))
                rgb[3] = gray
                rgb[2] = gray
                rgb[1] = gray
            }
        }
        guard let image = context?.makeImage() else {
            return nil
        }
        pixels.deallocate()
        return UIImage(cgImage: image, scale: 0, orientation: self.imageOrientation)
    }
    
}
