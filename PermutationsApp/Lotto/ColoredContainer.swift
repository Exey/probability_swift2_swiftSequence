//
//  ColoredContainer.swift
//  Lotto
//
//  Created by Exey Panteleev on 12/04/16.
//  Copyright © 2016 Mozgazm. All rights reserved.
//

import UIKit

class ColoredContainer: UIView {

    // UI
    var label:IconedLabelView? = nil
    
    private var _borderSelected = false
    var borderSelected:Bool {
        get {
            return _borderSelected
        }
        set {
            if newValue {
                layer.borderColor = UIColor.yellowColor().CGColor
                layer.borderWidth = 3
            } else {
                layer.borderWidth = 0
            }
            _borderSelected = newValue
        }
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func addUI(labelFrame:CGRect, iconImage:UIImage?, color:UIColor, gap:CGFloat) {
        label = IconedLabelView(frame: labelFrame)
        label?.addUI(iconImage, text: "0", textColor: color, gap: gap)
        //label!.icon?.frame = CGRect(x: 0, y: 0, width: labelFrame.size.width, height: labelFrame.size.height)
        
        label?.applyTintToIcon(color)
        addSubview(label!)
    }
    
    func updateColor(good:Bool) {
        backgroundColor = good ? StyleManager.COLOR_MAP_SQUARE : UIColor.redColor()
    }
    
    func updateLabel(text:String) {
        label?.label?.text = text
    }

}
