//: [Previous](@previous)

import Foundation

//: ### Write an algo to find the "next" node (i.e. in-order successor) of a given node in a binary search tree. You may assume that each node has a link to its parent.


//: Traverse in order, when you find the node the next node is the result
func inorderSuccessor<T>(_ root: BinaryTreeNode<T>?, _ p: BinaryTreeNode<T>?) -> BinaryTreeNode<T>? {
    var found = false
    var result: BinaryTreeNode<T>? = nil
    
    func inOrder(_ root: BinaryTreeNode<T>?){
        guard let root = root else { return }
        inOrder(root.left)
        if found && result == nil {
            result = root
        }
        if root === p {
            found = true
        }
        inOrder(root.right)
        return
    }
    
    inOrder(root)
    return result
}

//: Option 2 with iterative inorder traversal
//: If the node has a right child, the successor is somewhere lower in the tree. Go one step right and then left till you can. Return the successor. Otherwise, the successor is somewhere upper in the tree. Implement iterative inorder traversal. While there are still nodes in the tree or in the stack: Go left till you can, adding nodes in stack. Pop out the last node. If its predecessor is equal to p, return that last node. Otherwise, save that node to be the predecessor in the next turn of the loop. Go one step right. If we're here that means the successor doesn't exit. Return nil.

func inorderSuccessorAlt<T>(_ root: BinaryTreeNode<T>?, _ p: BinaryTreeNode<T>?) -> BinaryTreeNode<T>? {
    
    // node has a right child
    if let right = p?.right {
        return leftMostChild(right)
    }
    
    // successor is somewhere upper in the tree
    var stack = [BinaryTreeNode<T>]()
    var current = root
    var previous: BinaryTreeNode<T>? = nil
    
    // if we have access to parent we can go up until we are on the left side instead of right. See Cracking the Coding Interview Solution.
    while !stack.isEmpty || current != nil {
        // add all lefts for current node
        while current != nil {
            stack.append(current!)
            current = current?.left
        }
        current = stack.removeLast()
        if p === previous { return current }
        previous = current
        current = current?.right
    }
    
    return nil
}

private func leftMostChild<T>(_ right: BinaryTreeNode<T>) -> BinaryTreeNode<T> {
    var current = right
    
    while let left = current.left {
        current = left
    }
    return current
}

let tree = BinaryTreeNode(val: 5)
tree.left = BinaryTreeNode(val: 3)
tree.right = BinaryTreeNode(val: 6)
tree.left?.left = BinaryTreeNode(val: 2)
tree.left?.right = BinaryTreeNode(val: 4)
tree.left?.left?.left = BinaryTreeNode(val: 1)

inorderSuccessor(tree, tree.left?.right)?.val
inorderSuccessorAlt(tree, tree.left?.right)?.val
//: [Next](@next)
