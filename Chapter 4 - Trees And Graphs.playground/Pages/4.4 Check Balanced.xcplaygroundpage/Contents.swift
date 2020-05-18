//: [Previous](@previous)

import Foundation

//: ### Implement a function to check if a binary tree is balanced. For the purpose of this question, a balanced tree is defined to be a tree such that the heights of the two subtrees of any node never differ by more than one.


//: O(N) time, recursive so O(N) space used in stack
//: keep track of the height by taking the max of either the left or right and add one. If there is no node return -1 so that it will show a 0 height. If the left and right have a difference greater than 1 then it is not balanced.

func isBalanced<T>(_ node: BinaryTreeNode<T>) -> Bool {
    var result = true
    
    @discardableResult func DFS<T>(_ node: BinaryTreeNode<T>?) -> Int {
        guard let node = node else { return -1 }

        let leftHeight = DFS(node.left)
        let rightHeight = DFS(node.right)

        if abs(leftHeight - rightHeight) > 1  {
            result = false
        }
        
        return max(leftHeight, rightHeight) + 1
    }
    
    DFS(node)
    return result
}

let tree = BinaryTreeNode(val: 1)
tree.right = BinaryTreeNode(val: 3)
tree.left = BinaryTreeNode(val: 2)
tree.left?.left = BinaryTreeNode(val: 4)
tree.left?.right = BinaryTreeNode(val: 5)
tree.left?.left?.left = BinaryTreeNode(val: 6)
tree.left?.left?.right = BinaryTreeNode(val: 7)

isBalanced(tree)

//: [Next](@next)
