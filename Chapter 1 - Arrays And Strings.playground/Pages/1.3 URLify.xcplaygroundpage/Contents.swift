//: [Previous](@previous)

import Foundation

//: ### Write a method to replace all space in a string with `%20`. You may assume that the string has sufficent space at the end to hold the additonal characters, and that you are given the "true" length of the string.

//: 1. Swift has a utility function to do this already, assumed O(N) time and space

let string = "Hello, World!"
string.replacingOccurrences(of: " ", with: "%20")

//: 2. loop and create a new String O(N) time and space
func URLify(_ string: String) -> String {
    var newString = ""
    for char in string {
        if char == " " {
            newString.append("%20")
        }else {
            newString.append(char)
        }
    }
    return newString
}

URLify(string)

//: 3. mutable string but strings are not random access, it takes O(N) to get index. Is this solution O(N^2) time but O(1) space?

func mutURLify(_ string: inout String) {
    for i in string.indices {
        if string[i] == " " {
            let next = string.index(after: i)
            string = string[..<i] + "%20" + string[next..<string.endIndex]
        }
    }
}

var mutabileString = "Goodbye, World!"
mutURLify(&mutabileString)

//: [Next](@next)
