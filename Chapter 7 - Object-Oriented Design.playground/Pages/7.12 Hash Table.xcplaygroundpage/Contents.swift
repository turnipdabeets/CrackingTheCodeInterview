//: [Previous](@previous)

import Foundation

//: ### Design and implement a hash table which uses chaining (linked lists) to handle collisions.
// https://nshipster.com/hashable/

//// Use Single LinkedList (book solution uses Doubly LinkedList):
struct HashTable<Key: Hashable, Value> {
    private typealias Element = (key: Key, value: Value)
    private typealias Bucket = LinkedList<Element>

    private var buckets: [Bucket]

    subscript(key: Key) -> Value? {
        get {
            return value(for: key)
        }
        set {
            if let value = newValue {
                update(value: value, for: key)
            }else {
                removeValue(for: key)
            }
        }
    }

    init(capacity: Int){
        assert(capacity > 0)
        buckets = Array<Bucket>(repeating: LinkedList<Element>(), count: capacity)
    }

    private func index(for key: Key) -> Int {
        return abs(key.hashValue) % buckets.count
    }

    mutating private func update(value: Value, for key: Key) -> Value? {
        let index = self.index(for: key)
        if buckets[index].head == nil {
            buckets[index].head = ListNode((key: key, value: value))
        }else {
            update(value: value, in: &buckets[index].head, for: key)
        }
        return value
    }

    private func update(value: Value, in list: inout ListNode<Element>?, for key: Key) {
        while (list?.val.key != key) && list?.next != nil && list?.next?.val.key != key {
            list = list?.next
        }
        if list?.val.key == key {
            list = ListNode((key: key, value: value))
        }else {
            list?.next = ListNode((key: key, value: value))
        }
    }

    mutating func removeValue(for key: Key) -> Value? {
        let index = self.index(for: key)
        removeValue(in: &buckets[index].head, for: key)
        return nil
    }

    private func removeValue(in list: inout ListNode<Element>?, for key: Key) {
        while (list?.val.key != key) && list != nil {
            list = list?.next
        }
        list = list?.next
    }

    func value(for key: Key) -> Value? {
        return findValue(in: buckets[index(for: key)].head, for: key)
    }

    private func findValue(in list: ListNode<Element>?, for key: Key) -> Value? {
        var list = list
        while (list?.val.key != key) && list != nil {
            list = list?.next
        }

        return list?.val.value
    }

}

var hashTable = HashTable<String, String>(capacity: 5)
hashTable["firstName"] = "Anna"

let anna = hashTable["firstName"]

hashTable["firstName"] = "Arturo"
hashTable["firstName"] = "A"
hashTable["lastName"] = "Jake"
if let firstName = hashTable["firstName"] {
    print(firstName)
}else {
    print("firstName key not in hash table")
}

if let lastName = hashTable["lastName"] {
    print(lastName)
} else {
    print("lastName key not in hash table")
}

//hashTable["firstName"] = nil
hashTable["lastName"] = "Jake2"
//hashTable.removeValue(for: "firstName")

if let firstName = hashTable["firstName"] {
    print(firstName)
} else {
    print("firstName key not in hash table")
}

if let lastName = hashTable["lastName"] {
    print(lastName)
} else {
    print("lastName key not in hash table")
}


//// Use Array:
//struct HashTable<Key: Hashable, Value> {
//    private typealias Element = (key: Key, value: Value)
//    private typealias Bucket = [Element]
//
//    private var buckets: [Bucket]
//
//    subscript(key: Key) -> Value? {
//        get {
//            return value(for: key)
//        }
//        set {
//            if let value = newValue {
//                update(value: value, for: key)
//            }else {
//                removeValue(for: key)
//            }
//        }
//    }
//
//    init(capacity: Int){
//        assert(capacity > 0)
//        buckets = Array<Bucket>(repeating: [], count: capacity)
//    }
//
//    private func index(for key: Key) -> Int {
//      return abs(key.hashValue) % buckets.count
//    }
//
//    mutating private func update(value: Value, for key: Key) -> Value? {
//        let index = self.index(for: key)
//
//        if let (i, _) = buckets[index].enumerated().first(where: { $0.element.key == key}){
//            buckets[index][i].value = value
//        }else {
//            buckets[index].append((key: key, value: value))
//        }
//        return value
//    }
//
//    mutating func removeValue(for key: Key) -> Value? {
//        let index = self.index(for: key)
//        if let (i, _) = buckets[index].enumerated().first(where: { $0.element.key == key }) {
//            buckets[index].remove(at: i)
//        }
//        return nil
//    }
//
//    func value(for key: Key) -> Value? {
//        return buckets[index(for: key)].first(where: { $0.key == key })?.value
//    }
////    func hash(into hasher: inout Hasher) {
////        hasher.combine(key)
////    }
//}

//var hashTable = HashTable<String, String>(capacity: 5)
//hashTable["firstName"] = "Anna"
//
//let anna = hashTable["firstName"]
//
//if let firstName = hashTable["firstName"] {
//  print(firstName)
//}
//
//if let lastName = hashTable["lastName"] {
//  print(lastName)
//} else {
//  print("lastName key not in hash table")
//}
//
//hashTable["firstName"] = nil
////hashTable.removeValue(for: "firstName")
//
//if let firstName = hashTable["firstName"] {
//  print(firstName)
//} else {
//  print("firstName key not in hash table")
//}


//: [Next](@next)
