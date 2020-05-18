//: [Previous](@previous)

import Foundation

//: ### Given an image represented by an NxN matrix, where each pixel in the image is 4 bytes, write a method to rotate the image by 90 degrees. Can you do this in place?.

// O(N) time and O(1) space

func rotate(_ image: inout [[Int]]){
    guard image.count != 0 || image.count == image[0].count else { return }

    let size = image.count
    let middle = size/2

    for layer in 0..<middle {
        let first = layer
        let last = size - 1 - layer
        print("First", first)
        print("Last", last)
        print("layer", layer)
        print("-------")

        for index in layer..<last {
            let offset = index - first
            let top = image[first][index]
            print("top", top)
            // left -> top
            print("left",image[last-offset][first], "->", "top", image[first][index])
            image[first][index] = image[last-offset][first]

            // bottom -> left
            print("bottom",image[last][last - offset], "->", "left", image[last-offset][first])
            image[last-offset][first] = image[last][last - offset]

            // right -> bottom
            print("right",image[index][last], "->", "bottom", image[last][last - offset])
            image[last][last - offset] = image[index][last]

            // top -> right
            print("top",top, "->", "right", image[index][last])
            image[index][last] = top
        }
    }
}

var image = [
[1,2,3,4,5,6],
[7,8,9,10,11,12],
[13,14,15,16,17,18],
[19,20,21,22,23,24],
[25,26,27,18,29,30],
[31,32,33,34,35,36]
]

//var image = [
//[1,2,3,4,5],
//[7,8,9,10,11],
//[13,14,15,16,17],
//[19,20,21,22,23],
//[25,26,27,18,29],
//]

rotate(&image)

//: [Next](@next)


// failed attempts:


//typealias Position = (row: Int, col: Int)
//
//func rotate(_ image: inout [[Int]]) {
//    let size = image.count
//    let mid = size / 2
//
//    print("size, mid",size, mid)
//
//    for perimeters in 0..<mid {
//        print("per", perimeters)
//        for i in perimeters...(mid - perimeters) {
//            print("i", i)
//            replace(&image, position: Position(row: perimeters, col: i), size: size)
//        }
//    }
//}
//
//func replace(_ image: inout [[Int]], position: Position, size: Int){
//    print("initial", position)
//    var tempPosition = position
//    var tempItem = image[position.row][position.col]
//    var complete = false
//
//    while(!complete){
//        print("temp", tempPosition)
//        let nextPosition = getNextPosition(tempPosition, size: size)
//        let newItem = image[nextPosition.row][nextPosition.col]
//        print("placing", tempItem, "at", nextPosition)
//        image[nextPosition.row][nextPosition.col] = tempItem
//        tempPosition = nextPosition
//        tempItem = newItem
//        print("saved", tempPosition, tempItem)
//        if tempPosition == position { complete = true }
//    }
////    image[tempPosition.row][tempPosition.col] = tempItem
//}
//
//func getNextPosition(_ position: Position, size: Int) -> Position {
//    let newRow = position.col
//    let newCol = abs(position.row - (size - 1))
//    print("newRow, newCol", newRow, newCol)
//    return (newRow, newCol)
//}

//typealias Position = (row: Int, col: Int)
//
//func rotate(_ image: inout [[Int]]) {
//    let size = image.count
//    let mid = size / 2
//
//    print("size, mid",size, mid)
//
//    for perimeters in 0..<mid {
//        print("per", perimeters)
//        for i in perimeters...(size - 1 - perimeters) {
//            print("i", i)
//            replace(&image, position: Position(row: perimeters, col: i), size: size)
//        }
//    }
//}
//
//func replace(_ image: inout [[Int]], position: Position, size: Int){
//    print("initial", position)
//    var tempPosition = position
//    var tempItem = image[position.row][position.col]
//    var complete = false
//
//    while(!complete){
//        print("temp", tempPosition)
//        let nextPosition = getNextPosition(tempPosition, size: size)
//        let newItem = image[nextPosition.row][nextPosition.col]
//        print("placing", tempItem, "at", nextPosition)
//        image[nextPosition.row][nextPosition.col] = tempItem
//        tempPosition = nextPosition
//        tempItem = newItem
//        print("saved", tempPosition, tempItem)
//        if tempPosition == position { complete = true }
//    }
////    image[tempPosition.row][tempPosition.col] = tempItem
//}
//
//func getNextPosition(_ position: Position, size: Int) -> Position {
//    let newRow = position.col
//    let newCol = abs(position.row - (size - 1))
//    print("newRow, newCol", newRow, newCol)
//    return (newRow, newCol)
//}
////
//
//rotate(&image)

