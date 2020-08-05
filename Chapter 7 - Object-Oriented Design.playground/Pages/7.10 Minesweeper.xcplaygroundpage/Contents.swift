//: [Previous](@previous)

import Foundation
import UIKit

//: ### Design and implement a text-based Minesweeper game. Minesweeper is the classic single-player computer game where an NxN grid has B mines (or bombs) hidden across the grid. The remaining cells are either blank or have a number behind them. The numbers reflects the number of bombs in the surrounding 8 cells. The user then uncovers a cell. If it is a bomb, the player loses. If it is a number, the number is exposed. If it is a blank cell, this cell and all adjacent blank cells (up to and including the surrounding numeric cells) are exposed. The player can also flag certain places as potential bombs. This doesn't affect game play, other than to block the user from accidentally clicking a cell that is thought to have a bomb. (Tip for the reader: if you're not familiar with this game, please play a few rounds online first.)

indirect enum CellType { case blank, bomb, number(Int), flag(CellType) }

class Cell {
    var type: CellType
    var path: IndexPath
    var isVisible = false
    
    init(type: CellType, path: IndexPath){
        self.type = type
        self.path = path
    }
}

class Minesweeper {
    private(set) var grid: [[Cell]]
    private var bombs = [Cell]()
    
    let deltas = [
        [-1, -1], [-1, 0], [-1, 1],
        [ 0, -1],          [ 0, 1],
        [ 1, -1], [ 1, 0], [ 1, 1],
    ]
    
    /// generate randomly placed bomb
    init?(bombs: Int, size: Int) {
        guard bombs < size else { return nil }
        
        var bombs = bombs
        
        // init NxN grid with K bombs in first K cells
        var cells = [[Cell]]()
        for section in 0..<size {
            cells[section] = []
            for row in 0..<size {
                if bombs > 0 {
                    let bombCell = Cell(type: .bomb, path: IndexPath(row: row, section: section))
                    cells[section][row] = bombCell
                    self.bombs.append(bombCell)
                    bombs -= 1
                }else {
                    cells[section][row] = Cell(type: .blank, path: IndexPath(row: row, section: section))
                }
            }
        }
        self.grid = cells
        shuffle()
        setNumbers()
    }
    
    private func shuffle() {
        let totalCells = grid.count * grid.count
        for i in 0..<totalCells {
            let random = Int.random(in: 0..<totalCells)
            if i != random {
                let cellSection = i / grid.count
                let cellRow = i % grid.count
                
                let randomSection = random / grid.count
                let randomRow = random % grid.count
                
                let cell = grid[cellSection][cellRow]
                let randomCell = grid[randomSection][randomRow]
                
                // swap
                grid[cellSection][cellRow] = randomCell
                grid[randomSection][randomRow] = cell
            
            }
        }
    }
    
    private func setNumbers(){
        // Added Cell.path to speed up this algo, but not a fan of making sure its in sysnc with grid. I would consider removing path and search entire grid for bombs.
        for bomb in bombs {
            for delta in deltas {
                let section = bomb.path.section + delta[0]
                let row = bomb.path.row + delta[1]
                
                if inBounds(IndexPath(row: row, section: section)){
                    let cell = grid[section][row]
                    switch cell.type {
                    case .blank:
                        cell.type = .number(1)
                    case let .number(n):
                        cell.type = .number(n + 1)
                    case .bomb, .flag:
                        return
                    }
                }
            }
        }
    }
    
    private func inBounds(_ path: IndexPath) -> Bool {
        return path.section < grid.count && path.section > 0
            && path.row < grid.count && path.row > 0
    }
    
    func flagCell(at path: IndexPath) {
        let cell = grid[path.section][path.row]
        cell.type = .flag(cell.type)
    }
    
    func unFlagCell(at path: IndexPath) {
        let cell = grid[path.section][path.row]
        guard case let .flag(type) = cell.type else { return }
        cell.type = type
    }
    
    func tap(cell: Cell, at path: IndexPath) {
        switch cell.type {
        case .blank:
            return expandBlankRegion(cell) // display all adjacent cells or win
        case .bomb:
            return // game over
        case .number:
            return cell.isVisible = true  // display number cell
        case .flag:
            return // do nothing
        }
    }
    
    func expandBlankRegion(_ cell: Cell){
        var queue = [Cell]()
        queue.append(cell)
        
        while !queue.isEmpty {
            let cell = queue.removeLast() // order doesn't matter but last is O(1)
            cell.isVisible = true
            
            for delta in deltas {
                let section = cell.path.section + delta[0]
                let row = cell.path.row + delta[1]
                
                if inBounds(IndexPath(row: row, section: section)){
                    let neighborCell = grid[section][row]
                    if case .blank = neighborCell.type, !neighborCell.isVisible {
                        queue.append(neighborCell)
                    }
                }
            }
        }
    }
}

//let a = UIView.init(frame: CGRect(origin: CGPoint(), size: CGSize(width: 10, height: 10)))
//a.backgroundColor = .red
//
//a.addGestureRecognizer(UITapGestureRecognizer(target: a, action: #selector(tap)))
//
//@objc func tap(){
//    print("TAP")
//}

//: [Next](@next)
