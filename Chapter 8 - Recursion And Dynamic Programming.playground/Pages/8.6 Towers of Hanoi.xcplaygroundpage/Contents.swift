//: [Previous](@previous)

import Foundation

//: ### In the classic problem of the Towers of Hanoi, you have 3 towers and N disks of different sizes which can slide onto any tower. The puzzle starts with disks sorted in ascending order of size from top to bottom (i.e., each disk sits on top of an even larger one). You have the following constraints:

// - 1) Only one disck can be moved at a time.
// - 2) A disk is slid off the top of one tower onto another tower.
// - 3) A disk cannot be placed on top of a smaller disk.

// Write a program to move the disks from the first tower to the last using Stacks.

var tower1 = Stack<Int>([1,2,3,4,5,6])
var tower2 = Stack<Int>()
var tower3 = Stack<Int>()

func moveDisks(from a: Stack<Int>, temp b: Stack<Int>, to c: Stack<Int>, count: Int? = nil) {
    let count = count ?? a.count
    if count == 0 { return }
    if count == 1 { return c.push(a.pop())}
    
    moveDisks(from: a, temp: c, to: b, count: count - 1)
    moveDisks(from: a, temp: b, to: c, count: 1)
    moveDisks(from: b, temp: a, to: c, count: count - 1)
}

print("start: ", tower1, tower2, tower3)
moveDisks(from: tower1, temp: tower2, to: tower3)
print("finish: ", tower1, tower2, tower3)



// Below is discovery...

func moveOne(from a: Stack<Int>, to b: Stack<Int>){
    let disk = a.pop()
    b.push(disk)
}

func moveTwo(from a: Stack<Int>, temp: Stack<Int>, to final: Stack<Int>){
    temp.push(a.pop())
    final.push(a.pop())
    final.push(temp.pop())
}

// We really only need moveOne and moveTwo

func moveThree(from a: Stack<Int>, temp: Stack<Int>, to final: Stack<Int>){
    moveTwo(from: a, temp: final, to: temp)
    moveOne(from: a, to: final)
    moveTwo(from: temp, temp: a, to: final)
}

func moveFour(from a: Stack<Int>, temp: Stack<Int>, to final: Stack<Int>){
    moveThree(from: a, temp: final, to: temp)
    moveOne(from: a, to: final)
    moveThree(from: temp, temp: a, to: final)
}

// See how 1 and 2 are base cases and any count above uses count-1 and moveOne
//tower1.push(1)
//print(tower1, tower2, tower3)
//moveOne(from: tower1, to: tower3)
//print(tower1, tower2, tower3)

//tower1.push(2)
//tower1.push(1)
//print(tower1, tower2, tower3)
//moveTwo(from: tower1, temp: tower2, to: tower3)
//print(tower1, tower2, tower3)

//tower1.push(3)
//tower1.push(2)
//tower1.push(1)
//print(tower1, tower2, tower3)
//moveThree(from: tower1, temp: tower2, to: tower3)
//print(tower1, tower2, tower3)

//tower1.push(4)
//tower1.push(3)
//tower1.push(2)
//tower1.push(1)
//print(tower1, tower2, tower3)
//moveThree(from: tower1, temp: tower3, to: tower2)
//moveOne(from: tower1, to: tower3)
//moveThree(from: tower2, temp: tower1, to: tower3)
//print(tower1, tower2, tower3)

//tower1.push(5)
//tower1.push(4)
//tower1.push(3)
//tower1.push(2)
//tower1.push(1)
//print(tower1, tower2, tower3)
//moveFour(from: tower1, temp: tower3, to: tower2)
//moveOne(from: tower1, to: tower3)
//moveFour(from: tower2, temp: tower1, to: tower3)
//print(tower1, tower2, tower3)
//tower1.push(3)


func hanoi(towerA a: Stack<Int>, towerB b: Stack<Int>, towerC c: Stack<Int>, count: Int? = nil) {
    let count = count ?? a.count
    if count == 0 { return }
    if count == 1 { return moveOne(from: a, to: c)}
    if count == 2 { return moveTwo(from: a, temp: b, to: c) }

    // notice tower letters change like moveThree or moveFour
    // first move n-1 to b, move last to c, then move all from b to c
    hanoi(towerA: a, towerB: c, towerC: b, count: count - 1)
    hanoi(towerA: a, towerB: b, towerC: c, count: 1)
    hanoi(towerA: b, towerB: a, towerC: c, count: count - 1)
}
//print(tower1, tower2, tower3)
//hanoi(towerA: tower1, towerB: tower2, towerC: tower3)
//print(tower1, tower2, tower3)


// We don't need 2 as a base case since we are already arranging them
func hanoiAlt(towerA a: Stack<Int>, towerB b: Stack<Int>, towerC c: Stack<Int>, count: Int? = nil) {
    let count = count ?? a.count
    if count == 0 { return }
    if count == 1 { return moveOne(from: a, to: c)}
    
    // notice tower letters change like moveThree or moveFour
    // first move n-1 to b, move last to c, then move all from b to c
    hanoiAlt(towerA: a, towerB: c, towerC: b, count: count - 1)
    hanoiAlt(towerA: a, towerB: b, towerC: c, count: 1)
    hanoiAlt(towerA: b, towerB: a, towerC: c, count: count - 1)
}

//print(tower1, tower2, tower3)
//hanoiAlt(towerA: tower1, towerB: tower2, towerC: tower3)
//print(tower1, tower2, tower3)

class Stack<T>: CustomDebugStringConvertible {
    var debugDescription: String {
        if stack.isEmpty { return "(_)"}
        return "(\(stack.reduce(into: "", { a, b in a.append("\(b)")})))"
    }
    
    private var stack = [T]()
    
    var count: Int {
        stack.count
    }
    
    init(){}
    
    convenience init(_ arrayLiteral: [T]) {
        self.init()
        stack = arrayLiteral
    }
        
    func push(_ item: T){
        stack.append(item)
    }
    
    func pop() -> T{
        return stack.removeLast()
    }
    
    func peek() -> T? {
        if let item = stack.last { return item }
        return nil
    }
}

//: [Next](@next)
