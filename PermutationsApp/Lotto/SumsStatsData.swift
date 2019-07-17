//
//  SumData.swift
//  Lotto
//
//  Created by Exey Panteleev on 17/03/16.
//  Copyright © 2016 Mozgazm. All rights reserved.
//

import Foundation

struct SumsStatsData {
    
    var values:[Int]
    
    /** CONSTRUCTOR */
    init(draws:[CombinationData]) {
        values = [Int](count: DataManager.maxSum+1, repeatedValue: 0)
        for d in draws {
            values[d.sum] += 1
        }
        
        // print
        //for i in 0...values.count-1 { print("\(i) - \(values[i])") }
    }
    
    var valuesWithoutImpossible:[Int] {
        var v = values
        
        let possibleRange = DataManager.maxSum - DataManager.minSum
        
        while v.count > (possibleRange+1) {
            v.removeFirst()
        }
        print("TEST \(v.count) ### \(v)")
        return v
    }
 
    var dataPoints:[Int] {
        return [Int](DataManager.minSum...DataManager.maxSum) // without zero
    }
    
}