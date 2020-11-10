//: [Previous](@previous)

import Foundation
import UIKit

//: ### Implement the "paint fill" function that one might see on many image editing programs. That is, given a screen (represented by a two-dimensional array of colors), a point, and a new color, fill in the surrounding area until the color changes from the original color.

func paintFill(_ canvas: inout [[String]], point: (Int, Int), newColor: String){
    if point.0 < 0 || point.1 < 0 || point.0 >= canvas.count || point.1 >= canvas[point.0].count { return }
    // inital color
    dfs(&canvas, point: point, newColor: newColor, initialColor: canvas[point.0][point.1])
}

func dfs(_ canvas: inout [[String]], point: (Int, Int), newColor: String, initialColor: String){
    // if out of bounds
    if point.0 < 0 || point.1 < 0 || point.0 >= canvas.count || point.1 >= canvas[point.0].count { return }
    // same color or not iniital color
    if canvas[point.0][point.1] == newColor || canvas[point.0][point.1] != initialColor { return }

    canvas[point.0][point.1] = newColor

    for path in [(0, 1), (1, 0), (-1, 0), (0, -1), (1, 1), (-1, -1), (-1, 1), (1, -1)] {
        dfs(&canvas, point: (point.0 + path.0, point.1 + path.1), newColor: newColor, initialColor: initialColor)
    }
}

var canvas = [
    ["G", "G", "R", "R"],
    ["G", "G", "R", "R"],
    ["G", "R", "R", "R"],
    ["R", "R", "Y", "R"],
    ["R", "R", "R", "R"]
]

paintFill(&canvas, point: (0,2), newColor: "B")
dump(canvas)

// Use IndexPath since it's hashable to store ina Set to prevent extra calls
func paintFillOptimized(_ canvas: inout [[String]], point: IndexPath, newColor: String){
    if point.row < 0 || point.section < 0 || point.row >= canvas.count || point.section >= canvas[point.row].count { return }
    // inital color
    dfsOptimized(&canvas, point: point, newColor: newColor, initialColor: canvas[point.row][point.section])
}

var pathSet: Set<IndexPath> = []

func dfsOptimized(_ canvas: inout [[String]], point: IndexPath, newColor: String, initialColor: String){
    // if out of bounds
    if point.row < 0 || point.section < 0 || point.row >= canvas.count || point.section >= canvas[point.row].count { return }
    // same color or not iniital color
    if canvas[point.row][point.section] == newColor || canvas[point.row][point.section] != initialColor { return }
    
    canvas[point.row][point.section] = newColor
    
    pathSet.insert(point)
    
    for path in [(0, 1), (1, 0), (-1, 0), (0, -1), (1, 1), (-1, -1), (-1, 1), (1, -1)] {
        let newPoint = IndexPath(row: point.row + path.0, section: point.section + path.1)
        if !pathSet.contains(newPoint){
            dfsOptimized(&canvas, point: newPoint, newColor: newColor, initialColor: initialColor)
        }
    }
}

var canvas1 = [
    ["G", "G", "R", "R"],
    ["G", "G", "R", "R"],
    ["G", "R", "R", "R"],
    ["R", "R", "Y", "R"],
    ["R", "R", "R", "R"]
]

paintFillOptimized(&canvas1, point: IndexPath(row: 0, section: 2), newColor: "B")
dump(canvas1)

// BFS
func paintFillBFS(_ canvas: inout [[String]], point: (Int, Int), newColor: String){
    
    var queue = [(Int, Int)]()
    queue.append(point)
    
    // assumes in bounds
    let initialColor = canvas[point.0][point.1]
    
    while !queue.isEmpty {
        let currentPoint = queue.removeFirst()
        if canvas[currentPoint.0][currentPoint.1] == newColor {
            // short circuit duplicates
            continue
        }
        
        canvas[currentPoint.0][currentPoint.1] = newColor

        for path in [(0, 1), (1, 0), (-1, 0), (0, -1), (1, 1), (-1, -1), (-1, 1), (1, -1)] {
            let newPoint = (currentPoint.0 + path.0, currentPoint.1 + path.1)
            if newPoint.0 < 0 || newPoint.1 < 0 || newPoint.0 >= canvas.count || newPoint.1 >= canvas[newPoint.0].count {
                continue
            }
            if canvas[newPoint.0][newPoint.1] == initialColor {
                queue.append(newPoint)
            }
        }
        
    }
}

var canvas2 = [
    ["G", "G", "R", "R"],
    ["G", "G", "R", "R"],
    ["G", "R", "R", "R"],
    ["R", "R", "Y", "R"],
    ["R", "R", "R", "R"]
]

paintFillBFS(&canvas2, point: (0,2), newColor: "B")
dump(canvas2)

//: [Next](@next)
