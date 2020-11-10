//: [Previous](@previous)

import Foundation

//: ### Given an infinite number of quarters (25 cents), dimes (10 cents), nickels (5 cents), and pennies (1 cent), write code to calculate the number of ways of representing n cents.

// https://www.youtube.com/watch?v=sn0DWI-JdNA


func makeChange(for totalCents: Int) -> Int {
    // sort large to small for more optimized solution
    var map = [String: Int]()
    return makeChangeHelper(totalCents, [25, 10, 5, 1], 0, &map)
}

func makeChangeHelper(_ total: Int, _ coins: [Int], _ index: Int, _ memo: inout [String: Int]) -> Int {
    if total == 0 { return 1 } // order matters, this should be first
    if index >= coins.count { return 0 }
    
    var amount = total
    let coin = coins[index]
    let key = "\(total)-\(coin)"
    var numberOfWays = 0
    
    if let result = memo[key] { return result }
    
    while amount >= 0 {
        numberOfWays += makeChangeHelper(amount, coins, index + 1, &memo)
        amount -= coin
    }
    
    memo[key] = numberOfWays
    return numberOfWays
}

makeChange(for: 10)

// Book solution without memoization:

func makeChangeBook(for totalCents: Int) -> Int {
    return makeChangeHelperBook(totalCents, [1, 5, 10, 25], 0)
}

func makeChangeHelperBook(_ total: Int, _ denoms: [Int], _ index: Int) -> Int {
    guard index < denoms.count else { return 0 }
    
    let coin = denoms[index]
    
    if index == denoms.count - 1 {
        let remainder = total % coin
        return remainder == 0 ?  1 : 0
    }
    
    var numberOfWays = 0
    
    for amount in stride(from: 0, through: total, by: coin) {
        numberOfWays += makeChangeHelperBook(total - amount, denoms, index + 1)
    }
    
    return numberOfWays
}

makeChangeBook(for: 10)


//: [Next](@next)
