import Foundation

public struct Stack<T> { 
    private var stack: [T] = []
    
    public var isEmpty: Bool {
        return stack.isEmpty
    }
    
    public var peek: T? {
        return stack.last
    }
    
    public init(){}
    
    public mutating func push(_ item: T) {
        stack.append(item)
    }
    
    public mutating func pop() -> T?{
        return stack.removeLast()
    }
}
