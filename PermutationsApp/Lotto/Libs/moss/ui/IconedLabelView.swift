//
//  IconedLabelView.swift
//  Lotto
//
//  Created by Exey Panteleev on 02/04/16.
//  Copyright © 2016 Mozgazm. All rights reserved.
//

import UIKit

class IconedLabelView: UIView {

    // UI
    var icon:UIImageView?
    var label:UILabel?
    
    // Data
    var gap:CGFloat = 0
    
    /** CONSTRUCTOR */
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func addUI(iconImage:UIImage?, text:String, textColor:UIColor?, gap:CGFloat) {
        self.gap = gap
        if let icn = iconImage {
            icon = UIImageView(frame:CGRect(x: 0, y: 0, width: frame.height, height: frame.height))
            icon?.contentMode = UIViewContentMode.ScaleAspectFit
            icon?.image = icn
            addSubview(self.icon!)
        }
        label = UILabel(frame: CGRect(x: 0,y: 0, width: 50, height:frame.height))
        label?.text = text
        label?.textColor = textColor
        addSubview(label!)
        autoSize()
    }
    
    func applyTintToIcon(color:UIColor) {
        icon?.tintColor = color
        icon?.image = icon!.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
    }
    
    func autoSize() {
        //print("____ \(label!.frame) == \(icon!.frame)")
        //icon?.sizeToFit()
        //label!.sizeToFit()
        if let icn = icon {
            label!.frame.origin.x = icon!.frame.width + gap
            frame.size.width = icon!.frame.width + 5 + label!.frame.width
        } else {
            label?.frame.origin.x = (frame.width - label!.frame.width)/2
        }
        //print("---- \(label!.frame)")
    }
    
    func update(text:String, icon:UIImage! = nil) {
        label?.text = text
        if icon != nil {
            self.icon?.image = icon
        }
        autoSize()
    }
    
}