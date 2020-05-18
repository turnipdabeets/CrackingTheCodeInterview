//: [Previous](@previous)

import Foundation

//: ### T1 and T2 are two very large binary trees, with T1 much bigger than T2. Create an algorithm to determine if T2 is a subtree of T1. A tree T2 is a subtree if there exists a node n in T1 such that the subtree of n is identical to T2. That is if you cut off the tree at node n, the two trees would be identical.

//: We could run a pre-order traversal over both trees for a string of nodes. Null tree values should return a string value to keep track of order. Thenwe can compare the strings to see if T2 is a substring of T1. This takes O(N*M) where N is number of nodes in T1 and M is number of nodes in T2. This isnot the most ideal complexity to have with very large trees.

//: An Alternative is to search the larger tree, each time we find a match fro T2's root we can check if the trees match. Instead of saying this is O(N*M) we can say its closer to O(N) since we terminate as soon the trees do not match and only check T2 when we find a potential root node for T2.

func subTree<T: Equatable>(first: BinaryTreeNode<T>, contains second: BinaryTreeNode<T>?) -> Bool {
    if second == nil { return true } //empty tree is a subtree
    
    return helper(first: first, second: second)
}

private func helper<T: Equatable>(first: BinaryTreeNode<T>?, second: BinaryTreeNode<T>?) -> Bool{
    guard let first = first else { return false }
    
    let left = helper(first: first.left, second: second)
    let right = helper(first: first.right, second: second)
    
    if let second = second, first.val == second.val && matchTree(first, second) {
        return true
    }
    
    return left || right
}

private func matchTree<T:Equatable>(_ first: BinaryTreeNode<T>?, _ second: BinaryTreeNode<T>?) -> Bool {
    if first == nil && second == nil {
        return true // nothing left in either tree
    }
    
    // exactly one tree is empty, no match
    guard let first = first, let second = second else { return false }
    
    if first.val != second.val { return false } // terminate if not equal

    return matchTree(first.left, second.left) && matchTree(first.right, second.right)
}

let tree = BinaryTreeNode(val: 10)
tree.left = BinaryTreeNode(val: 5)
tree.right = BinaryTreeNode(val: 20)
tree.right?.right = BinaryTreeNode(val: 30)
tree.left?.left = BinaryTreeNode(val: 2)
tree.left?.right = BinaryTreeNode(val: 4)

let treea = BinaryTreeNode(val: 10)
treea.left = BinaryTreeNode(val: 5)
treea.right = BinaryTreeNode(val: 20)
treea.right?.right = BinaryTreeNode(val: 30)
treea.left?.left = BinaryTreeNode(val: 3)
treea.left?.right = BinaryTreeNode(val: 4)
//matchTree(tree, treea)

let subtree = BinaryTreeNode(val: 5)
subtree.left = BinaryTreeNode(val: 2)
subtree.right = BinaryTreeNode(val: 4)

subTree(first: tree, contains: subtree)

//: [Next](@next)
