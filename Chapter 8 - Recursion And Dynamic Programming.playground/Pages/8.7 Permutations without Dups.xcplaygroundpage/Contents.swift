//: [Previous](@previous)

import Foundation

// https://leetcode.com/problems/permutations/
//: ### Write a method to compute all permutations of a string of unique characters.

func getAllPermutations(_ string: String) -> [String] {
    guard string.count > 1, let char = string.last else { return [string] }
    
    var result = [String]()
    
    let previous = getAllPermutations(String(string.dropLast()))
    
    for item in previous {
        for i in item.indices {
            var s = item
            s.insert(char, at: i)
            result.append(s)
        }
        result.append(item + "\(char)")
    }
    print(string, ":", result)
    return result
}

//count should be factorial 4! (1 x 2 x 3 x 4) and time complexity is O(n!)
getAllPermutations("abcd")//.count

//: [Next](@next)
