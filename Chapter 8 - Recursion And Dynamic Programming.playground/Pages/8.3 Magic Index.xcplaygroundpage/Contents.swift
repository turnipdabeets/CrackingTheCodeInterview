//: [Previous](@previous)

import Foundation

//: ### A magic index in an array [1...n-1] is defined to ba an index such that [i] = i. Given a sorted array of distinct integers, write a method to find a magic index, if one exists, in the array. - Follow up: What if the values are not distinct?

/// Not Distinct Values
func magicIndexNotDistinct(_ array: [Int]) -> Int? {
    return magicIndexAlt(array, start: 0, end: array.count - 1)
}

func magicIndexAlt(_ array: [Int], start: Int = 0, end: Int) -> Int? {
    guard start <= end else { return nil }
    
    let middle = (start + end) / 2
    let midValue = array[middle]
    
    if midValue == middle { return middle }
    
    let left = magicIndexAlt(array, start: start, end: min(middle - 1, midValue))
    let right = magicIndexAlt(array, start: max(middle + 1, midValue), end: end)
    
    return left ?? right
}

magicIndexNotDistinct([-10, -5, 2,2,2,3,4,5,9,12,13])

/// Distinct Values

func magicIndexDistinct(_ array: [Int]) -> Int? {
    return magicIndex(array, start: 0, end: array.count - 1)
}

func magicIndex(_ array: [Int], start: Int = 0, end: Int) -> Int? {
    guard start <= end else { return nil }
    
    let middle = start + end / 2
    // in this case the 2nd option isn't correct?
    print(middle, end + ((start - end) / 2), (end - start) / 2)
    
    if array[middle] == middle { return middle }
    
    if array[middle] < middle {
        return magicIndex(array, start: middle + 1, end: end)
    }else {
        return magicIndex(array, start: start, end: middle - 1)
    }
}

magicIndexDistinct([-1,0,1,2,3,4,5,7])

//: [Next](@next)
