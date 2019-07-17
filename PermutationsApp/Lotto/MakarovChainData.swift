//
//  MakarovChainData.swift
//  Lotto
//
//  Created by Exey Panteleev on 25/04/16.
//  Copyright © 2016 Mozgazm. All rights reserved.
//

import Foundation

struct MakarovChainData {
    
    // 1 line
    var values:[Int]
    var values2:[CombinationData]
    
    
    var transitionTable:[[Int]]?
    
    init(startDraw:Int, endDraw:Int) {
        
        // flat
        values = []
        values2 = []
        DataManager.doOnRangeInverted(startDraw, endDraw: endDraw) { cd in
            //print("MC = \(cd.drawNumber) =  \(cd.values)")
            for v in cd.values {
                self.values.append(v)
            }
            self.values2.append(cd)
        }
        
        //print("CHAIN VALUES = \(values.count) = \(values)")
    }
    
    mutating func buildTransitionTable() {
        transitionTable = [[Int]]()
        for i in 0..<Conf.MAX_LOTTO_VALUE {
            transitionTable!.append([Int](count: Conf.MAX_LOTTO_VALUE, repeatedValue: 0))
        }
        
        // dumb method
        /*
        for ii in 0..<values.count {
            if ii == values.count-1 {
                // last value
                
            } else {
                let v  = values[ii]
                let nv = values[ii+1]
                transitionTable![v][nv] += 1
            }
        }
       */
        
        // combine method
        for ii in 0..<values2.count {
            if ii == values2.count-1 {
                // last value
                
            } else {
                let ccd  = values2[ii]
                let ncd  = values2[ii+1]
                for v in ccd.values {
                    for vv in ncd.values {
                        transitionTable![v][vv] += 1
                    }
                }
            }
        }
        
        // neighbour method
        /*for ii in 0..<values2.count {
            if ii == values2.count-1 {
                // last value
            } else {
                let ccd  = values2[ii]
                for v in ccd.values {
                    for vv in ccd.values {
                        if v == vv {
                            
                        } else {
                            transitionTable![v][vv] += 1
                        }
                    }
                }
            }
        }*/
        
        // ordered method
        /*for ii in 0..<values2.count {
            if ii == values2.count-1 {
                // last value
                
            } else {
                let ccd  = values2[ii]
                let ncd  = values2[ii+1]
                for v in 0..<ccd.values.count {
                    transitionTable![ccd.values[v]][ncd.values[v]] += 1
                }
            }
        }*/
        
        /*
        print("TRANSITION TABLE")
        for tt in 0..<transitionTable!.count {
            print("\(tt)-\(transitionTable![tt])")
        }
         */
    }
    
    func getPredictionByLastCombination(cd:CombinationData)->[Int] {
        var result = [Int](count: Conf.MAX_LOTTO_VALUE, repeatedValue: 0)
        for v in cd.values {
            let r = transitionTable![v]
            for i in 0..<r.count {
                result[i] += r[i]
            }
        }
        return result
    }
    
    
}