//: [Previous](@previous)

import Foundation

//: ### Implement an algorithm to determine if a string has all unique characters. What if you cannot use additional data structures?

/*:
- Best Case Runtime is 0(N) need to see each charater to access
 **/

//: 1. Use a Set, 0(N) to make a set and O(1) to compare count
let string = "anna"
let set = Set(string)
print(set.count == "anna".count)

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

//: [Next](@next)
