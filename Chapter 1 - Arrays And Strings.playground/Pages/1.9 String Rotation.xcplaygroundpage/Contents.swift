//: [Previous](@previous)

import Foundation

//: ### Assume you have a method isSubstring which checks if one word is a substring of another. Given two strings, s1 and s2, write code to check if s2 is a rotation of s1 using only one call to isSubstring [e.g. "waterbottle" is a rotation of "erbottlewat"]


//: contains(_:) is O(N) so this is O(N) time

func isRotation(_ string: String, of substring: String) -> Bool {
    guard !string.isEmpty && !substring.isEmpty
        && string.count == substring.count else {
        return false
    }
    let doubled = string + string
    return doubled.contains(substring)
}


isRotation("waterbottle", of: "erbottlewat")

//: [Next](@next)
