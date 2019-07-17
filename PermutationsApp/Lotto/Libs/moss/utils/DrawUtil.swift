//
//  DrawUtil.swift
//  Created by Exey Panteleev on 01/02/15.
//

import UIKit

public struct DrawUtil {

    /** Use inside drawRect() */
    static func lineWithUIKit(color:UIColor, var rect:CGRect, pixelLineHack:Bool = false) {
        if(pixelLineHack) {
            let pixel = 1 / UIScreen.mainScreen().scale
            if(rect.origin.y != 0) {
                rect.origin.y += (1-pixel)
            }
            rect.size.height = pixel
        }
        color.setFill()
        UIRectFill(rect)
    }
    
    static func shapeLineWithUIKit(color:UIColor, var start:CGPoint, var end:CGPoint, var lineWidth:CGFloat = 1, pixelLineHack:Bool = false)->CAShapeLayer {
        if(pixelLineHack) {
            let pixel = 1 / UIScreen.mainScreen().scale
            lineWidth = pixel
            start.y += (1-pixel)
            end.y += (1-pixel)
        }
        let path = UIBezierPath()
        path.moveToPoint(start)
        path.addLineToPoint(end)
        let layer = CAShapeLayer()
        layer.path = path.CGPath
        layer.strokeColor = color.CGColor
        layer.lineWidth = lineWidth
        layer.backgroundColor = UIColor.clearColor().CGColor
        return layer
    }

}