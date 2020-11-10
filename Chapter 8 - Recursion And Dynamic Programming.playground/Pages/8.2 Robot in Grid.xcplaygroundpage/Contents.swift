//: [Previous](@previous)

import Foundation

//: ### Imagine a robot sitting on the upper left corner of a grid with r rows and c columns. The robot can only move in two directions, right and down, but certain cells are "off limits" such that the robot cannot step on them. Design an algorithm to find a path for the robot from top left to the bottom right.

//typealias Position = (row: Int, col: Int)

struct Position: Hashable {
    let row: Int
    let col: Int
}

typealias Paths = [Position]

/// Return Single Path, with memoized failedPaths, (not reversed subtract row & col)

func getSinglePath(_ grid: [[String]]) -> Paths? {
    guard !grid.isEmpty else { return nil }
    var paths: Paths = []
    var failedPaths = Set<Position>()

    if singlePath(grid, position: Position(row: grid.count - 1, col: grid[0].count - 1), paths: &paths, failedPaths: &failedPaths) {
        return paths
    }

    return nil
}

func singlePath(
    _ grid: [[String]],
    position: Position,
    paths: inout Paths,
    failedPaths: inout Set<Position>
) -> Bool {
    guard position.row >= 0
        && position.col >= 0
        && grid[position.row][position.col] != "." else { return false }

    if failedPaths.contains(position) { return false }

    if position.row == 0 && position.col == 0
        || singlePath(grid, position: Position(row: position.row, col: position.col - 1), paths: &paths, failedPaths: &failedPaths)
        || singlePath(grid, position: Position(row: position.row - 1, col: position.col), paths: &paths, failedPaths: &failedPaths) {
        paths.append(position)
        return true
    }

    failedPaths.insert(position)
    return false
}

let gridForSinglePath = [
    ["1", ".", "."],
    ["4", "5", "."],
    ["7", "8", "9"],
    [".", "a", "b"],
    ["c", "d", "."],
    [".", "g", "h"],
]

getSinglePath(gridForSinglePath)!.compactMap{ print(gridForSinglePath[$0.row][$0.col]) }


/// Has a Path (reversed adding row and col)

func hasPath(_ grid: [[String]], position: Position = Position(row: 0, col: 0)) -> Bool {
    guard position.row < grid[0].count && position.col < grid[1].count else { return false }

    if grid[position.row][position.col] == "." { return false }

    print(grid[position.row][position.col])

    if position.row == grid[0].count - 1 && position.col == grid[1].count - 1 { return true }

    return hasPath(grid, position: Position(row: position.row, col: position.col + 1))
        || hasPath(grid, position: Position(row: position.row + 1, col: position.col))
}

hasPath([
       ["1", "2", "."],
       ["4", "5", "."],
       [".", "8", "9"],
      ])


/// Attempt at all Paths, maybe unable due to only right and down restrictions but should still be able to return a few paths for that restriction

////func getAllPath(_ grid: [[String]]) -> [Paths] {
////    guard !grid.isEmpty else { return [] }
////    var paths: Paths = []
////    var failedPaths = Set<Position>()
////    var allPaths = [Paths]()
////
////    robot(grid, position: Position(row: grid.count - 1, col: grid[0].count - 1), paths: &paths, failedPaths: &failedPaths, allPaths: &allPaths)
////
////    return allPaths
////}
//
//func getAllPath(_ grid: [[String]]) -> [Paths] {
//    guard !grid.isEmpty else { return [] }
//    var paths: Paths = []
//    var failedPaths = Set<Position>()
//    var allPaths = [Paths]()
//
//    for row in 0..<grid.count {
//        for col in 0..<grid[0].count {
//            robot(grid, position: Position(row: grid.count - 1 - row, col: grid[0].count - 1 - col), paths: &paths, failedPaths: &failedPaths)
//            let p = paths
//            paths = []
//            allPaths.append(p)
//        }
//    }
//
////    print(paths.map{ print(grid[$0.row][$0.col]) })
//
//
//
//    return allPaths
//}
//
//func robot(
//    _ grid: [[String]],
//    position: Position,
//    paths: inout Paths,
//    failedPaths: inout Set<Position>
//) -> Bool {
//    guard position.row >= 0
//        && position.col >= 0
//        && grid[position.row][position.col] != "." else { return false }
//
//    if failedPaths.contains(position) { return false }
//
//    if position.row == 0 && position.col == 0
//        || robot(grid, position: Position(row: position.row, col: position.col - 1), paths: &paths, failedPaths: &failedPaths)
//        || robot(grid, position: Position(row: position.row - 1, col: position.col), paths: &paths, failedPaths: &failedPaths) {
//        paths.append(position)
//        return true
//    }
//
//    failedPaths.insert(position)
//    return false
//}
//
//let grid = [
//    ["1", ".", "."],
//    ["4", "5", "."],
//    ["7", "8", "9"],
//    [".", "a", "b"],
//    ["c", "d", "."],
//    [".", "g", "h"],
//]
//
//dump(getAllPath(grid).map { $0.map{ print(grid[$0.row][$0.col]) } })


