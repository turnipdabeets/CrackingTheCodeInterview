//: [Previous](@previous)

import Foundation

//: ### Implement three stacks in a single array

//: nils are used to keep order,

struct ThreeInOneStack<T> {
    enum Stack { case one, two, three }
    private(set) var trippleStack: [T?] = [nil, nil, nil]
    private var s1Head = 0
    private var s2Head = 1
    private var s3Head = 2
    
    mutating func pop(for stack: Stack) -> T?{
        switch stack {
        case .one:
            let item = trippleStack[s1Head]
            trippleStack[s1Head] = nil
            s1Head = s1Head - 3 > 0 ? s1Head - 3 : 0
            return item
        case .two:
            let item = trippleStack[s2Head]
            trippleStack[s2Head] = nil
            s2Head = s2Head - 3 > 0 ? s2Head - 3 : 1
            return item
        case .three:
            let item = trippleStack[s3Head]
            trippleStack[s3Head] = nil
            s3Head = s3Head - 3 > 0 ? s3Head - 3 : 2
            return item
        }
    }
    
    mutating func push(_ item: T, for stack: Stack){
       let count = trippleStack.count
        
        switch stack {
        case .one:
            if count - s1Head > 3 {
                trippleStack[s1Head + 3] = item
                return
            }else if trippleStack[s1Head] == nil {
                trippleStack[s1Head] = item
                return
            }
            switch count % 3 {
            case 0:
                trippleStack.append(item)
            case 1:
                trippleStack.append(nil)
                trippleStack.append(nil)
                trippleStack.append(item)
            case 2:
                trippleStack.append(nil)
                trippleStack.append(item)
            default:
                return
            }
            
            s1Head += 3
            
        case .two:
            if count - s2Head > 3 {
                trippleStack[s2Head + 3] = item
                return
            }else if trippleStack[s2Head] == nil {
                trippleStack[s2Head] = item
                return
            }
            
            switch count % 3 {
            case 0:
                trippleStack.append(nil)
                trippleStack.append(item)
            case 1:
                trippleStack.append(item)
            case 2:
                trippleStack.append(nil)
                trippleStack.append(nil)
                trippleStack.append(item)
            default:
                return
            }

            s2Head += 3
            
        case .three:
            if count - s3Head > 3 {
                trippleStack[s2Head + 3] = item
                return
            }else if trippleStack[s3Head] == nil {
                trippleStack[s3Head] = item
                return
            }
            switch count % 3 {
            case 0:
                trippleStack.append(nil)
                trippleStack.append(nil)
                trippleStack.append(item)
            case 1:
                trippleStack.append(nil)
                trippleStack.append(item)
            case 2:
                trippleStack.append(item)
            default:
                return
            }
            
            s3Head += 3
            
        }
    }
    
    func peek(for stack: Stack) -> T? {
        switch stack {
        case .one:
            return trippleStack[s1Head]
        case .two:
            return trippleStack[s2Head]
        case .three:
            return trippleStack[s3Head]
        }
    }
    
    func isEmpty(for stack: Stack) -> Bool{
        switch stack {
        case .one:
            return trippleStack[0] == nil
        case .two:
            return trippleStack[1] == nil
        case .three:
            return trippleStack[2] == nil
        }
    }
    
}

var stack = ThreeInOneStack<String>()
stack.push("A", for: .one)
print(stack.trippleStack)
stack.peek(for: .one)
stack.push("A", for: .one)
print(stack.trippleStack)
stack.push("B", for: .two)
print(stack.trippleStack)
stack.push("B", for: .two)
print(stack.trippleStack)
stack.push("C", for: .three)
print(stack.trippleStack)

stack.pop(for: .one)
print(stack.trippleStack)

stack.pop(for: .one)
print(stack.trippleStack)

stack.pop(for: .one)
print(stack.trippleStack)

stack.pop(for: .two)
print(stack.trippleStack)

stack.pop(for: .three)
print(stack.trippleStack)

stack.push("C", for: .three)
print(stack.trippleStack)


//: [Next](@next)
