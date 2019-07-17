//
//  StyleManager.swift
//  Lotto
//
//  Created by Exey Panteleev on 13/03/16.
//  Copyright © 2016 Mozgazm. All rights reserved.
//

import UIKit

class StyleManager {
    
    static let COLOR_MAP_SQUARE = UIColor(hex:0x74C365)
    
    static let COLOR_MINT_GREEN = UIColor(hex:0x98FB98)
    static let COLOR_LIGHT_GRAY = UIColor(hex:0xD3D3D3)
    static let COLOR_JUNGLE_GREEN = UIColor(hex:0x29AB87)
    static let COLOR_SALMON = UIColor(hex:0xFF91A4)
    
    static let COLOR_COLD = UIColor(hex: 0x87CEEB)
    static let HOT_COLD = UIColor(hex: 0xF1002E)
    
    static let COLOR_LIGHT_GRAY2 = UIColor(hex: 0xCCCCCC)
    
    static let COLORS_PAIRS = [COLOR_SALMON, COLOR_JUNGLE_GREEN, UIColor.purpleColor()]
    
    static let COLOR_PROBABILITIES = [UIColor(hex: 0x2e7b4f)]
    
    static func styleBars() {
        UINavigationBar.appearance().tintColor = UIColor(hex: 0x474a51)
    }
    
    static func getHotColorByNumber(number:Int)->UIColor {
        let d = DataManager.distancies?.currentDistances[number]
        let c = getHotColorByDistance(d!, maxDistance: Conf.HOT_DISTANCE)
        return c
    }
    
    static func getHotColorByDistance(distance:Double, maxDistance:Double)->UIColor {
        let ratio = distance/maxDistance
        let ratio2 = 1-ratio
        let color = ColorUtil.mix(0xF1002E, color1Ratio: ratio, hexColor2: 0x87CEEB, color2Ratio: ratio2)
        let rgb1 = ColorUtil.rgb255toRGB1(color)
        return UIColor(red: CGFloat(rgb1.r), green: CGFloat(rgb1.g), blue: CGFloat(rgb1.b), alpha: 1)
    }
    
    static func getColorByValue(val:Double, minVal:Double, maxVal:Double, colorMin:Int, colorMax:Int)->UIColor {
        let v1 = val-minVal
        let v2 = maxVal-minVal
        let ratio = v1/v2
        let ratio2 = 1-ratio
        let color = ColorUtil.mix(colorMax, color1Ratio: ratio, hexColor2: colorMin, color2Ratio: ratio2)
        let rgb1 = ColorUtil.rgb255toRGB1(color)
        return UIColor(red: CGFloat(rgb1.r), green: CGFloat(rgb1.g), blue: CGFloat(rgb1.b), alpha: 1)
    }
}