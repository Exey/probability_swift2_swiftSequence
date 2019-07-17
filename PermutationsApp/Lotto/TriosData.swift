//
//  TriosData.swift
//  Lotto
//
//  Created by Exey Panteleev on 27/04/16.
//  Copyright © 2016 Mozgazm. All rights reserved.
//

import Foundation

struct TriosData {

    var values:[(count:Int, comb:[Int])]
    var transitionTable:[[[Int]]]
    
    init() {
        values = [(count:Int, comb:[Int])]() //result
        transitionTable = [[[Int]]]()
        // prepare data structure
        for x in 0..<Conf.MAX_LOTTO_VALUE {
            var xVal:[[Int]] = [[Int]]()
            for y in 0..<Conf.MAX_LOTTO_VALUE {
                xVal.append([Int](count: Conf.MAX_LOTTO_VALUE, repeatedValue: 0))
            }
            transitionTable.append(xVal)
        }
    }
    
    mutating func addValues(vals:[[Int]]) {
        for var v in vals {
            
            v.sortInPlace() { $0 < $1 }
            
            transitionTable[v[0]][v[1]][v[2]] += 1
            //print("\(v) == \(transitionTable[v[0]][v[1]][v[2]]))")
  
        }
    }
    
    mutating func countTrios() {
        
        //print("== TRANSITION TABLE")
        for x in 1..<transitionTable.count {
            let xRow = transitionTable[x]
            for y in 1..<xRow.count {
                let yRow = transitionTable[x][y]
                for z in 1..<yRow.count {
                    let c = yRow[z]
                    if c > 0 {
                        values.append((count: c, comb:[x, y, z]))
                    }
                }
            }
        }
        
        values.sortInPlace() { $0.count > $1.count }
        print("== TRIOS COUNT \(values.count)")
        /*for i in 0..<values.count {
            //print("\(i) == \(values[i])")
            print("\(values[i])")
        }*/
    }
    
    
}