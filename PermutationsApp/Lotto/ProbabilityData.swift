//
//  ProbabilityData.swift
//  Loto5x36
//
//  Created by Exey Panteleev on 30/03/16.
//  Copyright © 2016 Mozgazm. All rights reserved.
//

import CoreGraphics

struct ProbabilityData {
    
    var betsProcessed:Int = 0
    
    var combs2:Set<Comb>
    var combs3:Set<Comb>
    var combs4:Set<Comb>
    
    var probabilty2:Double = 0
    var probabilty3:Double = 0
    var probabilty4:Double = 0
    var probabilty5:Double = 0
    
    init() {
        combs2 = Set<Comb>()
        combs3 = Set<Comb>()
        combs4 = Set<Comb>()
    }
    
    mutating func reset() {
        betsProcessed = 0
        combs2 = Set<Comb>()
        combs3 = Set<Comb>()
        combs4 = Set<Comb>()
    }
    
}