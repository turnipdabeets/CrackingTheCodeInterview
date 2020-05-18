//: [Previous](@previous)

import Foundation

//: ### Given two singly linked lists, determine if the two lists intersect. Return the intersecting node. Note that the intersection is defined based on reference, not value. That is, if the kth node of the first linked list is the exact same node (by reference) as the kth node of the second linked list, then they are intersecting. 


//: O(A + B) to get two list counts, then one more loop O(B) to check for reference equality
//: We know that the tail will always be the same so move pointer on longer list forward by the difference to apply a equality check as if the lengths are the same
//: time O(A + 2B) or just O(A + B) with O(1) space
//: could also use a hashtable by storing the node reference but that would take more space
//: could also return earlier if tails don't match by storing size and tail in a struct to compare difference and tails
//: could also write a separate function to chop off the longer list and then compare equal lenght lists in the main function

func intersects<T>(_ l1: ListNode<T>?, with l2: ListNode<T>?) -> ListNode<T>? {
    let l1Size = getSize(l1)
    let l2Size = getSize(l2)
    let difference = abs(l1Size - l2Size)
    
    var longer = l1Size >= l2Size ? l1 : l2
    var shorter: ListNode<T>? = nil
    var count = 0
    
    while longer != nil {
        count += 1
        
        if shorter === longer {
            return shorter
        }
        
        longer = longer?.next
        
        if count == difference {
            shorter = l1Size < l2Size ? l1 : l2
        }else if count > difference {
            shorter = shorter?.next
        }
    }
    return nil
}

func getSize<T>(_ node: ListNode<T>?) -> Int {
    var size = 0
    var n = node
    while n != nil {
        size += 1
        n = n?.next
    }
    return size
}

var LL = ListNode(7)
    LL.next = ListNode(1)
    LL.next?.next = ListNode(2)

var LL2 = ListNode(5)
    LL2.next = ListNode(9)
    LL2.next?.next = LL.next
    LL2.next?.next?.next = ListNode(2)

intersects(LL, with: LL2)

//: [Next](@next)