// Similar problem on leetcode
//https://leetcode.com/problems/robot-room-cleaner/submissions/
/**
 * // This is the robot's control interface.
 * // You should not implement it, or speculate about its implementation
 * public class Robot {
 *     // Returns true if the cell in front is open and robot moves into the cell.
 *     // Returns false if the cell in front is blocked and robot stays in the current cell.
 *     public func move() -> Bool {}
 *
 *     // Robot will stay in the same cell after calling turnLeft/turnRight.
 *     // Each turn will be 90 degrees.
 *     public func turnLeft() {}
 *     public func turnRight() {}
 *
 *     // Clean the current cell.
 *     public func clean() {}
 * }
 */

protocol Robot {
    func turnRight()
    func turnLeft()
    func move() -> Bool
    func clean()
}

struct Cell: Hashable {
    let row: Int
    let col: Int
}

class Solution {
    enum Direction: CaseIterable {
        case up, right, down, left
    }
    
    var visited = Set<Cell>()
    
    func moveBack(_ robot: Robot) {
        robot.turnRight()
        robot.turnRight()
        robot.move()
        robot.turnRight()
        robot.turnRight()
    }
    
    func cleanRoom(_ robot: Robot) {
        clean(robot, cell: Cell(row: 0, col: 0), direction: .up)
    }
    
    func clean(_ robot: Robot, cell: Cell, direction: Direction) {
        robot.clean()
        visited.insert(cell)
        
        var nextCell: Cell
        var currentDirection = direction
        
        for _ in 0..<Direction.allCases.count {
            nextCell = getNextCell(cell, for: currentDirection)
            
            if !visited.contains(nextCell) && robot.move() {
                print("moving to", nextCell, direction)
                clean(robot, cell: nextCell, direction: currentDirection)
                print("***Backing up", nextCell, direction)
                moveBack(robot)
            }
        
            robot.turnRight()
            currentDirection = getNextDirection(for: currentDirection)
        }
        
    }
    
    func getNextCell(_ cell:Cell, for direction: Direction) -> Cell {
        switch direction {
            case .up:
                return Cell(row: cell.row - 1, col: cell.col)
            case .right:
                return Cell(row: cell.row, col: cell.col + 1)
            case .down:
                return Cell(row: cell.row + 1, col: cell.col)
            case .left:
                return Cell(row: cell.row, col: cell.col - 1)
        }
    }
    
    func getNextDirection(for direction: Direction) -> Direction {
        switch direction {
            case .up:
                return .right
            case .right:
                return .down
            case .down:
                return .left
            case .left:
                return .up
        }
    }
}

// Another similar problem on leetcode
//https://leetcode.com/problems/the-maze/
/**
There is a ball in a maze with empty spaces (represented as 0) and walls (represented as 1). The ball can go through the empty spaces by rolling up, down, left or right, but it won't stop rolling until hitting a wall. When the ball stops, it could choose the next direction.

Given the maze, the ball's start position and the  destination, where start = [startrow, startcol] and destination = [destinationrow, destinationcol], return true if the ball can stop at the destination, otherwise return false.

You may assume that the borders of the maze are all walls (see examples).
*/

class Solution1 {
    enum Direction { case up, down, left, right }
    
    var visited = Set<[Int]>()
    
    func hasPath(_ maze: [[Int]], _ start: [Int], _ destination: [Int]) -> Bool {
        if maze[start[0]][start[1]] == 1 { return false }
        if visited.contains(start) { return false}
        if start == destination { return true }
        
        visited.insert(start)
        
        return hasPath(maze, roll(start, in: maze, for: .right), destination)
        || hasPath(maze, roll(start, in: maze, for: .left), destination)
        || hasPath(maze, roll(start, in: maze, for: .up), destination)
        || hasPath(maze, roll(start, in: maze, for: .down), destination)
    }
    
    func roll(_ start: [Int], in maze: [[Int]], for direction: Direction) -> [Int] {
        var previous = start
        var current = start
        
        while current[0] < maze.count
                && current[1] < maze[0].count
                && current[0] >= 0
                && current[1] >= 0
                && maze[current[0]][current[1]] == 0 {
            previous = current

            switch direction {
                case .up:
                    current = [current[0] - 1, current[1]]
                case .down:
                    current = [current[0] + 1, current[1]]
                case .left:
                    current = [current[0], current[1] - 1]
                case .right:
                    current = [current[0], current[1] + 1]
            }
        }
        return previous
    }
}

//: [Next](@next)
