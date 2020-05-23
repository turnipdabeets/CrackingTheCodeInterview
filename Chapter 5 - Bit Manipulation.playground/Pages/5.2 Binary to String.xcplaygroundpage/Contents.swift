//: [Previous](@previous)

import Foundation

//: ### Given a real number between 0 and 1 (e.g 0.72) that is passed in as a double, print the binary representation. If the number cannot be represented accurately in binary with at most 32 characters, print ERROR

// https://www.youtube.com/watch?v=3FA8yQ0cZyE

func fractionalBinaryToString(_ num: Double) -> String? {
    guard num < 1 || num > 0 else { return nil }

    var num = num
    var result = "."
    
    while num > 0 {
        if result.count >= 32 { return nil }
        let double = num * 2
        
        if double >= 1 {
            result.append("1")
            num = double - 1
        }else {
            result.append("0")
            num = double
        }
    }

    return result
}

func fractionalBinaryToStringAlt(_ num: Double) -> String? {
    guard num < 1 || num > 0 else { return nil }
    
    var num = num
    var result = "."
    var fraction = 0.5
    
    while num > 0 {
        if result.count >= 32 { return nil }

        if num >= fraction {
            result.append("1")
            num -= fraction
        }else {
            result.append("0")
        }
        
        fraction /= 2
    }
    
    return result
}

fractionalBinaryToString(0.8125)
fractionalBinaryToStringAlt(0.8125)

//: [Next](@next)
