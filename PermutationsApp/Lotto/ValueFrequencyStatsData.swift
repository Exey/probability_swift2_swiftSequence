//
//  ValueFrequencyStatsData.swift
//  Lotto
//
//  Created by Exey Panteleev on 25/02/16.
//  Copyright © 2016 Mozgazm. All rights reserved.
//

import Foundation

struct ValueFrequencyStatsData:CustomStringConvertible  {

    var values:[Int]
    
    var description: String {
        var s = "Values Frequency\n"
        for i in 0 ..< values.count {
            s += "\(i) - \(values[i])\n"
        }
        return s
    }
    
    var valuesWithoutZero:[Int] {
        var v = values
        v.removeFirst()
        print("TEST FREQ \(values.count) \(v.count)")
        return v
    }
    
    var dataPoints:[Int] {
        return [Int](1...Conf.MAX_LOTTO_VALUE-1) // without zero
    }
    
}