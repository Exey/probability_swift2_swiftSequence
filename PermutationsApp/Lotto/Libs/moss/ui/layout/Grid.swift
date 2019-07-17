//
//  Grid.swift
//  Lotto
//
//  Created by Exey Panteleev on 22/03/16.
//  Copyright © 2016 Mozgazm. All rights reserved.
//

import UIKit

class Grid: LayoutBase {

    // private, for arrange
    private var tileSizeX:CGFloat?
    private var tileSizeY:CGFloat?
    private var cols:Int?
    private var gapX:CGFloat?
    private var gapY:CGFloat?
    private var startX:CGFloat?
    private var startY:CGFloat?
    
    func arrange(tileSizeX:CGFloat, tileSizeY:CGFloat, cols:Int, gapX:CGFloat, gapY:CGFloat = 0, startX:CGFloat = 0, startY:CGFloat = 0) {
        self.tileSizeX = tileSizeX
        self.tileSizeY = tileSizeY
        self.cols = cols
        self.gapX = gapX
        self.gapY = gapY
        self.startX = startX
        self.startY = startY
        
        for i:Int in 0 ..< elements!.count {
            let v:UIView = elements![i]
            v.frame.origin.x = startX + CGFloat((i % cols)) * (tileSizeX + gapX);
            v.frame.origin.y = startY + CGFloat(i/cols) * (tileSizeY + gapY);
            // update frame
            frame.size.width = v.frame.origin.x + v.frame.width
            frame.size.width = v.frame.origin.y + v.frame.height
        }
    }

}
