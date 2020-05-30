//: [Previous](@previous)

import Foundation

//: ### Write a function to determine the number of bits you would need to flip to convert integer A to integer B

//: Example:
//: - Input: 29 (or: 11101), 15 (or: 01111)
//: - Output: 2

func numberToFlip(_ a: Int, into b: Int) -> Int {
    var total = 0
    var num = a ^ b
        
    while num != 0 {
        if num & 1 == 1 { total += 1 }
        num >>= 1
    }
    return total
}

// count the number of times we need to clear the right most 1s
// n & n - 1 will clear the right most 1s. We just need to count how many times we need to do this

//: - num = 10010 , num - 1 = 10001, total = 1
//: - 10010 & 10001 = 10000
//: - num = 10000 , num - 1 = 00000, total = 2

func numberToFlipAlt(_ a: Int, into b: Int) -> Int {
    var total = 0
    var num = a ^ b
        
    while num != 0 {
        num  = num & (num - 1)
        total += 1
    }
    return total
}

numberToFlip(0b11101, into: 0b01111)
numberToFlipAlt(0b11101, into: 0b01111)

//: [Next](@next)
