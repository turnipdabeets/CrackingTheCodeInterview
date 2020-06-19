//: [Previous](@previous)

import Foundation

//: ### You have 20 bottles of pills. 19 bottles have 1.0 gram pills, but one has pills of weight 1.1 grams. Given a scale that provides an exact measurement, how would you find the heavy bottle? You can only use the scale once.

//: Since we can only use the scale once then we know we need to use 19 or all bottles otherwise we couldn't tell the difference bwteen the bottles. We can use a different number of pills to distinguish between the bottles. The key is the extra .1 grams.

//If we use 1 pill for bottle 1, 2 for bottle 2 etc... we would get 210

func getHeavierBottle(_ bottles: [Double], weight: Double, heavierWeight: Double) -> Double {
    var count: Double = 0
    for bottle in 1...bottles.count {
        count += Double(bottle) * weight
    }
    
    let totalWeight = bottles.reduce(0, +)
    
    return round((totalWeight - count) / (heavierWeight - weight))
}
let bottles = [1,2,3,4,5,6,7,8,9,10,11,12,14.3,14,15,16,17,18,19,20]

// bottle 13 has the heavier pills, 13 * 1.1 = 14.3
getHeavierBottle(bottles, weight: 1.0, heavierWeight: 1.1)


// test bottles with 10th heavier
//let bottles = [1,2,3,4,5,6,7,8,9,11,11,12,13.0,14,15,16,17,18,19,20]

