//
//  Double+round.swift
//  Lotto
//
//  Created by Exey Panteleev on 01/04/16.
//  Copyright © 2016 Mozgazm. All rights reserved.
//

import Foundation

public extension Double {
    
    func roundToDecimals(decimals: Int = 2) -> Double {
        let multiplier = Double(10^decimals)
        return round(multiplier * self) / multiplier
    }

    func format(value:String = "%.1f") -> String {
        return String(format:value, self)
    }
    
}