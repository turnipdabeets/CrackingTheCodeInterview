//: [Previous](@previous)

import Foundation

//: ### Given a string, write a function to check if it is a permutation of a palindrome. A palindrome is a word or phrase that is the same forwards and backwards. A permutation is a rearrangement of letters. The palindrome need not be limited to just dictionary words.

//: Use hash table to store counts of each letter, make sure only 1 or less odd counts total
//: - handles capitalization and non letters like space O(N) space and time
func isPalindromePermutation(_ string: String) -> Bool {
    var totals = [Character: Int]()
    var numberOfOddCharacters = 0
    
    for char in string.lowercased() {
        guard let count = totals[char] else {
            if char.isLetter {
                totals[char] = 1
                numberOfOddCharacters += 1
            }
            continue
        }
        totals[char] = count + 1
        if (count + 1) % 2 == 0 {
           numberOfOddCharacters -= 1
        }else {
           numberOfOddCharacters += 1
        }
    }
    
    return numberOfOddCharacters <= 1
}

isPalindromePermutation("Tact Coa")

//: Use a bit vector, assumes only ASCII
/*:
 - letter maps to .asciiValue 0-26
 - use int to toggle bit at that value 0 or 1
 - check only 1 or less bits toggles by subtracting 1 from the int and itself
 - solution not working, need to learn more abot bitvectors
**/

//func isPalindromePermutation2(_ string: String) -> Bool {
//    let bitVector = createBitVector(with: string)
//
//    return bitVector == 0 || exactlyOneBitSet(bitVector)
//}
//
//func createBitVector(with string: String) -> UInt8 {
//    var bitVector: UInt8 = 0
//    for char in string {
//        let value = char.asciiValue
//        if let value = value, value >= 0 {
//            let mask: UInt8 = 1 << value
//            if bitVector == 0 && mask == 0 {
//                bitVector = mask
//            }else {
//                bitVector -= mask
//            }
//        }
//    }
//    return bitVector
//}
//
//func exactlyOneBitSet(_ bitVector: UInt8) -> Bool {
//    return bitVector - (bitVector - 1) == 0
//}
//
//isPalindromePermutation2("tact coa")
//: [Next](@next)
