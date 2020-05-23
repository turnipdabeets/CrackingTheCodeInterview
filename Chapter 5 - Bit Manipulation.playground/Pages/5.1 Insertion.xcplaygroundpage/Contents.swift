//: [Previous](@previous)

import Foundation

//: ### You are given two 32-bit numbers, N and M, adn two bit positions, i and j. Write a method to insert M into N such that M starts at bit j and ends at bit i. You can assume that the bits j through i have enough space to fill all of M. That is, is M = 10011, you can assume that there are at least 5 bits between j and i. You would not, for example, have j=3 and i=2, becasue M cuold not fully git between bit 3 and 2.

//: Example:
//: - Input: N = 10000000000, M = 10011, i = 2, j = 6
//: - Output: 10001001100

// In order to insert M into N we need to clear out position i-j with all 0s. By creating a mask of all 0s at position i-j and 1s on eiher side we can & the mask with N to clear out position i-j but keep either side intack. Once we have cleared the positions we can  shift M by position i and then OR the shifted M with N to insert.
//: - Clear bits i - j
//: - Shift M so that it lines up with bits i - j
//: - Merge M and N
func updateBits(_ n: Int, with m: Int, from i: Int, to j: Int) -> Int{
    if i > j || i < 0 || j >= 32 { return 0 }
    
    // 1s before position j, then 0s -> 11110000000
    let left = ~0 << (j + 1)
        
    // 1s after position i -> 11
    let right = (1 << i) - 1
        
    // join left and right -> 11110000011
    let mask = left | right
    
    // clear bits i - j as 0s by with mask
    // then OR against shifted m by i position
    let result = (n & mask) | (m << i)
    
    print(String(result, radix: 2))
    return result
}

updateBits(0b10000000000, with: 0b10011, from: 2, to: 6)
updateBits(0b11111111111, with: 0b10011, from: 2, to: 6)

////: [Next](@next)
