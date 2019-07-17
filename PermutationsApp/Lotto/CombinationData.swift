//
//  CombinationData.swift
//  Lotto
//
//  Created by Exey Panteleev on 25/02/16.
//  Copyright © 2016 Mozgazm. All rights reserved.
//

import Foundation

typealias NumCounts = (Int, Int, Int, Int, Int, Int)

struct CombinationData:CustomStringConvertible {
    
    var drawNumber:Int
    var values:[Int]
    
    var distanciesPerValue:[Double] // parallel to values
    
    var sum:Int {
        return values.reduce(0, combine: {$0+$1})
    }
    
    var averageDistance:Double {
        let sum = distanciesPerValue.reduce(0, combine: {$0+$1})
        return sum / Double(values.count)
    }
    
    var coldAndHot:(Int, Int) {
        var result = (0, 0)
        for d in distanciesPerValue {
            if AnalysisManager.isHotNumber(d) {
                result.1 += 1
            } else {
                result.0 += 1
            }
        }
        return result
    }
    
    var oddAndEven:(Int, Int) {
        var result = (0, 0)
        for v in values {
            if v%2 == 0 {
                result.1 += 1
            } else {
                result.0 += 1
            }
        }
        return result
    }
    
    /** from zero */
    var matrixRow:[Int] {
        var zeros = [Int](count: Conf.MAX_LOTTO_VALUE, repeatedValue: 0)
        for v in values {
            zeros[v] = v
        }
        return zeros
    }
    
    var pairs:[[Int]] {
        if values.count >= 2 {
            return values.combos(2)
        }
        return []
    }
    
    var pairsClustered:(c0:[PairCounted], c1:[PairCounted], c2:[PairCounted]) {
        let prsC = pairs.map{DataManager.pairs.getPairCounted($0)}
        let prsC0 = prsC.filter{AnalysisManager.pairPriority($0.count) == 0}
        let prsC1 = prsC.filter{AnalysisManager.pairPriority($0.count) == 1}
        let prsC2 = prsC.filter{AnalysisManager.pairPriority($0.count) == 2}
        return (c0:prsC0, c1:prsC1, c2:prsC2)
    }
    
    /** CONSTRUCTOR */
    init(valuesString:String, drawNumber:Int) {
        values = valuesString.componentsSeparatedByString(" ").map{Int($0)!}
        distanciesPerValue = [Double](count:values.count, repeatedValue: 0)
        self.drawNumber = drawNumber
    }
    
    /** CONSTRUCTOR */
    init(values:[Int]) {
        self.values = values
        distanciesPerValue = [Double](count:values.count, repeatedValue: 0)
        drawNumber = 0
    }
    
    func compareAndIncrement(inout numCounts:NumCounts, bet:[Int]) {
        var mathces:Int = 0
        // refactor to intersects
        for b in bet {
            for v in values {
                if v == b {
                    mathces += 1
                    continue
                }
            }
        }
        if mathces == 0 {
            numCounts.0 += 1
        } else {
            if  mathces == 1 { numCounts.1 += 1 }
            else if  mathces == 2 { numCounts.2 += 1 }
            else if  mathces == 3 { numCounts.3 += 1 }
            else if  mathces == 4 { numCounts.4 += 1 }
            else if  mathces == 5 { numCounts.5 += 1 }
        }
    }
    
    // MARK: - Mutating
    
    mutating func resetDistances() {
        distanciesPerValue = [Double](count:values.count, repeatedValue: 0)
    }
    
    mutating func setDistanceForValue(value:Int, distance:Double) {
        let index = values.indexOf(value)
        distanciesPerValue[index!] = distance
    }
    
    // MARK: - CustomStringConvertible
    
    var description: String {
        let vals = values.map{$0 < 10 ? "0\($0)" : "\($0)"}.joinWithSeparator(" ")
        return "\(drawNumber) - \(vals) | = \(sum)"
    }
    
}