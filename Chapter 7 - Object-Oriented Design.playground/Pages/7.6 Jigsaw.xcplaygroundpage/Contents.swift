//: [Previous](@previous)

import Foundation
import UIKit

//: ### Implement an NxN Jigsaw puzzle. Design the data structures and explain an algorithm to solve the puzzle. You can assume that you have a fitsWith method which, when passed two puzzle edges, returns true if the two edges belong together.

enum Shape { case inner, outer, flat}

struct Edge {
    let shape: Shape
}

enum Orientation { case left, top, right, bottom }

struct Piece {
    let edges: [Edge]
    let orientation: Orientation
    
    func roateEdge(){
       // modify currentRotation based on a direction and percentage to rotate
    }
    
    func fitsWith(_ piece: Piece) -> Bool {
        //compare edges and see if shapes fit
        return true
    }
}

class Puzzle {
    var board = [[Piece?]]()
    let pieces: [Piece]
    let size: Int
    
    init(width: Int, height: Int, pieces: [Piece]){
        for w in 0..<width {
            board.append([])
            for _ in 0..<height {
                board[w].append(nil)
            }
        }
        self.pieces = pieces
        self.size = width
        
        // sort pieces into corner, outside, inside
    }
    
    func removePiece(_ piece: Piece, at path: IndexPath){}
    func setPiece(_ piece: Piece, at path: IndexPath){
        board[path.section][path.row] = piece
    }
    
    private func isBorderIndex(_ index: Int) -> Bool {
        return index == 0 || index == size - 1
    }
    
    private func getPiecesToSearch(cornerPieces: [Piece], borderPieces: [Piece], insidePieces: [Piece], path: IndexPath) -> [Piece] {
        if (isBorderIndex(path.section) && isBorderIndex(path.row)) {
            return cornerPieces
        } else if (isBorderIndex(path.section) || isBorderIndex(path.row)) {
            return borderPieces;
        } else {
            return insidePieces;
        }
    }
    
    func solve() {
        // Algo:
        // Oraganize pieces into outside pieces, corner pieces( two flat edges) and inside pieces (no flat edges)
        // set a corner piece at section 0 row 0.
        // rotate pieces to see if the fit to fill in and based on the type of piece we should check
        
        for section in 0..<size {
            for row in 0..<size {
                let path = IndexPath(row: row, section: section)
                let pieces = getPiecesToSearch(cornerPieces: <#T##[Piece]#>, borderPieces: <#T##[Piece]#>, insidePieces: <#T##[Piece]#>, path: path)
                // take piece and try to fit
                fit(pieces, at: path)
            }
        }
    }
    
    private func fit(_ pieces: [Piece], at path: IndexPath) {
        if path.section == 0 && path.row == 0 {
            // mgiht need to remove from pieces group too
            board[path.section][path.row] = pieces.first
          } else {
              /* Get the right edge and list to match. */
              
              /* Get matching edge. */
          }
      }
    
}

//let piece = Piece(edges: [Edge(shape: UIView(), isBorder: true)], initialRotation: 0, currentRotation: 0)
//let puzzle = Puzzle(width: 4, height: 4, pieces: [piece])
//puzzle.setPiece(piece, at: IndexPath(row: 2, section: 1))
//dump(puzzle)


//struct Edge {
//    let shape: UIView
//    let isBorder: Bool
//}

//struct Piece {
//    let edges: [Edge]
//    let initialRotation: CGFloat
//    private(set) var currentRotation: CGFloat
//
//    func roateEdge(){
//       // modify currentRotation based on a direction and percentage to rotate
//    }
//
//    func fitsWith(_ piece: Piece) -> Bool {
//        //compare edges and see if shapes fit
//        return true
//    }
//}

//: [Next](@next)
