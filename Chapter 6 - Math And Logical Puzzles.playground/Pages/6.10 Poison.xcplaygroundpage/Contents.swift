//: [Previous](@previous)

import Foundation

//: ### You have 1000 bottles of soda, and exactly one is poisoned. You have 10 test strips which can be used to detect poison. A single drop of poison will turn the test strip positive permanentaly. You can put any number of drops on a test strip at once and you can reuse a test strip as many times as you'd like (as long as the results are negative). However, you can only run tests once per day and it takes seven days to return a result. How would you figure out the poisoned bottle in as few days as possible? Follow up: Write code to simulate your approach.

/*:
 Simple solution: - 28 days
 
 - split 1000 bottles into 100 bottles and test each group on 1 strip (uses 10 strips)
 - wait 7 days for results, one strip will be negative and 9 will be reusable
 - find negative group, split 100 into 9 strips (8 will hold 11 and 1 will hold 12)
 - wait 7 days for results, one strip will be negative and 8 will be reusable
 - find negative group, split 12(or 11) into 8 strips (6 will hold 2)
 - wait 7 days for results, one strip will be negative and 7 will be reusable
 - find negative group and test individual bottles (uses 2 strips)
 - wait 7 days and you'll have the results in 28 days total
 
 * A bottlenecks here is waiting 7 days for results before running more tests
 
 Better solution: - 10 days
 
 - use all 10 strips to determine different digits XXX from 000-999
   the first day we will create a group of 100 that hold 0-99, 100-199, 200-299 etc...
   the second day we'll create another group of 100 holding (000-009, 100-109, 200-209) etc...
   the third day create a group of 100 holding (000,100, 110, 120, 130...,200,210,220...)
 
   we need a fourth day of testing with an offset becasue once a test is negative it will always be negative. Suppose day 7 results a positive strip 3, day 8 results new positive strip 8, day 9 results no new positve strips. We don't know if the last digit is a 3 or an 8 since these strips were always determined to be positive on the previous days. The offset will help to determine the correct last digit.
 
   bottle 898 may still result in no new results for day 9 or 10 since the offset is off by one, but 899 would have a new positive result on day 10 for strip 0 and thus we can conclude 898 is the correct bottle.
 
 
        hundreths       tens        ones        offset
strip | day 0 - 7 | day 1 - 8 | day 2 - 9 | day 3 - 10
  0         0xx         x0x         xx0         xx9
  1         1xx         x1x         xx1         xx0
  2         2xx         x2x         xx2         xx1
  3         3xx         x3x         xx3         xx2
  4         4xx         x4x         xx4         xx3
  5         5xx         x5x         xx5         xx4
  6         6xx         x6x         xx6         xx5
  7         7xx         x7x         xx7         xx6
  8         8xx         x8x         xx8         xx7
  9         9xx         x9x         xx9         xx8
 

 Optimal solution: 7 days
 
 - Instead of thinking is base ten can we use binary?
    Yes. 2^10 is 1024, 1024 unique mappings
    10 strips can be used for 1024 bottles
 - Convert bottle numbers to binary and if there is a "1" in the ith digit, group that to add a drop to strip i.
 - wait 7 days and read which bottle numbers are positve to get the binary positions for the poisoned bottle
 
 strip |
   0      0000000001, 1111111111, 1111111101, 1111111001, 1000000001, 1011011101 etc...
   1      0000000010, 1111111110
   2
   3
   4
   5
   6
   7
   8
   9
 
 **/

struct Bottle {
    let poisoned: Bool
    let id: Int
    
    init(poisoned: Bool = false, id: Int){
        self.poisoned = poisoned
        self.id = id
    }
}

struct TestStrip {
    let DAYS_FOR_RESULT = 7
    let id: Int
    var dropsByDay = [[Bottle]]()
    
    mutating func addDrop(on day:Int, _ bottle: Bottle) {
        if !dropsByDay.indices.contains(day) {
            dropsByDay.append([bottle])
        }else {
            dropsByDay[day].append(bottle)
        }
    }
    
    func hasPoison(_ bottles: [Bottle]) -> Bool {
        for bottle in bottles {
            if bottle.poisoned { return true }
        }
        return false
    }
    
    func getLastWeekBottles(for day: Int) -> [Bottle]? {
        if day < DAYS_FOR_RESULT { return nil }
        return dropsByDay[day - DAYS_FOR_RESULT]
    }
    
    func isPositive(on day: Int) -> Bool {
        let testDay = day - DAYS_FOR_RESULT
        
        if testDay < 0 || testDay >= dropsByDay.count { return false }
        for i in 0...testDay {
            if hasPoison(dropsByDay[i]) { return true }
        }
        
        return false
    }
}

func findPoisonedBottle(_ bottles: [Bottle], _ testStrips: [TestStrip]) -> Int {
    var testStrips = testStrips
    runTests(bottles, &testStrips)
    let positiveStrips = getPositive(day: 7, testStrips)
    return setBits(with: positiveStrips)
}

// Add bottle to strip based on binary positions of any 1's
func runTests(_ bottles: [Bottle], _ testStrips: inout [TestStrip]){
    for bottle in bottles {
        var id = bottle.id
        var bitIndex = 0 // test strip number
        while id > 0 {
            if (id & 1) == 1 {
                testStrips[bitIndex].addDrop(on: 0, bottle)
            }
            bitIndex += 1
            id >>= 1
        }
    }

}

// Get test strips positive on a particular day
func getPositive(day: Int, _ testStrips: [TestStrip]) -> [Int] {
    var positive = [Int]()
    for strip in testStrips {
        if strip.isPositive(on: day){
            positive.append(strip.id)
        }
    }
    
    return positive
}

// Create positve bottle number by setting bits with indices specificed in positive strip id
func setBits(with positiveList: [Int]) -> Int {
    var id = 0
    for bitIndex in positiveList {
        id |= 1 << bitIndex
    }
    
    return id
}


var bottles = [Bottle]()
let randomPoisonedBottleIndex = Int.random(in: 0..<100)
for i in 0..<100 {
    bottles.append(Bottle(poisoned: randomPoisonedBottleIndex == i, id: i))
}

var testStrips = [TestStrip]()

for i in 0..<10 {
    testStrips.append(TestStrip(id: i))
}

let poisonedBottle = findPoisonedBottle(bottles, testStrips)
poisonedBottle == randomPoisonedBottleIndex

//: [Next](@next)
