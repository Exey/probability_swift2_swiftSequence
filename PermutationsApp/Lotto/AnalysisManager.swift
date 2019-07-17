//
//  AnalysisManager.swift
//  Lotto
//
//  Created by Exey Panteleev on 12/04/16.
//  Copyright © 2016 Mozgazm. All rights reserved.
//

import Foundation

class AnalysisManager {

    static func isOddNumberGood(value:Int)->Bool {
        return value >= 2 && value < 5
    }
    
    static func isEvenNumberGood(value:Int)->Bool {
        return value >= 2 && value < 5
    }
    
    static func isSumGood(value:Int)->Bool {
        return value > 60 && value < 120
    }

    static func isAverageDistanceGood(value:Double)->Bool {
        return value >= 2.2 && value <= 8.5
    }
    
    static func isHotNumber(value:Double)->Bool {
        return value > 8
    }
    
    static func isColdNumberGood(value:Int)->Bool {
        return value >= 3
    }
    
    static func isHotNumberGood(value:Int)->Bool {
        return value <= 2
    }
    
    /*static func isBetweenDrawsChainGood(value:Double)->Bool {
        return value <= 0.985 && value >= 0.879
    }*/
    
    static func pairPriority(count:Int)->Int {
        if count > 64 {
            return 0
        } else if count > 49 {
            return 1
        } else {
            return 2
        }
    }
    
    static func isClusterHighGood(value:Int) -> Bool {
        return value <= 4
    }

    static func isClusterMidGood(value:Int) -> Bool {
        return value >= 5
    }
    
    static func isClusterLowGood(value:Int) -> Bool {
        return value <= 4
    }
}