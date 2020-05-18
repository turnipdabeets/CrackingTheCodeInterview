//: [Previous](@previous)

import Foundation

//: ### Given a sorted (increasing in order) array with unique integer elements, write an algorithm to create a binary search tree with minimal height.

//: - A Tree is a "connected" graph without cycles which means there is a path between every pair of nodes.

//: - A Binary Search Tree is a Binary Tree (max two children) in which every node fits a specific ordering: all lefts <= n <= all rights (this must be true for all of a node's descendents, not just its immediate children)

//: Consider in-order traversal: left, node, right, how would you create a tree in-order? The middle of the array will ensure minimal height and help split left and right nodes.
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

//: Calculating middle with end + ((start - end)/2) is mathematically the same as (end+start) / 2 but scales better with larger numbers. start and end can be flipped as well.

print(createMinimalBST([1,2,3,4,5,6,7,8,9,10,11,12,13,14])!.asString)

//: A note about Swift Array indexes. Indeces are preserved and reference the original array even when referencing ArraySlices. An example below

//let a = ["A","B","C","D","E"]
//let slice = a[2..<a.endIndex]
//print(slice, slice.startIndex, slice.endIndex)
//slice.index(after: slice.startIndex)
////let slice2 = slice[0..<slice.endIndex] // out of bounds becasue 0 reference the original array
////print(slice2)


func printDFS<T>(_ node: BinaryTreeNode<T>?) {
    guard let node = node else { return }
    printDFS(node.left)
    printDFS(node.right)
    print(node.val) 
}

printDFS(createMinimalBST([1,2,3,4,5,6,7,8,9,10,11,12,13,14]))

//: [Next](@next)
