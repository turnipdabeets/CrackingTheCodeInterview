//: [Previous](@previous)

import Foundation

//: ### Design a stack which in addition to push and pop has a function min which returns the minimum element. Push, pop and min should all operation in O(1) time.

//: Use another stack for mins, only add on push if new item is smaller, remove on pop if poping the same value

struct Stack<T: Comparable> {
    private var items: [T] = []
    private var mins: [T] = []
    
    var min: T? {
        return mins.last
    }
    
    var peek: T? {
        return items.last
    }
    
    mutating func push(_ item: T){
        items.append(item)
        
        if mins.isEmpty {
            mins.append(item)
        }else if let min = mins.last, item < min {
            mins.append(item)
        }

    }
    
    mutating func pop() -> T? {
       let item = items.removeLast()
    
       if item == min {
         mins.removeLast()
       }
       return item
    }
}

var stack = Stack<Int>()
stack.push(5)
stack.push(6)
stack.push(3)
stack.push(7)
stack.pop()
stack.min
stack.pop()
stack.min

//: [Next](@next)
