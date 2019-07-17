//
//  DataManager.swift
//  Lotto
//
//  Created by Exey Panteleev on 25/02/16.
//  Copyright © 2016 Mozgazm. All rights reserved.
//

import Foundation
import CoreGraphics

class DataManager {
    
    // Main
    static var draws:[CombinationData]?
    // Sections
    static var bets:[[Int]]?
    
    static var allFrequencies:ValueFrequencyStatsData?
    static var allPRNGFrequencies:ValueFrequencyStatsData?
    static var distancies:DistanciesData?
    // amalgama
    static var pairs:PairsData = PairsData()
    static var trios:TriosData = TriosData()
    
    // service locator
    static let probabilityService = ProbabilityService()
    static var probabilities:ProbabilityData?
    
    static var minSum:Int {
        var sum = 0
        for i in 1...Conf.CHOOSE_COUNT { sum += i }
        return sum
    }
        
    static var maxSum:Int {
        var sum = 0
        for i in 0...Conf.CHOOSE_COUNT-1 { sum += Conf.MAX_NUMBER - i }
        return sum
    }
    
    // MARK: - API
    
    static func doInitialCalculations() {
        distancies = DistanciesData()
        getDraws {
            allFrequencies = calcValueFrequencyStats(0, endDraw: DataManager.draws!.count) // all
            allPRNGFrequencies = calcValueFrequencyStats(Conf.PRNG_START_DRAW, endDraw: DataManager.draws!.count)
            distancies!.calcDistancies()
            distancies!.calcDistancesSums()
            distancies?.calcAverageDistances()
            
            // new test
            DataManager.calculatePairs()
            DataManager.calculateTrios()
        }
    }
    
    // MARK: - Draws
    
    static func getDraws(onComplete:()->()) {
        // Networking
        NetworkManager.loadStats { drawsArray in
            var drawsCount = drawsArray.count
            // fix last empty line
            if drawsArray[drawsCount-1].characters.count == 0 {
                drawsCount -= 1
            }
            
            DataManager.draws = []
            print("COUNT \(drawsCount)")
            for i in 0 ..< drawsCount {
                let val = drawsArray[i]
                //print("\(val) --- \(val.characters.count)")
                if val.characters.count > 0 {
                    let cd = CombinationData(valuesString: val, drawNumber: drawsCount-i)
                    DataManager.draws?.append(cd)
                }
            }
            print("COUNT \(DataManager.draws?.count)")
            onComplete()
        }
    }
    
    
    // MARK: - Calculations
    
    static func calcValueFrequencyStats(startDraw:Int, endDraw:Int)->ValueFrequencyStatsData? {
        // exception
        if (startDraw > endDraw) { return nil }
        
        var result = ValueFrequencyStatsData(values: [Int](count: Conf.MAX_LOTTO_VALUE, repeatedValue: 0))
        
        doOnRange(startDraw, endDraw: endDraw) { cd in
            let vals = cd.values
            for v in vals {
                result.values[v] += 1
            }
        }
        
        //print("== \(result)")
        return result
    }
    
    /*static func calcValueFrequencyStats(startDraw:Int, endDraw:Int)->ValueFrequencyStatsData? {
        // exception
        if (startDraw > endDraw) { return nil }
        
        
        // order is inverted
        //print("\(DataManager.draws)")
        let drawsCount = DataManager.draws!.count
        let start =  drawsCount - endDraw
        let end = drawsCount - startDraw - 1
    
        var result = ValueFrequencyStatsData(values: [Int](count: Conf.MAX_LOTTO_VALUE, repeatedValue: 0))
        
        print("start \(start) end \(end)")
        
        // go trough range of draws
        for i in start ..< end {
            // cacluclate concrete draw
            let cd = draws![i] // Combination
            let vals = cd.values
            for v in vals {
                result.values[v] += 1
            }
        }
        
        print("== \(result)")
        return result
    }*/
    
    static func calcSumsStats(draws: [CombinationData])->SumsStatsData {
        let ssd = SumsStatsData(draws: draws)
        return ssd
    }
    
    // MARK: - Probability
    
    static func calculateProbability(bets:[[Int]]) {
        // Recalculate only if needed
        if bets.count == probabilities!.betsProcessed {
            return
        }
        
        probabilityService.calculateProbabilities(&probabilities!, bets: bets)
        
        print("------------------")
        print("# 2 # \(probabilities!.combs2.count) # \(probabilities!.combs2)")
        print("---")
        print("# 3 # \(probabilities!.combs3.count) # \(probabilities!.combs3)")
        print("---")
        print("# 4 # \(probabilities!.combs4.count) # \(probabilities!.combs4)")

    }
    
    // MARK: - Amalgamas - Pairs, Trios
    
    static func calculatePairs() {
        print("== PAIRS")
        doOnRange(Conf.PRNG_START_DRAW, endDraw: DataManager.draws!.count) { cd in
            let combos = cd.values.combos(2)
            //print("\(cd.drawNumber) - \(combos)")
            pairs.addValues(combos)
        }
        pairs.countPairs()
        
    }
    
    static func calculateTrios() {
        print("== TRIOS")
        doOnRange(Conf.PRNG_START_DRAW, endDraw: DataManager.draws!.count) { cd in
            let combos = cd.values.combos(3)
            //print("\(cd.drawNumber) - \(combos)")
            trios.addValues(combos)
        }
        trios.countTrios()
    }
    
    
     // MARK: - Helpers
    
    static func getLastDraws(count:Int)->[CombinationData] {
        var lastDraws = [CombinationData]()
        for i in 0...count-1 {
            lastDraws.append(DataManager.draws![i])
        }
        return lastDraws
    }
    
    static func doOnRange(startDraw:Int, endDraw:Int, factoryMethod:(cd:CombinationData)->()) {
        // order is inverted
        //print("\(DataManager.draws)")
        let drawsCount = DataManager.draws!.count
        let start =  drawsCount - endDraw
        let end = drawsCount - startDraw - 1
        
        print("doOnRange() - start \(start) end \(end)")
        
        // go trough range of draws
        for i in start ..< end {
            // cacluclate concrete draw
            let cd = draws![i] // Combination
            factoryMethod(cd: cd)
        }
    }
    
    static func doOnRangeInverted(startDraw:Int, endDraw:Int, factoryMethod:(cd:CombinationData)->()) {
        // order is inverted
        //print("\(DataManager.draws)")
        let drawsCount = DataManager.draws!.count
        let start =  drawsCount - endDraw
        let end = drawsCount - startDraw
        
        let length = end - start
        
        print("doOnRangeInverted() = lenght \(length) = start \(start) end \(end)")
        
        // go trough range of draws
        for i in 0 ..< length {
            // cacluclate concrete draw
            let cd = draws![end - i - 1] // Combination
            factoryMethod(cd: cd)
        }
    }
    
}