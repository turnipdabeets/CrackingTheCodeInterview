//: [Previous](@previous)

import Foundation
//: ### Write code to remove duplicates from an unsorted linked list.

//: O(N) time and space O(n/2) becasue worst case half wil be duplicated

func removeDups<T : Hashable>(_ node: inout ListNode<T>){
    var items = Set<T>()
    var temp = node
    
    while(temp.next != nil) {
        guard let next = temp.next else { break }
        
        items.insert(temp.val)
        
        if items.contains(next.val) {
            temp.next = next.next
        }
        
        temp = next

    }
    printLL(node) 
}

//: ### How would you do this if a temporary buffer is not allowed?

//: O(n^2) time but no space is used

func removeDupsUseNoSpace<T : Hashable>(_ node: inout ListNode<T>){
    var first = node
    var second = node
    
    while(first.next != nil){
        guard let fNext = first.next else { break }
        
        let item = first.val
        
        while(second.next != nil) {
            guard let next = second.next else { break }

            if next.val == item {
                second.next = second.next?.next
            }
            
            second = next
        }
        
        first = fNext
        second = fNext
    }
    printLL(node)

}

//: Alternate functions that use optionals and start at head instead of head.next

func removeDupsV2<T : Hashable>(_ node: inout ListNode<T>){
    var set = Set<T>()
    var previous: ListNode<T>? = nil
    var n: ListNode? = node
    
    while(n != nil) {
        // can't use guard otherwise compiler wants to set new var and not original n
//        guard var _ = n else { break }
        if set.contains(n!.val) {
            previous?.next = n!.next
        }else{
            set.insert(n!.val)
            previous = n
        }
        n = n!.next
    }
    printLL(node)
    
    RP(node, apply: printLast(node, target: 3))
}

func removeDupsUseNoSpaceV2<T : Hashable>(_ node: inout ListNode<T>){
    var current: ListNode? = node
    
    while(current != nil){
        var runner = current
        
        while(runner?.next != nil){
            if runner?.next?.val == current?.val{
              runner?.next = runner?.next?.next
            }else {
              runner = runner?.next
            }
        }
        current = current?.next
    }
    printLL(node)
}


var LL = ListNode(5)
LL.next = ListNode(3)
LL.next?.next = ListNode(2)
LL.next?.next?.next = ListNode(5)
LL.next?.next?.next?.next = ListNode(1)
LL.next?.next?.next?.next?.next = ListNode(2)

//removeDups(&LL)
//removeDupsUseNoSpace(&LL)
removeDupsV2(&LL)


//: [Next](@next)
