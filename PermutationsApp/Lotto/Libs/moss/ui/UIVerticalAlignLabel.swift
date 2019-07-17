//
//  UIVerticalAlignLabel.swift
//  Lotto
//
//  Created by Exey Panteleev on 27/02/16.
//  Copyright © 2016 Mozgazm. All rights reserved.
//

import UIKit

enum VerticalAlignment : Int {
    case VerticalAlignmentTop = 0
    case VerticalAlignmentMiddle = 1
    case VerticalAlignmentBottom = 2
}

class UIVerticalAlignLabel: UILabel {
    
    var verticalAlignment : VerticalAlignment = .VerticalAlignmentTop {
        didSet {
        setNeedsDisplay()
        }
    }
    
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func textRectForBounds(bounds: CGRect, limitedToNumberOfLines: Int) -> CGRect {
        let rect = super.textRectForBounds(bounds, limitedToNumberOfLines: limitedToNumberOfLines)
        
        switch(verticalAlignment) {
        case .VerticalAlignmentTop:
            return CGRectMake(bounds.origin.x, bounds.origin.y, rect.size.width, rect.size.height)
        case .VerticalAlignmentMiddle:
            return CGRectMake(bounds.origin.x, bounds.origin.y + (bounds.size.height - rect.size.height) / 2, rect.size.width, rect.size.height)
        case .VerticalAlignmentBottom:
            return CGRectMake(bounds.origin.x, bounds.origin.y + (bounds.size.height - rect.size.height), rect.size.width, rect.size.height)
        }
    }
    
    override func drawTextInRect(rect: CGRect) {
        let r = self.textRectForBounds(rect, limitedToNumberOfLines: self.numberOfLines)
        super.drawTextInRect(r)
    }

}
