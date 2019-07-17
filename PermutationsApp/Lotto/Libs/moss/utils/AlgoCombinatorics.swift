//
//  AlgoCombinatorics.swift
//  Loto5x36
//
//  Created by Exey Panteleev on 28/03/16.
//  Copyright © 2016 Mozgazm. All rights reserved.
//

import Foundation
import CoreGraphics

public struct AlgoCombinatorics {
    
    // BInt is Int256
    
    // MARK: - Calculations
    
    /** Calculates the odds or drawing n particular things from a population of y.
     *  x is the number of particular things in the population
     *  y is the total population
     *  z is the number of things that are drawn
     *  n is the number of x's you want to test against being drawn
     */
    static public func hyperGeometricDistribution(x:BInt,y:BInt,z:BInt,n:BInt)->CGFloat {
        let p1 = CGFloat(combinations( x, n ).toInt())
        let p2 = CGFloat(combinations( y-x, z-n ).toInt())
        let p3 = CGFloat(combinations( y, z ).toInt())
        print("\(p1) \(p2) \(p3)")
        return p1 * p2 / p3
    }
    
    /** Calculates C(n, k), or "n-choose-k". Doesn't work very well for large numbers. */
    static public func combinations(n: BInt, _ k: BInt) -> BInt {
        return permutations(n, k) / factorial(k)
    }
    
    /** True calculate C(n, k), or "n-choose-k", i.e. the number of ways to choose k things out of n possibilities. Dynamic.
     */
    static public func binomialCoefficient(n: Int, _ k: Int) -> Int {
        let bc = Array2D(columns: n + 1, rows: n + 1, initialValue: 0)
        
        for i in 0...n {
            bc[i, 0] = 1
            bc[i, i] = 1
        }
        
        if n > 0 {
            for i in 1...n {
                for j in 1..<i {
                    bc[i, j] = bc[i - 1, j - 1]! + bc[i - 1, j]!
                }
            }
        }
        
        return bc[n, k]!
    }
    
    // MARK: - Helpers
    
    /** Calculates n! */
    static public func factorial(n: BInt) -> BInt {
        var n = n
        var result:BInt = 1
        while n > 1 {
            result *= n
            n -= 1
        }
        return result
    }
    
    /** Calculates P(n, k), the number of permutations of n distinct symbols in groups of size k */
    static public func permutations(n: BInt, _ k: BInt) -> BInt {
        var n = n
        var answer = n
        for _ in 1..<k.toInt() {
            n -= 1
            answer *= n
        }
        return answer
    }
    
    /** All the permutations of the given array. Idea by Niklaus Wirth */
    static public func permuteWirth<T>(a: [T], _ n: Int) {
        if n == 0 {
            print(a)   // display the current permutation
        } else {
            var a = a
            permuteWirth(a, n - 1)
            for i in 0..<n {
                swap(&a[i], &a[n])
                permuteWirth(a, n - 1)
                swap(&a[i], &a[n])
            }
        }
    }
    
    /* All the permutations of an n-element collection. Idea by Robert Sedgewick. */
    static public func permuteSedgewick(a: [BInt], _ n: Int, inout _ pos: BInt) {
        var a = a
        pos += 1
        a[n] = pos
        if pos == BInt(a.count) - 1 {
            print(a)              // display the current permutation
        } else {
            for i in 0..<a.count {
                if a[i] == 0 {
                    permuteSedgewick(a, i, &pos)
                }
            }
        }
        pos -= 1
        a[Int(n)] = 0
    }
    
}