//: [Previous](@previous)

import Foundation

//: ### Implement an algorithm to determine if a string has all unique characters. What if you cannot use additional data structures?

/*:
- Best Case Runtime is 0(N) need to see each charater to access
 **/

//: 1. Use a Set, 0(N) to make a set and O(1) to compare count
let string = "anna"
let set = Set(string)
set.count == "anna".count

//: 2. Use a Dictionary O(N) space and time complexity
// let characterSet = CharacterSet.init(charactersIn: string)
var dict = [Character: Int]()

func isUnique(string: String)-> Bool {
    for char in string {
        guard dict[char] == nil else { return false }
        dict[char] = 1
    }
    return true
}

isUnique(string: "anna")

//: 3. Compare every character of the string to every other charater O(N^2) time and O(1) space

//: 4.  Sort the string and then binary search or liner search for identical neighboring characters - will result in 0(N log N) time and depedning on soting algo O(N) space. If we dont want to use space then we use HeapSort with 0(N log N) time and O(1) space

//: 5. Use a bit vector.
// https://stackoverflow.com/questions/9141830/explain-the-use-of-a-bit-vector-for-determining-if-all-characters-are-unique
// Use an Int and 26 bits to "turn on" positions for all 26 lowercased characters. 1 store in a bit equals that character was found. We will update the Int with each character and check for duplicates by using AND (which will return 1 only if both contain 1). OR will help us join the letter position with the bit vector to keep track of all the characters found.

func isUniqueBitVector(string: String)-> Bool {
    var checker = 0
    let aValue : UInt8 = Character("a").asciiValue!
    
    for char in string {
        if let charValue = Character(char.lowercased()).asciiValue {
            let difference = charValue - aValue
            let mask = 1 << difference
            if (checker & mask) > 0 {
                // duplicate found - AND returns 1 if both checker and mask contain a 1
                return false
            }
    
            checker |= mask
            print(String(checker, radix: 2))
        }
    }
    
    return true
}

isUniqueBitVector(string: "azbcde")


//: [Next](@next)
