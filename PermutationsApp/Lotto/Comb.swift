//
//  Comb.swift
//  Loto5x36
//
//  Created by Exey Panteleev on 28/03/16.
//  Copyright © 2016 Mozgazm. All rights reserved.
//

import Foundation

func ==(l: Comb, r: Comb) -> Bool {
    if l.length != r.length { return false }
    let interesect = l.values.intersect(r.values)
    if interesect.count == l.length {
        return true
    }
    return false
}

struct Comb:Hashable, CustomStringConvertible {
    
    var values:Set<Int>
    var length:Int
    
    /** Constructor */ 
    init(values:[Int]) {
        self.values = Set<Int>()
        for v in values {
            self.values.insert(v)
        }
        length = self.values.count
    }
    
    var description: String {
        var s = ""
        for v in values { s += v.formatPrecision()+" " }
        return "< \(s)>"
    }
    
    // required var for the Hashable protocol
    var hashValue: Int {
        var s = ""
        for v in values { s += v.formatPrecision()}
        return s.hashValue
    }
}