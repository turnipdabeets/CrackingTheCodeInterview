//: [Previous](@previous)

import Foundation

//: ### Given a positive integer, print the next smallest and the next largest number that have the same number of 1 bits in their binary representation.

func getNext(_ num: Int) -> Int? {
    var num = num
    let trailingZeros = num.trailingZeroBitCount
    let rightOnes = numberOfOnes(num >> trailingZeros)
    print(String(num, radix: 2))

    // position of rightmost non-trailing zero
    let position = trailingZeros + rightOnes

    // there is no bigger number with the same number of 1s
    if position == 31 || position == 0 {
        return nil
    }
    
    /*
        Flip rightmost non-trailing 0 to 1
        11011001111100 |= 1000000 -> 11011011111100
    */
    num |= 1 << position // flip rightmost non-trailing 0 to 1
    
    /*
        Clear all bits to the right of position
        11011011111100 &= 0000000 -> 11011010000000
    */
    num &= ~((1 << position) - 1)
    
    /*
        Insert ones on the right
        11011010000000 |=  -> 11011010001111
    */
    num |= (1 << (rightOnes - 1)) - 1
    
    print(String(num, radix: 2))
    return num
}

private func numberOfOnes(_ num: Int) -> Int {
    // find number of 1's before first non trailing zero
    var num = num
    var rightOnes = 0
    while num & 1 == 1 {
        rightOnes += 1
        num >>= 1
    }
    return rightOnes
}

// Book soluiton:
func getNextBookSolution(_ num: Int) -> Int? {
    var mutatedNum = num
    var num = num
    var rightOnes = 0
    var rightZeros = 0

    while (mutatedNum & 1 == 0) && mutatedNum != 0 {
        rightZeros += 1
        mutatedNum >>= 1
    }

    while mutatedNum & 1 == 1 {
        rightOnes += 1
        mutatedNum >>= 1
    }

    let position = rightZeros + rightOnes

    if position == 31 || position == 0 {
        return nil
    }

    num |= 1 << position // flip rightmost non-trailing 0 to 1
    num &= ~((1 << position) - 1)
    num |= (1 << (rightOnes - 1)) - 1

    return num
}

func getNextArithmetic(_ num: UInt) -> Int {
    var mutatedNum = num
    var rightOnes = 0
    var rightZeros = 0

    while (mutatedNum & 1 == 0) && mutatedNum != 0 {
        rightZeros += 1
        mutatedNum >>= 1
    }

    while mutatedNum & 1 == 1 {
        rightOnes += 1
        mutatedNum >>= 1
    }
    
    let a = 1 << rightZeros
    let b = 1 << (rightOnes - 1)
    
    return Int(num) + a + b - 1
}

func getPrevious(_ num: UInt) -> UInt? {
    var temp = num
    var num = num
    var ones = 0
    var zeros = 0

    while temp & 1 == 1 {
        ones += 1
        temp >>= 1
    }
    
    if temp == 0 { return nil }
    
    while (temp & 1 == 0) && temp != 0 {
        zeros += 1
        temp >>= 1
    }
    
    let position = ones + zeros
    
    // Clears bits 0 through position + 1
    // 10011110000011 &= 11111100000000 -> 10011100000000
    num &= ~0 << (position + 1)

    let mask = (1 << (ones + 1)) - 1 // sequence of (ones + 1) 1s
    
    // 0b10011100000000 |= 0b1110000 -> 0b10011101110000
    num |= UInt(mask) << (zeros - 1)
    
    return num
}

func getPreviousArithmetic(_ num: UInt) -> Int? {
    var temp = num
    var ones = 0
    var zeros = 0

    while temp & 1 == 1 {
        ones += 1
        temp >>= 1
    }
    
    if temp == 0 { return nil }
    
    while (temp & 1 == 0) && temp != 0 {
        zeros += 1
        temp >>= 1
    }
    
    return Int(num) - (1 << ones) - (1 << (zeros - 1)) + 1
} 

getNext(0b11011001111100)
getNextBookSolution(0b11011001111100)
getNextArithmetic(0b11011001111100)

getPrevious(0b10011110000011)
getPreviousArithmetic(0b10011110000011)

//: [Next](@next)
