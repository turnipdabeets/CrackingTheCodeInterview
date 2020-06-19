//: [Previous](@previous)

import Foundation

//: ### There are 100 closed lockers in a hallway. A man begins by opening all 100 lockers. Next, he closes every second lockers. Then, on his third pass, he toggles every third locker (closes it if it is open or opens it if it is closed). This process continues for 100 passes, such that on each pass i, the man toggles every ith locker. After his 100th pass in the hallway, in which he toggles only locker #100, how many lockers are open?

/*:
    A door n is toggled for every factor  of n, including itself and 1.
    - door 15 is toggled on 1,3,5, and 15
 
    A door is left open if the number of factors is odd
 
    We get odd factors from values that are a perfect square
    - door 36 has 9 factors : (1, 36) (2, 18) (3, 12) (4, 9) (6, 6) where 6 only contributes 1 factor
 
    How many perfect squares at in 1-100?
    - 10 (1, 4, 9, 16, 25, 36, 49, 64, 81, 100)
    - or 1*1, 2*2, 3*3, 4*4 ... 10*10
 **/

func openLockers() -> Int {
    var lockers = Array(repeating: true, count: 100)
    
    // toggle 2 - 100
    for i in 1..<lockers.count {
        for locker in stride(from: i, to: lockers.count, by: i+1) {
            lockers[locker] = !lockers[locker]
        }
    }
    return lockers.filter { $0 }.count
}

func openLockersPerfectSquares() -> Int {
    var count = 1
    
    while count * count <= 100 {
        count += 1
    }
    return count - 1
}

openLockersPerfectSquares()
openLockers()


//: [Next](@next)
