//: [Previous](@previous)

import Foundation

//: ### There is a building of 100 floors. If an egg drops from the Nth floor or above, it will break. If it's dropped from any floor below, it will not break. You're given two eggs. Find N, while minimizing the number of drops for the worst case.

/*:
 
 Consider binary search which is at worst O(log n). However the problem is if the egg breaks at floor 50, we dont want to risk trying floor 25 because this is our last egg. So we'll need to start at floor 1 and move up. At worst this will take 50 drops. So we need to be linear.
 
 If we take 100 / a number we'll get potential number of drops up to the last point where we need to become iterative with egg 2. This will give us the worst case total
 
 example: number 10
 
 100 / 10 = 10,
 if we need floor 99 for worse case we will get 10 drops on egg one plus 91-99 for egg two which will be 19 total drops
 
 example: number 20
 
 100 / 20 = 5,
 5 drops + 81-99 = 24 total drops
 
 example: number 5
 
 100 / 5 = 20 (too big)
 
 - What if our increments were not constant?
 - What if we considered "load balance" where (dropping egg1) + (dropping egg2) is the same no matter where egg1 breaks or where the breaking point is.
 
 To balance that, each time egg1 drops we need egg2 to drop 1 less times. If we start egg1 on floor X it needs to move up X - 1, then X - 2 ...until we get to floor 100
 
 X + (X - 1) + (X - 2) + (X - 3)+ ... + 1 = 100
 (X(X + 1))/2 = 100
            X = 13.65
 
 round up and max total drops is no more than 14
**/


// Below simulates dropping both eggs

let breakingPointFloor = 99
var countDrops = 0

func drop( _ floor: Int) -> Bool {
   countDrops += 1
   return floor >= breakingPointFloor
}

func findBreakingPoint(_ totalFloors:Int) -> Int{
    var interval = 14
    var previousFloor = 0
    var egg1 = interval
    
    while !drop(egg1) && egg1 <= totalFloors {
        interval -= 1
        previousFloor = egg1
        egg1 += interval
    }
    
    var egg2 = previousFloor + 1
    
    while egg2 < egg1 && egg2 <= totalFloors && !drop(egg2){
        egg2 += 1
    }
    
    return egg2
}

findBreakingPoint(100)
countDrops

//: [Next](@next)
