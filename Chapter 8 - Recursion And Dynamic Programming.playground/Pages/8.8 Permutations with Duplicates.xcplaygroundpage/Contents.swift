//: [Previous](@previous)

import Foundation

//: ### Write a method to compute all permutations of a string whose characters are not necessarily unique. The list of permutations should not have dupicates.

// The problem with using the function written in 8.7 is that we will get duplicate permutations. We could simply addd a check to make sure the permutation doesn't exisit before adding it, but that would make strings like "aaaaaaaaaaaaaa" take a really long time, when infact there is only 1 permutation.

// still O(n!) but this helps in certain cases where the number of repeated characters is linear and not factorial

func getPermutations(_ string: String) -> [String] {
    var frequency = string.reduce(into: [String:Int](), {freq, char in
        freq[String(char), default: 0] += 1
    })
    var result = [String]()
    
    getPermutations(map: &frequency, prefix: "", remaining: string.count, result: &result)
    
    return result
}

private func getPermutations(map: inout [String:Int], prefix: String, remaining: Int, result: inout [String]){
    print(prefix, remaining)
    guard remaining > 0 else { return result.append(prefix) }
    
    for (char, count) in map {
        if count > 0 {
            map[char] = count - 1
            getPermutations(map: &map, prefix: prefix + char, remaining: remaining - 1, result: &result)
            map[char] = count
        }
    }
}

getPermutations("aba")


//: [Next](@next)
