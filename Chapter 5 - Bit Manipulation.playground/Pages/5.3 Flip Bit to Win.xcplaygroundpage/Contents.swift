//: [Previous](@previous)

import Foundation

//: ### You have an integer and you can flip exactly one bit from a 0 to 1. Write code to find the length of the longest sequence of 1s you could create.

//: Example:
//: - Input: 1775 (or: 11011101111)
//: - Output: 8

// O(b) time
func flip0to1Length(_ num: Int) -> Int {
    var foundZero = false
    for i in 1..<num.bitWidth {
        if hasZero(num, at: i) {
            if !foundZero {
                foundZero = true
            }else {
                return i
            }
        }
    }
    return 0
}

private func hasZero(_ num: Int, at position: Int) -> Bool {
    let newNum = num | (1 << position)
//    print(String(newNum, radix: 2))
//    print(String(num, radix: 2), position)
    return newNum != num
}

// Book solution O(b) comparing num to 1 by shifting num right
func flipBit(_ num: Int) -> Int {
    if ~num == 0 { return num.bitWidth }
    var num = num
    var current = 0
    var previous = 0
    var maxLength = 1
    
    while num != 0 {
        if num & 1 == 1 {
            // current bit is a one
            current += 1
        }else if num & 1 == 0 {
            //current bit is a zero
            //if next bit is 0 update to 0
            previous = (num & 2) == 0 ? 0 : current
            current = 0
        }
        maxLength = max(current + previous + 1, maxLength)
        num = num >> 1
//        print(String(num, radix: 2))
    }
    return maxLength
}

flipBit(1775)
flip0to1Length(1775)

//: [Next](@next)
