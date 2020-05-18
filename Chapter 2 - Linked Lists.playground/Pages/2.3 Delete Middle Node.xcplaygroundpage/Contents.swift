//: [Previous](@previous)

import Foundation

//: ### Implement an algorithm to delete a node in the middle (i.e. any node but the first and last node, not necessarily the exact middle) of a singly linked list, given only access to the node. Given input C in A-> B-> C-> D-> E-> F will modify LL to A-> B-> D-> E-> F

//: Note we can't assign node = next so copy data to that node. This deletes all except the last node

func delete<T>(node: ListNode<T>?){
    guard let next = node?.next else {
//        node = nil
        return
    }
    node?.val = next.val
    node?.next = next.next
}

var LL = ListNode(8)
LL.next = ListNode(3)
LL.next?.next = ListNode(2)
LL.next?.next?.next = ListNode(5)
LL.next?.next?.next?.next = ListNode(1)
LL.next?.next?.next?.next?.next = ListNode(2)

delete(node: LL.next?.next?.next?.next?.next)
printList(LL)

//: [Next](@next)
