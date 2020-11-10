//: [Previous](@previous)

import Foundation

//: ### Write a recursive function to multiply two positive integers without using the * operator or / operator. You can use addition, subtraction and bit shifting, but you should minimize the number of these operations.


// Could optimize to use smallest number as first so call order won't matter
func multiplyWithAddition(_ first: Int, _ second: Int) -> Int {
    if first == 0 || second == 0 { return 0 } // optimize 0 case by checking both
    if first == 1 { return second }
    
    return second + multiplyWithAddition(first - 1, second)
}

multiplyWithAddition(7, 9)


// think of matrix first x second where 8x7 is 4x7 + 4x7 and 4x7 is 2x7 doubled
// if number is factor of 2 then we can use its position, shift bits position-1 then add the remaining
(9 << 3) + 9 + 9
(9 << 3) + 9 + 9 + 9 // 11 x 9   11 - 3 = 8 (a power of 2)
(9 << 3) + 9 + 9 + 9 + 9 // 12 x 9    12 - 3 = 8
9 << 4 // 16 x 9
9 << 5 // 32 x 9
var cache = [Int: Int]()
func multiply(_ first: Int, _ second: Int) -> Int {
    if first == 0 { return 0 }
    if first == 1 { return second }
    if first == 2 { return second << 1 } // double
    
    if let saved = cache[first] {
       return saved
    }
    
    var result: Int
    
    if first & 1 == 1 { // if odd
        let half = first >> 1 // divide by 2
//        result = multiply(half, second) + multiply(half + 1, second)
        // instead we can add second and reduce number of call stacks to only 1
        result = second + (multiply(half, second) << 1) // multiply(half, second) + multiply(half + 1, second)
    }else {
        let half = first >> 1

        result = multiply(half, second) << 1 // double
    }
    
    cache[first] = result
    return result
}

multiply(7, 9)
print(cache)

// book solution is a combination of both solutions above
// it will never repeat the same call so we dont need a cache (goes straight down halfing)
// O(log s) where s is size of smaller number

func minProduct(_ a: Int, _ b: Int) -> Int {
    let bigger = a > b ? a : b
    let smaller = a < b ? a : b
    
    return minProductHelper(smaller, bigger)
}

private func minProductHelper(_ a: Int, _ b: Int) -> Int {
    print(a, b)
    if a == 0 { return 0 }
    if a == 1 { return b }
    
    let half = a >> 1 // divide by 2
    let result = minProductHelper(half, b)
    
    if a & 1 == 0 { // odd
        return b + (result >> 1)
    }else {
        return result >> 1 // double
    }
}

minProduct(9, 7)


//: [Next](@next)
