//
//  Int+Precision.swift
//  Lotto
//
//  Created by Exey Panteleev on 25/02/16.
//  Copyright © 2016 Mozgazm. All rights reserved.
//

import Foundation

extension Int {
    
    func formatZeros(length:Int ) -> String {
        var numString = String(self)
        while numString.characters.count < length  {
            numString = "0" + numString
        }
        return numString
    }
    
    func formatPrecision(value:String = "%02d")->String {
        return String(format: value, self)
    }
}