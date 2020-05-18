//: [Previous](@previous)

import Foundation

//: ### You have two numbers represented by a linked list, where each node contains a single digit. The digits are stored in reverse order, such that the Vs digit is at the head of the list. Write a function that add the two numbers and returns the sum as a linked list.

//: Example:
//: - Input: (7 -> 1 -> 6) + (5 -> 9 -> 2). That is 617 + 295
//: - Output: 2 -> 1 -> 9. That is 912

//: Folowup - suppose the digits were stored in forward order. Repeat the above problem.
//: Example:
//: - Input: (6 -> 1 -> 1) + (2 ->9 -> 5). That is 617 + 295
//: - Output: 9 -> 1 -> 2. That is 912


//: Works only if both have same number of nodes, O(N) time and space
func addReverse(_ n1: ListNode<Int>?, with n2: ListNode<Int>?, carry: Int = 0) -> ListNode<Int>? {
    guard let n1 = n1, let n2 = n2 else {
        return carry > 0 ? ListNode(carry) : nil
    }

    let total = n1.val + n2.val + carry
    let carryResult = total >= 10 ? 1 : 0
    let new = ListNode(total % 10)

    let temp = addReverse(n1.next, with: n2.next, carry: carryResult)
    new.next = temp

    return new
}

//: Handles various lengths by padding 0
func addReverseVariousLengths(_ n1: ListNode<Int>?, with n2: ListNode<Int>?, carry: Int = 0) -> ListNode<Int>? {
    guard let node1 = n1, let node2 = n2 else {
        return carry > 0 ? ListNode(carry) : nil
    }

    if node1.next == nil && node2.next != nil {
        n1?.next = ListNode(0)
    }

    if node2.next == nil && node1.next != nil {
        n2?.next = ListNode(0)
    }

    let total = node1.val + node2.val + carry
    let carryResult = total >= 10 ? 1 : 0
    let new = ListNode(total % 10)

    let temp = addReverseVariousLengths(n1?.next, with: n2?.next, carry: carryResult)
    new.next = temp

    return new
}

////Test simple case
//var LL = ListNode(7)
//    LL.next = ListNode(1)
//    LL.next?.next = ListNode(6)
//var LL2 = ListNode(5)
//    LL2.next = ListNode(9)
//    LL2.next?.next = ListNode(2)

////Test carry
//var LL = ListNode(9)
//    LL.next = ListNode(7)
//    LL.next?.next = ListNode(8)
//var LL2 = ListNode(6)
//    LL2.next = ListNode(8)
//    LL2.next?.next = ListNode(5)

//Test uneven node lengths
//var LL = ListNode(0)
//    LL.next = ListNode(7)
//    LL.next?.next = ListNode(1)
//    LL.next?.next?.next = ListNode(6)
//var LL2 = ListNode(5)
//    LL2.next = ListNode(9)
//    LL2.next?.next = ListNode(2)


var LL = ListNode(9)
    LL.next = ListNode(9)
    LL.next?.next = ListNode(9)
    LL.next?.next?.next = ListNode(9)
var LL2 = ListNode(9)
    LL2.next = ListNode(9)
    LL2.next?.next = ListNode(9)

//printList(addReverse(LL, with: LL2))
printList(addReverseVariousLengths(LL, with: LL2))

//: [Next](@next)
