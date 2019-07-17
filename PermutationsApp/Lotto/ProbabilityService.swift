//
//  ProbabilityService.swift
//  Loto5x36
//
//  Created by Exey Panteleev on 30/03/16.
//  Copyright © 2016 Mozgazm. All rights reserved.
//

import Foundation

class ProbabilityService {
    
    
    func calculateProbabilities(inout probabilities:ProbabilityData, bets:[[Int]]) {
        
        probabilities.reset()
        
        // Calculate combinations
        for b in bets {
            // 2
            let combs2 = b.combos(2)
            for c2 in combs2 {
                probabilities.combs2.insert(Comb(values: c2))
            }
            // 3
            let combs3 = b.combos(3)
            for c3 in combs3 {
                probabilities.combs3.insert(Comb(values: c3))
            }
            // 4
            let combs4 = b.combos(4)
            for c4 in combs4 {
                probabilities.combs4.insert(Comb(values: c4))
            }
        }

        // update current state
        probabilities.betsProcessed = bets.count
        
        // Calculate Probabilities
        probabilities.probabilty2 = calculateProbabiltyByCombs(2, combs: probabilities.combs2.count)
        probabilities.probabilty3 = calculateProbabiltyByCombs(3, combs: probabilities.combs3.count)
        probabilities.probabilty4 = calculateProbabiltyByCombs(4, combs: probabilities.combs4.count)
        probabilities.probabilty5 = Double(bets.count)/Double(Conf.COMBS_COUNT_5_IN_36) // TODO fix to unique bets
    }
    
    // MARK: - Formulas
    
    func calculateProbabiltyByCombs(nums:Int, combs:Int)->Double {
        let rest:BInt = BInt(Conf.CHOOSE_COUNT - nums)
        let restNums:BInt = BInt(Conf.MAX_NUMBER - Conf.CHOOSE_COUNT)
        let lostCombs = AlgoCombinatorics.combinations(restNums, rest).toInt()
        return Double(lostCombs * combs) / Double(Conf.COMBS_COUNT_5_IN_36)
    }
    
}