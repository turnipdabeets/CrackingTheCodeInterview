//: [Previous](@previous)

import Foundation

//: ### Given two strings, write a method to decide if one is a permutation of the other.

/*:
- Permutation has same count
- Does white space count?
- Is this case sensative?
 **/

//: 1. sort two strings, compare eqality O(N log N)
print("eakj".sorted() == "jake".sorted())

//: 2. Use hashmap, check that each character is in hashmap, subtract count and if -1 then false, O(N) time and space

func isPermutation(str: String, of str2: String) -> Bool{
    var dict = [Character: Int]()

    for char in str2 {
        if let count = dict[char] {
            dict[char] = count + 1
        }else {
            dict[char] = 1
        }
    }
    
    for char in str {
        guard let count = dict[char] else { return false }
        let remove = count - 1
        dict[char] = remove
        
        if remove < 0 { return false }
    }
    return true
}


print(isPermutation(str: "eakjt", of: "jake"))

//: [Next](@next)
