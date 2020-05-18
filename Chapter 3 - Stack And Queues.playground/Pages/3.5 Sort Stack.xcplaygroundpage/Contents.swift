//: [Previous](@previous)

import Foundation

//: ### Write a program to sort a stack such that the smallest items are on the top. You can use an additional temp stack, but you may not copy the elements into any other data structure (such as an array). The stack supports the following operations: push, pop, peek and isEmpty.


//: Use temp stack to hold in reverse largest to smallest and compare each node in sort func, then convert temp back to stack so that smallest will be on top. This is O(N) space and O(N) time to sort and then again to swap. This approach uses sort() and swap()

//: betterSort() keeps stack sorted as much as possible. It only removes larger items onto the temp stack and then puts them back. Unless the item pushed is smaller than everything this sound be faster in time and hold less space

struct SortedStack<T: Comparable> {
    private var temp = [T]()
    private var stack = [T]()
    
    var isEmpty: Bool {
        stack.isEmpty
    }
    
    func peek() -> T? {
        return stack.last
    }
    
    mutating func push(_ item: T){
        guard let smallest = peek(), item > smallest else {
            stack.append(item)
            return
        }
        betterSort(item)
//        sort(item)
//        swap()
        print(stack)
    }
    
    mutating func pop() -> T? {
        guard !stack.isEmpty else { return nil }
        return stack.removeLast()
    }
    
    private mutating func betterSort(_ item: T) {
        while let current = peek() {
            if current < item {
                temp.append(stack.removeLast())
            }else {
                break
            }
        }
        stack.append(item)
        
        while !temp.isEmpty {
            stack.append(temp.removeLast())
        }
        
    }
    
//    private mutating func sort(_ item: T) {
//        var wasInserted = false
//        while !stack.isEmpty {
//            let current = stack.removeLast()
//            if  current < item || wasInserted {
//                temp.append(current)
//            }else {
//                wasInserted = true
//                temp.append(item)
//            }
//        }
//        if !wasInserted {
//            temp.append(item)
//        }
//    }
//
//    private mutating func swap(){
//        while !temp.isEmpty {
//            let item = temp.removeLast()
//            stack.append(item)
//        }
//    }
    
}

var stack = SortedStack<Int>()
stack.push(9)
stack.push(8)
stack.push(5)
stack.push(10)
stack.push(1)
stack.push(2)
stack.push(0)
stack.push(3)

//: [Next](@next)
