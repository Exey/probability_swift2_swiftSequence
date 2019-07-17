//
//  ColorUtil.swift
//  Lotto
//
//  Created by Exey Panteleev on 16/04/16.
//  Copyright © 2016 Mozgazm. All rights reserved.
//

import Foundation

typealias RGB255 = (r: Int, g: Int, b: Int)            //  0 - 255
typealias RGB1 = (r: Double, g: Double, b: Double)  // 0.0 - 1.0

struct ColorUtil {
    
    static func mix(hexColor1:Int, color1Ratio:Double, hexColor2:Int, color2Ratio:Double)->RGB255 {
        let rgb1 = hexToRGB(hexColor1)
        let rgb2 = hexToRGB(hexColor2)
        return (r: Int( (Double(rgb1.r)*color1Ratio)+(Double(rgb2.r)*color2Ratio) ),
                g: Int( (Double(rgb1.g)*color1Ratio)+(Double(rgb2.g)*color2Ratio) ),
                b: Int( (Double(rgb1.b)*color1Ratio)+(Double(rgb2.b)*color2Ratio) )
                )
    }

    
    static func rgbToHex(rgb:RGB255)->Int {
        return rgb.r << 16 | rgb.g << 8 | rgb.b
    }
    
    static func hexToRGB(hex:Int)->RGB255 {
        return (r: (hex & 0xff0000) >> 16,
                g: (hex & 0x00ff00) >> 8,
                b: hex & 0x0000ff
                )
    }
    
    static func rgb255toRGB1 (rgb:RGB255)->RGB1 {
        return (r:Double(rgb.r)/255,
                g:Double(rgb.g)/255,
                b:Double(rgb.b)/255)
    }
    
}