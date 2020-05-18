//: [Previous](@previous)

import Foundation

//: ### Implement a MyQueue class which implements a queue using two stacks.

//: pop off one stack and add to another will flip from LIFO to FIFO. Since this is O(N) time only convert between stacks when asking to add, remove or peek. There may be multiple pops or adds


struct MyQueue<T> {
    private var LIFO: [T] = []
    private var FIFO: [T] = []
    
    var isEmpty: Bool {
        return LIFO.isEmpty && FIFO.isEmpty
    }
    
    mutating func add(_ item: T){
        covertToLIFO()
        LIFO.append(item)
    }
    
    mutating func remove() -> T? {
        convertToFIFO()
        guard !FIFO.isEmpty else { return nil }
        return FIFO.removeLast()
    }
    
    mutating func peek() -> T? {
        convertToFIFO()
        return FIFO.last
    }
    
    private mutating func convertToFIFO(){
        while !LIFO.isEmpty {
            let item = LIFO.removeLast()
            FIFO.append(item)
        }
    }
    
    private mutating func covertToLIFO(){
        while !FIFO.isEmpty {
            let item = FIFO.removeLast()
            LIFO.append(item)
        }
    }
}

var queue = MyQueue<Int>()
queue.isEmpty
queue.add(1)
queue.add(2)
queue.add(3)
queue.remove()
queue.remove()
queue.add(4)
queue.isEmpty
queue.remove()
queue.peek()
queue.remove()
queue.remove()
queue.isEmpty
//: [Next](@next)
