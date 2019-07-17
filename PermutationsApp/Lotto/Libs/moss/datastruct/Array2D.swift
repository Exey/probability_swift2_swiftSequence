//
//  Array2D using generics
//  Created by Exey Panteleev on 10/06/14
//

import Foundation

class Array2D<T> {
    
    let columns: Int
    let rows: Int
    
    private var array: Array<T?>  // private
    
    /** Constructor */
    init(columns: Int, rows: Int, initialValue:T? = nil) {
        self.columns = columns
        self.rows = rows
        array = Array<T?>(count: rows*columns, repeatedValue: initialValue != nil ? nil : initialValue!)
    }
    
    subscript(column: Int, row: Int) -> T? {
        get {
            return array[row*columns + column]
        }
        set {
            array[row*columns + column] = newValue
        }
    }
}