//: [Previous](@previous)

import Foundation

//: ### Implement an algorithm to find the kth to last element of a singly linked list.


//: Use Array for Random Access lookup. O(N) time and space
//: - check index before accessing map, otherwise just return last element

func returnKToLast<T>(_ node: ListNode<T>, target: Int) -> T {
    var map = [T]()
    var current: ListNode<T>? = node
    
    while(current != nil){
        map.append(current!.val)
        current = current?.next
    }
    
    guard map.count - target > 0 && map.count - target < map.count else {
        return map[map.count - 1]
    }

    return map[map.count - target]
}

//: Save space but add time by looping twice. Once for the LL count and another again for the kth point. O(N+N) time or O(N)

func kToLast<T>(_ node: ListNode<T>, k: Int) -> T? {
    var current: ListNode<T>? = node
    var count = 0
    
    // get total
    while current != nil {
      count += 1
      current = current?.next
    }
    
    // loop again to kth point where final n?.next gets us there
    var n: ListNode<T>? = node
    for _ in 0..<count-k {
        n = n?.next
    }

    // return val unless
    return n?.val ?? nil
}

//: Use recurrsion and the stack O(N) space and time

func kToLastRecu<T>(_ node: ListNode<T>, k: Int) -> T {
    var ans = 0 as! T
    
    func saveAtTarget(_ node: ListNode<T>, k: Int) -> (_ node: ListNode<T>) -> Void {
        var count = 0
        return { n in
            count += 1
            if count == k { ans = n.val }
        }
    }
    
    recurHelper(node, apply: saveAtTarget(node, k: k))
    
    return ans
}

func recurHelper<T>(_ node: ListNode<T>?, apply: @escaping (_ node: ListNode<T>) -> Void){
    guard let node = node else { return }
    recurHelper(node.next, apply: apply)
    apply(node)
}

//: Cleaner recursive solution but still O(N) time and space but prints and doesnt return answer, it returns ListNode total
func kToLastRecurCleanPrint<T>(_ node: ListNode<T>?, k: Int) -> Int{
    guard let node = node else { return 0 }
    
    let index = kToLastRecurCleanPrint(node.next, k:k) + 1
    
    if index == k { print(node.val) }
    
    return index
}

// Doesn't work but attempt to match cracking code C++ solution on 222 of 712

//func kToLastRecurClean<T>(_ node: ListNode<T>?, k: Int) -> T? {
//    return kToLastRecurCleanHelper(node, k: k, i: 0)?.val
//}
//
//func kToLastRecurCleanHelper<T>(_ node: ListNode<T>?, k: Int, i: Int) -> ListNode<T>? {
//    guard let node = node else { return nil }
//
//    let n = kToLastRecurCleanHelper(node.next, k: k, i: i + 1)
//
//    print(n?.val, node.val, i)
//    if i == k {
//        return node
//    }
//
//    return n
//}

//: Fixed version
class Idx {
    var value = 0
}

func kToLastRecurClean<T>(_ node: ListNode<T>?, k: Int) -> T? {
    return kToLastRecurCleanHelper(node, k: k, i: Idx())?.val
}

func kToLastRecurCleanHelper<T>(_ node: ListNode<T>?, k: Int, i: Idx) -> ListNode<T>? {
    guard let node = node else { return nil }

    let n = kToLastRecurCleanHelper(node.next, k: k, i: i)
    i.value += 1

    if i.value == k {
        return node
    }

    return n
}

//: Start second counter when 1st counter has reached k iterations, when first is done second is where it should be O(N) time and O(1) space

func kToLastIter<T>(_ node: ListNode<T>, k: Int) -> T? {
    var iterations = 0
    var first: ListNode<T>? = node
    var second: ListNode<T>? = nil
    
    while first != nil {
        first = first?.next
        iterations += 1
        
        if iterations == k {
            second = node
        }
        
        if iterations > k {
            second = second?.next
        }
    }
    return second?.val ?? nil
}

//: Better version of kToLastIter, maybe easier to read but same concept. Set first ahead of second and then increment together. In the end the second will be at the correct position.

func kToLastIterClean<T>(_ node: ListNode<T>, k: Int) -> T? {
    var first: ListNode<T>? = node
    var second: ListNode<T>? = node
    
    for _ in 0..<k {
        first = first?.next
    }
    
    while first != nil {
        first = first?.next
        second = second?.next
    }
    
    return second?.val ?? nil
}

var LL = ListNode(8)
LL.next = ListNode(3)
LL.next?.next = ListNode(2)
LL.next?.next?.next = ListNode(5)
LL.next?.next?.next?.next = ListNode(1)
LL.next?.next?.next?.next?.next = ListNode(2)

kToLastIterClean(LL, k:3)



//: [Next](@next)
