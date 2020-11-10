//: [Previous](@previous)

import Foundation

// https://leetcode.com/problems/longest-valid-parentheses/
// https://leetcode.com/problems/generate-parentheses/
// https://leetcode.com/problems/valid-parentheses/

//: ### Implement an algorithm to print all valid (i.e. properly opened and closed) combinations of n pairs of parentheses.

// similar to all permutations 8.7 by inserting at each indeces, but checking for duplicates before adding to the result
func allPairs(_ numberOfPairs: Int) -> [String] {
    guard numberOfPairs > 0 else { return [] }
    if numberOfPairs == 1 { return ["()"] }
    
    var results = [String]()
    let pairs = allPairs(numberOfPairs - 1)
    
    for pair in pairs {
        for i in pair.indices {
            var s = pair
            s.insert(contentsOf: "()", at: i)
            if !results.contains(s) { results.append(s)}
        }
    }
    return results
}

allPairs(3)

// we can be more efficient by not creating duplicates
func allPairsOptimized(_ numberOfPairs: Int) -> [String] {
    var result = [String]()
    allPairsOptimized(
        &result,
        leftCount: numberOfPairs,
        rightCount: numberOfPairs
    )
    return result
}

private func allPairsOptimized(_ result: inout [String], leftCount: Int, rightCount: Int, string: String = "") {
    
    if leftCount < 0 || rightCount < leftCount { return }
    
    if leftCount == 0 && rightCount == 0 {
        return result.append(string)
    }
    
    allPairsOptimized(&result, leftCount: leftCount - 1, rightCount: rightCount, string: string + "(")
    
    allPairsOptimized(&result, leftCount: leftCount, rightCount: rightCount - 1, string: string + ")")
}

allPairsOptimized(2)

//: ### Related problem: Valid Parentheses
//https://leetcode.com/problems/valid-parentheses/
// Given a string s containing just the characters '(', ')', '{', '}', '[' and ']', determine if the input string is valid.

func isValid(_ s: String) -> Bool {
    guard !s.isEmpty else { return true }
    
    var stack = [Character]()
    
    for char in s {
        // append opposite
        if char == "(" {
            stack.append(")")
        } else if char == "[" {
            stack.append("]")
        } else if char == "{" {
            stack.append("}")
        }else {
            // if doesn't start with lefts or match char then false
            if stack.isEmpty || stack.removeLast() != char { return false }
        }
        
    }
    
    //stack should be empty
    return stack.count == 0
}

func isValidLessConcise(_ s: String) -> Bool {
    guard !s.isEmpty else { return true }
    var stack = [Character]()
    
    for char in s {
        // stack should only hold lefts
        if char == "(" || char == "[" || char == "{" {
            stack .append(char)
            continue
        }
        
        let last = stack.last
        
        if char == ")" && last == "("
            || char == "]" && last == "["
            || char == "}" && last == "{"{
            // when find a right match for top stack then remove
            stack.removeLast()
        }else {
            // if find right for item not on top stack false
            return false
        }
    }
    //stack should be empty
    return stack.count == 0
}

//: [Next](@next)
