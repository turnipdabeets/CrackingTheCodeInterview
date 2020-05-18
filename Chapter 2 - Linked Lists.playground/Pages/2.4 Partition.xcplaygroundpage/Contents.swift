//: [Previous](@previous)

import Foundation

//: ### Write code to partition a linked list around a value x, such that all nodes less than x come before all nodes greater than or equal to x. If x is contained within the list, the values of x only need to be after the element less than x. The partition element x can appear anywhere in the "right partition". It does not need to appear between the left and right partitions.

//: Example: partition = 5
//: - Input: 3 -> 5 -> 8 -> 5 -> 10 -> 2 -> 1
//: - Output: 3 -> 1 -> 2 -> 10 -> 5 -> 5 -> 8


//: O(N) time with space holding O(N) + right side
func partition(_ node: inout ListNode<Int>, x: Int){
    var currentNode: ListNode<Int>? = node
    var firstRightSideNode: ListNode<Int>? = nil
    
    while currentNode != nil {
        
        guard let current = currentNode else { return }
        
        if firstRightSideNode == nil && current.val >= x {
            firstRightSideNode = current
        }
        
        if firstRightSideNode != nil && current.val < x {
            // swap and set next initial
            let tempValue = firstRightSideNode!.val
            firstRightSideNode!.val = current.val
            currentNode?.val = tempValue
            firstRightSideNode = firstRightSideNode?.next
        }
        
        currentNode = current.next
    }
    printList(node)
}




// solution suggested in Cracking the Code but answer doesnt look right
//func partitionAlt1(_ node: ListNode<Int>, x: Int) -> ListNode<Int> {
//    var currentNode: ListNode<Int>? = node
//    var head = node
//    var tail = node
//
//    while currentNode != nil {
//        let next = currentNode?.next
//
//        if currentNode!.val < x {
//            currentNode?.next = head
//            head = currentNode!
//        } else {
//            tail.next = currentNode!
//            tail = currentNode!
//        }
//
//        currentNode = next
//    }
//    tail.next = nil
//    return head
//}

var LL = ListNode(3)
    LL.next = ListNode(5)
    LL.next?.next = ListNode(8)
    LL.next?.next?.next = ListNode(5)
    LL.next?.next?.next?.next = ListNode(10)
    LL.next?.next?.next?.next?.next = ListNode(2)
    LL.next?.next?.next?.next?.next?.next = ListNode(1)

partition(&LL, x: 5)
//printList(partitionAlt1(LL, x: 5))

//: [Next](@next)
