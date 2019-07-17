//
//  MapRowCol.swift
//  Lotto
//
//  Created by Exey Panteleev on 13/03/16.
//  Copyright © 2016 Mozgazm. All rights reserved.
//

import UIKit

class MapRowCol: UIView {
    
    // UI
    var label:UILabel?
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func setColor(color:UIColor) {
        self.backgroundColor = color
    }
    
    func setLabel(text:String, color:UIColor = UIColor.blackColor()) {
        label = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        label?.adjustsFontSizeToFitWidth = true
        label?.text = text
        label?.textColor = color
        label?.textAlignment = NSTextAlignment.Center
        addSubview(label!)
    }
    
    /*func initWithColor(frame: CGRect, color:UIColor) {
        //init(frame: frame)
        backgroundColor = color
    }
    
    func initWitLabel(frame: CGRect, text:String) {
        //init(frame: frame)
        let label = UILabel(frame: CGRect(x: 0, y: frame.height/2, width: frame.width, height: 20))
        label.text = text
        addSubview(label)
    }*/

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
