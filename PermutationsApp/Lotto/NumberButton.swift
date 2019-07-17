//
//  NumberButton.swift
//  Lotto
//
//  Created by Exey Panteleev on 22/03/16.
//  Copyright © 2016 Mozgazm. All rights reserved.
//

import UIKit

class NumberButton: UIButton {
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    func updateSelection() {
        selected = !selected
        if selected {
            
            //backgroundColor = StyleManager.COLOR_MAP_SQUARE
            let num = Int(titleLabel!.text!)
            backgroundColor = StyleManager.getHotColorByNumber(num!)
            
        } else {
            backgroundColor = UIColor.clearColor()
        }
    }

}
