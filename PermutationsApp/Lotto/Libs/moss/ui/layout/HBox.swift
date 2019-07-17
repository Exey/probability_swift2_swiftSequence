//
//  HBox.swift
//  Created by Exey Panteleev
//

import UIKit

protocol Clonable:UIAppearanceContainer {
    func clone()->Clonable
}

class HBox:LayoutBase {
    
    // private, for arrange
    private var sizeX:CGFloat?
    private var cols:Int?
    private var gapX:CGFloat?
    private var startX:CGFloat?

    func arrange(sizeX:CGFloat, cols:Int, gapX:CGFloat = 0, startX:CGFloat = 0) {
        self.sizeX = sizeX
        self.cols = cols
        self.gapX = gapX
        self.startX = startX
        for i:Int in 0 ..< elements!.count {
            let v:UIView = elements![i]
            let gap = CGFloat(i % cols) * (sizeX + gapX)
            v.frame.origin.x = startX + gap
            frame.size.width = v.frame.origin.x + v.frame.width
        }
    }
    
    func clone()->HBox {
        let row:HBox = HBox(frame: self.frame)
        for el in elements! {
            row.add((el as! Clonable).clone())
        }
        row.arrange(self.sizeX!, cols: self.cols!, gapX: self.gapX!, startX: self.startX!)
        return row
    }
    
}