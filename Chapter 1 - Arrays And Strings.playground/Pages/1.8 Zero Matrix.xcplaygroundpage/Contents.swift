//: [Previous](@previous)

import Foundation

//: ### Write an algorithm such that if an element in an MXN matrix is 0, its entire row and column are set to 0.

// O(MxN) + O(zeroRows x columnSize) + O(zeroColumns x rowSize) time complexity
// O(row and columns with 0) space which should be minimal unless everything so O(row.count + column.count)
// Another option for O(1) space is to set zeors in first row and colum to represent the Sets

func zeroOut(_ matrix: inout [[Int]]){
    var rows = Set<Int>()
    var columns = Set<Int>()
    
    let rowSize = matrix.count
    let columnSize = matrix[0].count
    
    // O(MxN) to touch each item once in matrix
    for row in 0..<rowSize {
        for col in 0..<columnSize {
            if matrix[row][col] == 0 {
                rows.insert(row)
                columns.insert(col)
            }
        }
    }
    
    //zero out each row with col index
    // O(zeroRows x columnSize)
    rows.forEach { row in
        for index in 0..<columnSize {
            matrix[row][index] = 0
        }
    }
    
    //zero out each col with row index
    // O(zeroColumns x rowSize)
    columns.forEach { col in
        for index in 0..<rowSize {
            matrix[index][col] = 0
        }
    }
}


var matrix = [
    [1,2,3],
    [4,0,6],
    [7,8,9],
    [7,8,9]
]
zeroOut(&matrix)

//: [Next](@next)
