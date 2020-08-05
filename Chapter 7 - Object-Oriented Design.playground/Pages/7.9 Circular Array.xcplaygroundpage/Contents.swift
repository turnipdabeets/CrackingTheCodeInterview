//: [Previous](@previous)

import Foundation

//: ### Implement a CircularArray class that supports an array-like data structure which can be efficiently rotated. If possible, the class should use a generic type (also called a template), and should support iteration via the standard for (Obj o : circularArray) notation.


final class CircularArray<T>: Sequence {
    private(set) var items: [T]
    private var head = 0
    private var size: Int {
        items.count
    }
    
    init(items: [T]){
        self.items = items
    }
    
    func makeIterator() -> CircularArrayIterator<T> {
        return CircularArrayIterator<T>(self)
    }
    
    private var nextIndex: Int {
        return convert(1)
    }
    
    private func convert(_ i: Int) -> Int {
        // assume possitive number
        return (head + i) % size
    }
    
    func add(_ item: T){
        items.insert(item, at: nextIndex)
    }
    
    func current() -> T{
        return items[head]
    }
    
    func remove(){
        items.remove(at: head)
    }
    
    func rotate() -> T {
        head = nextIndex
        return items[head]
    }
    
    func rotate(by i: Int) -> T {
        head = convert(i)
        return items[head]
    }
    
}

extension CircularArray: ExpressibleByArrayLiteral {
    convenience init(arrayLiteral elements: T...) {
        self.init(items: elements)
    }
}

struct CircularArrayIterator<T>: IteratorProtocol {
    let circularArray: CircularArray<T>
    var count = 0

    init(_ circularArray: CircularArray<T>){
        self.circularArray = circularArray
    }

    mutating func next() -> T? {
        while count < circularArray.items.count {
            count += 1
            let next = circularArray.current()
            circularArray.rotate()
            return next
        }
        return nil
    }
}

let c1: CircularArray = [4,5,6,7]
let c = CircularArray(items: [0,1,2,3])
c.rotate()
c.rotate()
c.rotate()

for a in c {
    print(a)
}


c.rotate()
c.rotate()
c.rotate()
c.rotate()
c.rotate()
c.rotate()
c.rotate()
c.rotate(by: 1)
c.rotate(by: 1)
c.rotate(by: 1)
c.add(6)
c.rotate(by: 1)
c.rotate()
c.rotate()
c.rotate()
c.rotate()
c.rotate()
c.rotate()
c.remove()
c.rotate()
c.rotate()
c.rotate()
c.rotate()
//: [Next](@next)
