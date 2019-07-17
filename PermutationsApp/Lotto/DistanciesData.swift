//
//  DistanceData.swift
//  Lotto
//
//  Created by Exey Panteleev on 19/04/16.
//  Copyright © 2016 Mozgazm. All rights reserved.
//

import Foundation

struct DistanciesData {
    
    var distancesIndeciesHelper = [Int](count: Conf.MAX_LOTTO_VALUE, repeatedValue: -1) // ignore zero
    var currentDistances = [Double](count: Conf.MAX_LOTTO_VALUE, repeatedValue: -1) // ignore zero or use as average
    var longestDistance:Double = 0
    var distanceSums:[Int] = [Int](count: Conf.MAX_LOTTO_VALUE, repeatedValue: -1) // ignore zero
    var averageDistPerValue = [Double](count: Conf.MAX_LOTTO_VALUE, repeatedValue: -1)
    
    mutating func calcDistancies() {
        
        var longestDist = 0
        
        // last draw
        let lastDrawNum = DataManager.draws![0].drawNumber
        let nextDrawNum = lastDrawNum + 1 // For current values
        
        // draws
        for i in 0..<DataManager.draws!.count {
            let d = DataManager.draws![i]
            let vals  = d.values
            // iterate values
            for ii in 0..<vals.count {
                let v = vals[ii]
                // get previous to calculate 1D distance
                let prev = distancesIndeciesHelper[v]
                if prev >= 0 {
                    let di = lastDrawNum-prev
                    if di >= 0 {
                        let delta = DataManager.draws![di].drawNumber - d.drawNumber
                        longestDist = max(longestDist, delta)
                        DataManager.draws![di].setDistanceForValue(v, distance: Double(delta-1))
                    }
                }
                // store in helper
                distancesIndeciesHelper[v] = d.drawNumber
                
                // current ditances
                let current = currentDistances[v]
                if current == -1 {
                    let delta2 = Double(nextDrawNum - d.drawNumber)
                    currentDistances[v] = delta2 - 1
                }
                
            }
            
            longestDistance = Double(longestDist-1)
        }
        
        print("==== LONGEST DISTANCE \(longestDistance)")
        //print("==== CURRENT \(currentDistances)")
    }
    
    mutating func resetDistancies() {
        distancesIndeciesHelper = [Int](count: Conf.MAX_LOTTO_VALUE, repeatedValue: 0)
    }
    
    mutating func calcDistancesSums() {
        for cd in DataManager.draws! {
            for i in 0..<cd.values.count {
                let v = cd.values[i]
                let d = cd.distanciesPerValue[i]
                distanceSums[v] += Int(d)
            }
        }
    }
    
    mutating func calcAverageDistances() {
        let all = DataManager.allFrequencies!
        for ii in 1..<all.values.count {
            let d = distanceSums[ii]
            let v = all.values[ii]
            let adpv = Double(d)/Double(v)
            //print("\(ii) == \(d) == \(v) == \(adpv)")
            averageDistPerValue[ii] = adpv
        }
    }
    
    
}