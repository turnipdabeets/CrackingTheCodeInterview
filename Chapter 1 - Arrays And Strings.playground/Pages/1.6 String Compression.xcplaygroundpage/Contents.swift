//: [Previous](@previous)

import Foundation

//: ### Implement a method to perform basic string compression using the counts of repeated characters. For example aabcccccaaa would become a2b1c5a3. If the "compressed" string is not smaller than the original your method should return the original string.

//: Can't do this without O(N) space becaause either need to eep track of original or create a new. Can't do less than O(N) time becasuse need to count all the characters in the string.

func compress(_ string: String) -> String {
    guard !string.isEmpty else { return string }
    
    var newString = ""
    var currentLetter = string.first!
    var total = 0
    
    for char in string {
        print(char)
        if currentLetter != char {
            newString.append("\(currentLetter)\(total)")
            currentLetter = char
            total = 1
        }else {
            total += 1
        }
    }
    newString.append("\(currentLetter)\(total)")
    print(newString)
    return newString.count < string.count ? newString : string
}

compress("anna")
//: [Next](@next)
