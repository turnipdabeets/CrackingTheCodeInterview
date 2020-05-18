//: [Previous](@previous)

import Foundation

//: ### Given a circular linked list, implement an algorithm that returns the node at the beginning of the loop. A circular linked list is a (corrupt) linked list in which a node's next pointer points to an earlier node, so as to make a loop in the linked list.

//: Example:
//: - Input: A -> B -> C -> D -> E -> C (the same C as earlier)
//: - Output: C

//: Instead of storing reference in hashtable, below will run in O(1) space and O(A+B)

//: Detect if there is a loop by using the fast/slow runner. If there is a lopp then increasing a faster pointer by 2 will eventually match up and will never have a nil .next

//: Once a loop is detected, resetting the slow loop to the head and then incrementing flow and fast by 1 will meet again at the start of the loop.


func beginning<T>(of head: ListNode<T>?) -> ListNode<T>? {
    var slow = head
    var fast = head
    
    // find meeting point
    while fast != nil && fast?.next != nil {
        slow = slow?.next
        fast = fast?.next?.next
        
        // loop detected
        if slow === fast { break }
    }
    
    // no loop exists
    if fast == nil || fast?.next == nil { return nil }
    
    slow = head
    
    while slow !== fast {
        slow = slow?.next
        fast = fast?.next
    }
    
    // both point to same node
    return fast
}

let CL = ListNode(1)
    CL.next = ListNode(2)
    CL.next?.next = ListNode(3) // start of loop
    CL.next?.next?.next = ListNode(4)
    CL.next?.next?.next?.next = CL.next?.next

beginning(of: CL)?.val

//: [Next](@next)
