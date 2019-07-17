//
//  Conf.swift
//  Lotto
//
//  Created by Exey Panteleev on 18/03/16.
//  Copyright © 2016 Mozgazm. All rights reserved.
//

import UIKit

class Conf {
    
    // 5x36
    static let MAX_NUMBER = 36
    static let CHOOSE_COUNT = 5
    static let MAX_LOTTO_VALUE = 37 //  50 -6x45, 6x49, ignore zero
    
    static let DEFAULT_RECENT_STAS_DRAWS = 150 // one month 5*30
    static let SUMS_WIDTH:CGFloat = 2500
    
    static let PRNG_START_DRAW = 1460 // PseudoRandom Number Generator
    
    // Bets
    static let BET_BOX_BUTTON_SIZE:CGFloat = 28.2
    static let BET_BOX_MAX_SELECTED:Int = 5
    
    // Distance
    static let HOT_DISTANCE:Double = 50
    
    // Probability consts
    /*static var COMBS_COUNT_2_IN_36:Int {
        let allCombs = MathCombinatoricsUtil.combinations(36, 2)
        print("COMBS_COUNT_2_IN_36 \(allCombs)")
        return allCombs.toInt()
    }
    static var COMBS_COUNT_3_IN_36:Int {
        let allCombs = MathCombinatoricsUtil.combinations(36, 3)
        print("COMBS_COUNT_3_IN_36 \(allCombs)")
        return allCombs.toInt()
    }
    static var COMBS_COUNT_4_IN_36:Int {
        let allCombs = MathCombinatoricsUtil.combinations(36, 4)
        print("COMBS_COUNT_4_IN_36 \(allCombs)")
        return allCombs.toInt()
    }*/
    static var COMBS_COUNT_5_IN_36:Int {
        // MathCombinatoricsUtil.combinations(36, 5)
        return 376992
    }
    
    
    // UI Consts
    static let BET_GRID_SIZE = Conf.BET_BOX_BUTTON_SIZE*6
    
}