//
//  DistanceNumberCol.swift
//  Lotto
//
//  Created by Exey Panteleev on 10/04/16.
//  Copyright © 2016 Mozgazm. All rights reserved.
//

import UIKit

class DistanceNumberCol: UIView {
    
    var topLabel:UILabel?
    var bottomLabel:UILabel?
    
    /** CONSTRUCTOR */
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func create(topValue:Int, bottomValue:Double) {
        topLabel = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height*0.6))
        //topLabel?.backgroundColor = UIColor(hex: 0xCCCCCC)
        topLabel?.text = "\(topValue)"
        topLabel?.textAlignment = NSTextAlignment.Center
        addSubview(topLabel!)
        
        bottomLabel = UILabel(frame: CGRect(x: 0, y: frame.height*0.6, width: frame.width, height: frame.height*0.4))
        bottomLabel?.backgroundColor = StyleManager.getHotColorByDistance(bottomValue, maxDistance: Conf.HOT_DISTANCE)
        bottomLabel?.text = bottomValue.format("%.0f")
        bottomLabel?.textAlignment = NSTextAlignment.Center
        bottomLabel?.font = UIFont.systemFontOfSize(12)
        bottomLabel?.textColor = UIColor.whiteColor()
        addSubview(bottomLabel!)
    }

}
