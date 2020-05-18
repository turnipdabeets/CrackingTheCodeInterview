//: [Previous](@previous)

import Foundation

//: ### There are three types of edits that can be performed on strings: insert a character, remove a character, or replace a character. Given two strings, write a function to check if they are one edit (or zero edits) away.

//: check abs difference of two string lenghts and start the edits with that number becauase if they are 1 off then we need to insert a new character.

func shortLevenshteinDistance(_ string1: String, against string2:String) -> Bool {
    let countDifference = abs(string1.count - string2.count)
    guard countDifference <= 1 else {
        return false
    }
    let edits = zip(string1, string2).filter(!=).count + countDifference
    
    return edits <= 1
}

shortLevenshteinDistance("pae", against: "bale")


//: Attempt at Levenshtein Distance before I knew what it was.
//: use longestString to check smallest against. If charcters dont match then check that charcter against the rest of the longer string. If there is a match return that index and count inbetween. Start the loop from new index, otherwise if there is not match only count 1 and continue loop as usual. So many loops, really bad time complexity that's exponential. At least this is O(N^M) where N is the longer string and M is the shorter, but then each short letter checks each longer letter so this might be O(N^MN) or something like that. I just know its bad. Space complexity is ok, nothing really stored except a few variables. https://medium.com/@ethannam/understanding-the-levenshtein-distance-equation-for-beginners-c4285a5604f0

func levenshteinDistance(_ string1: String, against string2:String) -> Int {
    let longest = string1.count >= string2.count ? string1 : string2
    let shortest = string1.count < string2.count ? string1 : string2

    var difference = 0
    var index = longest.startIndex
    
    while index < longest.endIndex {
        for second in shortest {
            print(longest[index],second )
            if longest[index] != second {
                let (count, nextIndex) = differenceOfStrings(second, against: longest, offset: index)
                index = nextIndex
                difference += count
                if nextIndex == longest.endIndex {
                    break
                }
            }else {
                index = longest.index(after: index)
            }
        }
        if index != longest.endIndex {
            difference = longest[index...].count
            break
        }
    }
    
    return difference
}

func differenceOfStrings(_ option: Character, against: String, offset: String.Index)-> (Int, String.Index) {
    var total = 0
    var index = offset
    
    while index < against.endIndex {
        print("Check", option, against[index])
        if option == against[index] {
            return (total, against.index(after: index))
        }
        total += 1
        index = against.index(after: index)
    }
    
    return (1, against.index(after: offset))
}

//levenshteinDistance("pae", against: "bale")
// doesn't handle equal strings differently becasue abcr erbc = 3 not 2
//levenshteinDistance("abcr", against: "erbc")
//levenshteinDistance("kitten", against: "sitting")
//levenshteinDistance("jake", against: "jakeyjake")
//levenshteinDistance("arturo", against: "astronaut")
//levenshteinDistance("Door", against: "Dolls")

//: Use better algo O(mn) from https://github.com/raywenderlich/swift-algorithm-club/blob/master/Minimum%20Edit%20Distance/MinimumEditDistance.playground/Contents.swift


extension String {
    public func minimumEditDistance(other: String) -> Int {
        let m = self.count
        let n = other.count
        var matrix = [[Int]](repeating: [Int](repeating: 0, count: n + 1), count: m + 1)
        
        // initialize matrix
        for index in 1...m {
            // the distance of any first string to an empty second string
            matrix[index][0] = index
        }
        
        for index in 1...n {
            // the distance of any second string to an empty first string
            matrix[0][index] = index
        }
        
        // compute Levenshtein distance
        for (i, selfChar) in self.enumerated() {
            for (j, otherChar) in other.enumerated() {
                if otherChar == selfChar {
                    // substitution of equal symbols with cost 0
                    matrix[i + 1][j + 1] = matrix[i][j]
                } else {
                    // minimum of the cost of insertion, deletion, or substitution
                    // added to the already computed costs in the corresponding cells
                    matrix[i + 1][j + 1] = Swift.min(matrix[i][j] + 1, matrix[i + 1][j] + 1, matrix[i][j + 1] + 1)
                }
            }
        }
        print(matrix)
        return matrix[m][n]
    }
}

"Door".minimumEditDistance(other: "Dolls")


//: [Next](@next)
