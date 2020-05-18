//: [Previous](@previous)

import Foundation

//: ### Implement a function to check if a linked list is a palindrome

//: O(N) time, space holds two strings of the full length so O(N + N). Requires ListNode<String> so not as generic as Alt1
func isPalindrome(_ node: ListNode<String>?) -> Bool {
    var forward = ""
    var backward = ""

    func helper(_ node: ListNode<String>?) {
        guard let node = node else{
            return
        }
        forward += node.val
        helper(node.next)
        backward += node.val
    }
    helper(node)
    return forward == backward
}

//: Instead of using a string to hold values, reverse the LL and compare the reverse to the original. More generic but similar time and space complexity
func isPalindromeAlt1<T : Equatable>(_ node: ListNode<T>?) -> Bool {
    let reversed = reverseAndClone(node)
    return isEqual(node, to: reversed)
}

func reverseAndClone<T>(_ node: ListNode<T>?) -> ListNode<T>? {
    var tail = node
    var head: ListNode<T>? = nil
    
    while tail != nil {
        let new = ListNode(tail!.val)
        new.next = head
        head = new
        tail = tail?.next
    }
    return head
}

func isEqual<T : Equatable>(_ n1: ListNode<T>?, to n2: ListNode<T>?) -> Bool {
    var first = n1
    var second = n2

    while first != nil && second != nil {
        if first?.val != second?.val { return false }
        first = first?.next
        second = second?.next
    }
    
    return first == nil && second == nil
}

//: use fast/slow runner technique to get first half of list and compare to last half
func isPalindromeAlt2<T : Equatable>(_ node: ListNode<T>?) -> Bool {
    var fast = node
    var slow = node
    
    var stack = [T]()
    
    // push elements from first half of list into a stack w/ fast runner going 2x speed
    while fast != nil && fast?.next != nil {
        stack.append(slow!.val)
        slow = slow?.next
        fast = fast?.next?.next
    }

    // has odd number count, skip middle element
    if fast != nil{
        slow = slow?.next
    }
    
    //compare first half to second half
    while slow != nil {
        let top = stack.removeLast()
        if top != slow!.val { return false }
        slow = slow?.next
    }
    return true
}

//: recursive where we compare first half to second half, in C++ or C we could avoid the Result class with a double pointer
class Result<T> {
    var node: ListNode<T>?
    var result: Bool
    init(node: ListNode<T>?, result: Bool) {
        self.node = node
        self.result = result
    }
}

func isPalindromeAlt3<T: Equatable>(_ node: ListNode<T>?) -> Bool {
    let size = getLength(node)
    let r = isPalindromeRecurse(node, count: size)
    return r.result
}

// could possibly check if node == nil but not necessary
func isPalindromeRecurse<T: Equatable>(_ node: ListNode<T>?, count: Int) -> Result<T>{
    if count <= 0 {
        // even
        return Result(node: node, result: true)
    } else if count == 1 {
        // odd, skip middle
        return Result(node: node?.next, result: true)
    }
    
    let res = isPalindromeRecurse(node?.next, count: count - 2)
    // false should persist
    if !res.result { return res }
    
    res.result = node?.val == res.node?.val
    res.node = res.node?.next
    return res
}

func getLength<T>(_ node: ListNode<T>?) -> Int {
    var n = node
    var size = 0
    while n != nil {
        size += 1
        n = n?.next
    }
    return size
}


let LL = makeLL("racecar")
isPalindromeAlt3(LL)

//: [Next](@next)
