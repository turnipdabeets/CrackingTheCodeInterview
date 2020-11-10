//: [Previous](@previous)

import Foundation

//: ### A child is running up a staircase with n steps and can hop either 1 step, 2 steps, or 3 steps at a time. Implement a method to count how many possible ways the child can run up the stairs.

// Good to point out that Int may overflow around n = 37, use BigInterger equivalent in Swift?



// Book solution with inout memo

func countWays(totalSteps n: Int) -> Int {
    var memo = [0 : 1]
    return paths(totalSteps: n, memo: &memo)
}

func paths(totalSteps n: Int, memo: inout [Int: Int]) -> Int {
    if n < 0 { return 0}
    if let result = memo[n] { return result }
    
    memo[n] = paths(totalSteps: n - 1, memo: &memo) +
        paths(totalSteps: n - 2, memo: &memo) +
        paths(totalSteps: n - 3, memo: &memo)
    
    return memo[n]!
}

countWays(totalSteps: 8)

// vs original without memo

func possiblePaths(totalSteps n: Int) -> Int {
    if n <= 0 { return 0 }
    if n == 1 { return 1 }
    if n == 2 { return 2 }
    if n == 3 { return 4 }

    return possiblePaths(totalSteps: n - 1) +
        possiblePaths(totalSteps: n - 2) +
        possiblePaths(totalSteps: n - 3)
}

possiblePaths(totalSteps: 8)


//// Book solution with global memo
//
//var memo = [0 : 1]
//func possiblePaths(totalSteps n: Int) -> Int {
//    if n < 0 { return 0}
//    if let result = memo[n] { return result }
//    memo[n] = possiblePaths(totalSteps: n - 1) +
//        possiblePaths(totalSteps: n - 2) +
//        possiblePaths(totalSteps: n - 3)
//
//    return memo[n]!
//}
//
//possiblePaths(totalSteps: 8)
//print(memo)

//// Book solution no memo
//
//func possiblePaths(totalSteps n: Int) -> Int {
//    // how to get intuition to use this instead of base cases I chose?
//    if n < 0 { return 0 }
//    if n == 0 { return 1 }
//
//    return possiblePaths(totalSteps: n - 1) +
//        possiblePaths(totalSteps: n - 2) +
//        possiblePaths(totalSteps: n - 3)
//}
//
//possiblePaths(totalSteps: 8)

// MARK: Original with more base cases, how to get intution to use -1 as 0 and 0 as 1 like book?

//// Original without memo
//
//func possiblePaths(totalSteps n: Int) -> Int {
//    if n <= 0 { return 0 }
//    if n == 1 { return 1 }
//    if n == 2 { return 2 }
//    if n == 3 { return 4 }
//    print(n)
//    return possiblePaths(totalSteps: n - 1) +
//        possiblePaths(totalSteps: n - 2) +
//        possiblePaths(totalSteps: n - 3)
//}
//
//possiblePaths(totalSteps: 8)

//// Original with memo enclosed in function
//func possiblePathsMemo(totalSteps: Int) -> Int {
//    var memo: [Int: Int] = [1: 1, 2: 2, 3: 4]
//
//    func paths(for n: Int) -> Int {
//        if n <= 0 { return 0 }
//
//        if let result = memo[n] { return result }
//
//        memo[n] = paths(for: n - 1) +
//            paths(for: n - 2) +
//            paths(for: n - 3)
//
//        return memo[n]!
//    }
//
//    return paths(for: totalSteps)
//}
//
//possiblePathsMemo(totalSteps: 8)
