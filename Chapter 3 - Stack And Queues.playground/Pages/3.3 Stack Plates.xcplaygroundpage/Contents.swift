//: [Previous](@previous)

import Foundation

//: ### Implement a data structure SetOfStacks that mimics a stack of plates (in real life we would start a new stack of plates when on stack gets too high). SetOfStack should be composed of several stacks and should create a new stack once the previous one exceeds capacity. SetOfStacks .push and .pop should behave identical to a single stack.

//: ### Follow Up: Implement a function popAt which performs a popAt operation on a specific sub-stack

struct SetOfStacks<T> {
    private let capacity: Int
    private var currentStack = 0
    private var stacks = [[T]]()
    
    private var hasFirstItem: Bool {
        return stacks.first != nil
    }
    
    init?(capacity: Int) {
        guard capacity >= 0 else { return nil }
        self.capacity = capacity
    }
    
    mutating func push(_ item: T) {
        guard hasFirstItem else {
            stacks.append([item])
            return
        }
        if stacks[currentStack].count == capacity {
            currentStack += 1
            stacks.append([])
        }
        stacks[currentStack].append(item)
    }
    
    mutating func pop() -> T? {
        guard hasFirstItem, currentStack - 1 >= 0 else { return nil }
        
        if stacks[currentStack].count == 0 {
            currentStack -= 1
        }

        return popAt(currentStack)
    }
    
    mutating func popAt(_ index: Int) -> T? {
        guard hasFirstItem,
                index >= 0,
                index < stacks.count,
                !stacks[index].isEmpty else { return nil }
        
        let stack = stacks[index]
        let item = stacks[index].removeLast()
        if stack.isEmpty {
            stacks.remove(at: index)
            currentStack = currentStack - 1 >= 0 ? currentStack - 1 : 0
        }
        return item
    }
    
    mutating func isEmpty() -> Bool {
        // Either shift everything down when popAt or pop 0 is empty and then only use first.isEmpty otherwise check all stacks for isEmpty
        
        guard let first = stacks.first else { return true }

        var empty = first.isEmpty
        
        for stack in 1..<stacks.count {
            if !stacks[stack].isEmpty { empty = false }
        }
        
        return empty
    }
    
    // still needs some work in case where multiple spaces missing in one stack and then to remove the last item if. Also need to implement logic for when to call leftShift, possibly keep track of number calls to popAt and if exceeds capacity for one stack then shiftLeft
    private mutating func leftShift(){
        // use some threshold, maybe if popAt is called number of times equal to one stack capacity
        guard hasFirstItem else { return }
        
        var index = 0
        var stack = 0
        var shouldRemoveLast = false
        
        while true {
            if index >= capacity {
                stack += 1
                index = 0
            }
            
            if stack >= stacks.count { break }
            print(stack, index, stacks[stack].count, capacity)
            if index + 1 < capacity {
                // move left
                shouldRemoveLast = true
                var nextStack = stack
                var nextIndex = index + 1

                if nextIndex >= stacks[stack].count - 1 {
                    nextStack += 1
                    nextIndex = 0
                }
                if nextStack >= stacks.count { break }

                let next = stacks[nextStack][nextIndex]
                stacks[stack].append(next)
                print(stacks)
            }
            index += 1
        }
        
        if shouldRemoveLast { stacks[stack - 1].removeLast() }
    }
}

var stack = SetOfStacks<Int>(capacity: 2)!
stack.push(1)
stack.push(2)
stack.push(3)
stack.popAt(0)
stack.isEmpty()
stack.pop()
stack.isEmpty()
stack.push(3)
stack.push(4)
stack.pop()
stack.pop()
stack.pop()
stack.pop()
stack.pop()
stack.pop()
stack.isEmpty()
stack.popAt(2)



//: [Next](@next)
