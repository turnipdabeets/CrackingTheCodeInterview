//: [Previous](@previous)

import Foundation

//: ### Animal shelters which holds only dogs and cats operate on a strictly FIFO basis. People must adopt either the oldest animal, based on arrival time, of all animals in the shelter or they can select whether they would prefer a dog or cat (and will receive the oldest of that type). They cannot select which animal they would like. Create a data structure to maintain this system and implement operations such as enqueue, dequeueDog, dequeueCat. You may use built in LinkedList data structure.

//: Use two queues for dog and cat and when we call dequeueAny compare dog vs cat date. Use internal type to attach date to the Animal instance.

//: Swift removeFirst() is an O(N) operation, so we could use a LinkedList to removeFirst and insert with O(1) by using a 2 pointers, one at the head and another at the tail.

enum AnimalType { case dog, cat }

class Animal {
    let type: AnimalType
    
    init(type: AnimalType) {
        self.type = type
    }
}

struct Shelter {
    private struct InternalAnimal {
        let animal: Animal
        let date: Date
    }
    
    private var dogQueue = [InternalAnimal]()
    private var catQueue = [InternalAnimal]()
    
    mutating func enqueue(_ animal: Animal) {
        let internalAnimal = InternalAnimal(animal: animal, date: Date())
        switch animal.type {
        case .dog:
            dogQueue.append(internalAnimal)
        case .cat:
            catQueue.append(internalAnimal)
        }
    }
    
    mutating func dequeueAny() -> Animal? {
        if dogQueue.isEmpty {
            return dequeueCat()
        }else if catQueue.isEmpty {
            return dequeueDog()
        }else if let firstCat = catQueue.first,
                    let firstDog = dogQueue.first {
            if firstCat.date < firstDog.date {
                return dequeueCat()
            }else{
                return dequeueDog()
            }
        }
        return nil
    }

    mutating func dequeueCat() -> Animal? {
        guard !catQueue.isEmpty else { return nil }
        return catQueue.removeFirst().animal
    }
    
    mutating func dequeueDog() -> Animal? {
        guard !dogQueue.isEmpty else { return nil }
        return dogQueue.removeFirst().animal
    }
}

//: Use LinkedList for O(1) append() and removeFirst() operations
struct LinkedList<T> {
    private var head: ListNode<T>?
    private var tail: ListNode<T>?
    
    var isEmpty: Bool {
        return head == nil && tail == nil
    }
    
    var first: T? {
        return head?.val
    }
    
    init(){}
    
    mutating func append(_ item: T){
        let node = ListNode(item)
        if let tail = tail {
            tail.next = node
        }else {
            head = node
        }
        tail = node
    }
    
    mutating func removeFirst() -> T? {
        guard let _ = head else { return nil }
            let item = head!.val
        if tail === head {
            head = nil
            tail = nil
        }else {
            head = head!.next
        }
        
        return item
    }
}

struct Shelter2 {
    struct InternalAnimal {
        let animal: Animal
        let date: Date
    }
    
    private var dogQueue = LinkedList<InternalAnimal>()
    var catQueue = LinkedList<InternalAnimal>()
    
    mutating func enqueue(_ animal: Animal) {
        let internalAnimal = InternalAnimal(animal: animal, date: Date())
        switch animal.type {
        case .dog:
            dogQueue.append(internalAnimal)
        case .cat:
            catQueue.append(internalAnimal)
        }
    }
    
    mutating func dequeueAny() -> Animal? {
        if dogQueue.isEmpty {
            return dequeueCat()
        }else if catQueue.isEmpty {
            return dequeueDog()
        }else if let firstCat = catQueue.first,
                    let firstDog = dogQueue.first {
            if firstCat.date < firstDog.date {
                return dequeueCat()
            }else{
                return dequeueDog()
            }
        }
        return nil
    }

    mutating func dequeueCat() -> Animal? {
        guard !catQueue.isEmpty else { return nil }
        return catQueue.removeFirst()?.animal
    }
    
    mutating func dequeueDog() -> Animal? {
        guard !dogQueue.isEmpty else { return nil }
        return dogQueue.removeFirst()?.animal
    }
}

// swap Shelter2 for Shelter and should have the same results
let cat = Animal(type: .cat)
let cat2 = Animal(type: .cat)
let cat3 = Animal(type: .cat)
var shelter = Shelter2()
shelter.enqueue(cat)
shelter.dequeueCat() === cat
shelter.dequeueDog()
shelter.enqueue(cat2)
shelter.enqueue(cat3)
shelter.dequeueCat() === cat2
shelter.dequeueAny() === cat3



//: [Next](@next)
