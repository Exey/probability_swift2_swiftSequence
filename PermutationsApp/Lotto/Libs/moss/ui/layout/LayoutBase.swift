//
//  LayoutBase.swift
//  Lotto
//
//  Created by Exey Panteleev on 22/03/16.
//  Copyright © 2016 Mozgazm. All rights reserved.
//

import UIKit

class LayoutBase: UIView {

    var elements:[UIView]?
    
    /**
     * Constructor
     */
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    override init(frame: CGRect) {
        super.init(frame: frame)
        elements = [UIView]()
    }
    
    func add(element:UIAppearanceContainer){
        elements!.append(element as! UIView)
        addSubview(element as! UIView)
    }

}
