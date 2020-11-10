//: [Previous](@previous)

import Foundation

// https://leetcode.com/problems/subsets/submissions/

//: ### Write a method to return all subsets of a set.

// For each added element in a set we will set another power of 2 subsets
// We can't do better than O(n 2^n) in time and space

// n = 0 [{}]
// n = 1 [{} {1}] - add 1 to previous sets
// n = 2 [{} {1}, {2}, {1, 2}] - add 2 to previous sets
// n = 3 [{} {1}, {2}, {1, 2}, {3}, {1, 3}, {2, 3}, {1,2,3}] - add 3 to previous sets

func subsets<T>(set: Set<T>) -> [Set<T>]{
    var subsets = [Set<T>()]
    
    for item in set {
        for subset in subsets {
            var sub = subset
            sub.insert(item)
            subsets.append(sub)
        }
    }
    
    return subsets
}

subsets(set: Set([1,2,3,4]))

func recursiveSubsets<T>(set: Set<T>, _ index: Int = 0) -> [Set<T>] {
    guard set.count != index else { return [Set()] }
    
    var subsets = recursiveSubsets(set: set, index + 1)
    let item = set[set.index(set.startIndex, offsetBy: index)]
    
    for subset in subsets {
        var sub = subset
        sub.insert(item)
        subsets.append(sub)
    }

    return subsets
}

recursiveSubsets(set: Set([1,2,3]))


// since each element in a set we follow power of 2 subsets and each sate can be represented as yes incurded in set (1) or no not incuded in set (0) we can use binary, but this solution isn't necessarily better than the first iterative solution

func combinatoric<T>(set: Set<T>) -> [Set<T>]{
    var subsets: [Set<T>] = []
    let max = 1 << set.count // compute total number of subsets (2^n)
    for k in 0..<max {
        let subset = add(k, to: set)
        print(subset)
        subsets.append(subset)
    }
    return subsets
}

private func add<T>(_ k: Int, to set: Set<T>) -> Set<T> {
    var subset = Set<T>()
    var index = 0
    var k = k

    while k > 0 {
        if k & 1 == 1 { // k is odd 1,3,5,7
            // insert element at index to create all possible combinations
            subset.insert(set[set.index(set.startIndex, offsetBy: index)])
        }
        index += 1
        k >>= 1 // subtract k by power of 2
    }
    return subset
}

combinatoric(set: Set([1,2,3]))

//: [Next](@next)
