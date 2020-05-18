//: [Previous](@previous)

import Foundation

//: ### Given a binary tree, design an algorithm which creates a linked list of all the nodes at each depth. A tree with depth D has D linked lists.

//BFS, traverses at the the depth level but it isnt necessary
func createLLBFS<T>(_ node:BinaryTreeNode<T>?) -> [ListNode<BinaryTreeNode<T>>] {
    var list = [ListNode<BinaryTreeNode<T>>]()
    var Q = Queue<(node:BinaryTreeNode<T>, level: Int)>()
    if let node = node {
        Q.enqueue((node:node, level:0))
    }
        
    while !Q.isEmpty {
        if let (node, level) = Q.dequeue() {
            if level > list.count - 1 {
                list.append(ListNode(node))
            }else {
                list[level].next = ListNode(node)
            }
            if let left = node.left {
                Q.enqueue((left, level + 1))
            }
            
            if let right = node.right {
                Q.enqueue((right, level + 1))
            }
        }
    }
    return list
}


//DFS
func createLLDFS<T>(_ node:BinaryTreeNode<T>?) -> [ListNode<BinaryTreeNode<T>>] {
    var list: [ListNode<BinaryTreeNode<T>>] = []
    DFS(node, level: 0) { (node, level) in
        if level == list.count {
            list.append(ListNode(node))
        }else {
            list[level].next = ListNode(node)
        }
    }
    return list
}

func DFS<T>(_ node: BinaryTreeNode<T>?, level: Int = 0, process: @escaping(BinaryTreeNode<T>, Int) -> Void) {
    guard let node = node else { return }
    process(node, level)
    DFS(node.left, level: level + 1, process: process)
    DFS(node.right, level: level + 1, process: process)
}


//--------------------------
public func createMinimalBST(_ array: [Int]) -> BinaryTreeNode<Int>? {
    return createInOrder(array, start: array.startIndex, end: array.endIndex - 1)
}

func createInOrder(_ array: [Int], start: Int, end: Int) -> BinaryTreeNode<Int>? {
    if end < start { return nil }
    let middle = end + ((start - end) / 2)
    let node = BinaryTreeNode(val: array[middle])
    node.left = createInOrder(array, start: start, end: middle - 1)
    node.right = createInOrder(array, start: middle + 1, end: end)
    return node
}

func printBSTListNodes<T>(_ node: ListNode<BinaryTreeNode<T>>?) {
    guard let node = node else { return }
    print(node.val.asString)
    printList(node.next)
}

print(createMinimalBST([1,2,3,4,5,6,7,8,9,10,11,12,13,14])!.asString)

let bst = createMinimalBST([1,2,3,4,5,6,7,8,9,10,11,12,13,14])
//let linkedList = createLLBFS(bst)
let linkedList = createLLDFS(bst)
print(linkedList)
printBSTListNodes(linkedList[1])

//: [Next](@next)
