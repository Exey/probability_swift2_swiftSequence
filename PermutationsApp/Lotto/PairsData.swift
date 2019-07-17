//
//  PairsData.swift
//  Loto
//
//  Created by Exey Panteleev on 27/04/16.
//  Copyright © 2016 Mozgazm. All rights reserved.
//

import Foundation

typealias PairCounted = (count:Int, comb:[Int])

struct PairsData {
    
    var values:[PairCounted]
    var transitionTable:[[Int]]
    
    /** CONSTRUCTOR */
    init() {
        values = [PairCounted]() //result
        transitionTable = [[Int]]()
        // prepare data structure
        for i in 0..<Conf.MAX_LOTTO_VALUE {
            transitionTable.append([Int](count: Conf.MAX_LOTTO_VALUE, repeatedValue: 0))
        }
    }
    
    // MARK: - HELPERS
    
    func getPairCounted(unsortedPair:[Int])->PairCounted {
        var v = unsortedPair
        let v0 = v[0]
        let v1 = v[1]
        if v1 < v0 { swap(&v[0], &v[1]) }
        // search
        for vv in values {
            let vv0 = vv.comb[0]
            let vv1 = vv.comb[1]
            if vv0 == v[0] && vv1 == v[1] {
                return vv
            }
        }
        return (count: 0, comb: v)
    }
    
    // MARK: - MUTATING API
    
    mutating func addValues(vals:[[Int]]) {
        for var v in vals {
            let v0 = v[0]
            let v1 = v[1]
            if v1 < v0 { swap(&v[0], &v[1]) }
            transitionTable[v[0]][v[1]] += 1
            //print(v)
            // search
        }
        
    }
    
    mutating func countPairs() {
        
        //print("== TRANSITION TABLE")
        for y in 1..<transitionTable.count {
            let row = transitionTable[y]
            for x in 1..<row.count {
                let c = row[x]
                if c > 0 {
                    values.append((count: c, comb:[y, x]))
                }
            }
            
           // print("\(y)-\(transitionTable[y])")
        }
        
        values.sortInPlace() { $0.count > $1.count }
        
        print("== PAIRS COUNT \(values.count)")
        /*for i in 0..<values.count {
            //print("\(i) == \(values[i])")
            print("\(values[i])")
        }*/
    }
        
        
}