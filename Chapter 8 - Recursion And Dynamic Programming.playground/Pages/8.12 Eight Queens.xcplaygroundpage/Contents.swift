//: [Previous](@previous)

import Foundation

//: ### Write an alogrithm to print all ways of arranging eight queens on an 8x8 chess board so that none of them share the same row, column, or diagonal. In this case, "diagonal" means all diagonals, not just the two that bisect the board.

//https://leetcode.com/problems/n-queens/
//https://leetcode.com/problems/n-queens-ii/

typealias Board = [[String]]

func arrangeQueens(_ n: Int) -> [Board]{
    var results = [Board]()
   
    var board = createBoard(size: n)
    arrangeQueens(&board, for: 0, results: &results)
 
    for result in results {
        print(result)
        print(".........................")
    }
    print(results.count)
    return results
}

// Key to find all solutions is instead of returning Bool, append results on base case
func arrangeQueens(_ board: inout Board, for row: Int, results: inout [Board]) {
    // tried all rows, we can return a filled board
    if row == board.count {
        results.append(board); return
    }

    for col in 0..<board[row].count {
        if canPlace(board, row: row, col: col){
            board[row][col] = "Q"
            arrangeQueens(&board, for: row + 1, results: &results)
            board[row][col] = ""
        }
    }
    
    //couldn't place anywhere
}

func canPlace(_ board: Board, row: Int, col: Int) -> Bool {
    // we know it wont be on the same row becasue we only place one on each row already
//    if board[row].filter({ $0 == "Q" }).count > 0 { return false }
    
    for i in 0..<board[col].count {
        if board[i][col] == "Q" { return false }
    }
    
// don't need to check right diagionals since we place Left to Right
//    var row1 = row
//    var col1 = col
//    while row1 < board.count && col1 < board.count {
//        if board[row1][col1] == "Q" { return false }
//        row1 += 1
//        col1 += 1
//    }
    
    var row2 = row
    var col2 = col
    while row2 >= 0 && col2 >= 0 {
        if board[row2][col2] == "Q" { return false }
        row2 -= 1
        col2 -= 1
    }

    var row3 = row
    var col3 = col
    while row3 >= 0 && col3 < board.count {
        if board[row3][col3] == "Q" { return false }
        row3 -= 1
        col3 += 1
    }
    
// don't need to check right diagionals since we place Left to Right
//    var row4 = row
//    var col4 = col
//    while row4 < board.count && col4 >= 0 {
//        if board[row4][col4] == "Q" { return false }
//        row4 += 1
//        col4 -= 1
//    }
    
    return true
}

func createBoard(size: Int) -> Board {
    var board: Board = []
    for _ in 1...size {
        board.append(Array.init(repeating: "", count: size))
    }
    return board
}

createBoard(size: 2)

arrangeQueens(8)
//: [Next](@next)
