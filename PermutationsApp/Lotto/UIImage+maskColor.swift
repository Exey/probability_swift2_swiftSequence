//
//  UIImage+maskColor.swift
//  Lotto
//
//  Created by Exey Panteleev on 23/04/16.
//  Copyright © 2016 Mozgazm. All rights reserved.
//

import UIKit

/// UIImage Extensions
extension UIImage {
    
    func maskWithColor(color: UIColor) -> UIImage {
        
        let maskImage = self.CGImage
        let width = self.size.width
        let height = self.size.height
        let bounds = CGRectMake(0, 0, width, height)
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.PremultipliedLast.rawValue)
        let bitmapContext = CGBitmapContextCreate(nil, Int(width), Int(height), 8, 0, colorSpace, bitmapInfo.rawValue)
        
        CGContextClipToMask(bitmapContext, bounds, maskImage)
        CGContextSetFillColorWithColor(bitmapContext, color.CGColor)
        CGContextFillRect(bitmapContext, bounds)
        
        let cImage = CGBitmapContextCreateImage(bitmapContext)
        let coloredImage = UIImage(CGImage: cImage!)
        
        return coloredImage
    }
}