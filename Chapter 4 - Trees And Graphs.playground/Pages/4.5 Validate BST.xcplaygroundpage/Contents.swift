//: [Previous](@previous)

import Foundation

//: ### Implement a function to check if a binary tree is a binary search tree

//: - In-order traversal should return node.val in sorted order if the tree is a binary search tree
//: - We can't just check left <= current < right because we need the scope of all nodes left and right

//: https://leetcode.com/explore/learn/card/recursion-ii/470/divide-and-conquer/2874/


//: Uses in-order traversal but would be nice to short curcuit when we find node isn't BST instead of continuing the whole recursion
func isValidBST(_ node: BinaryTreeNode<Int>) -> Bool {
    var result = true
    var inorder = Int.min
    
    func DFS(_ node: BinaryTreeNode<Int>?){
        guard let node = node else { return }
        DFS(node.left)
        if node.val <= inorder {
            result = false
        }
        inorder = node.val
        DFS(node.right)
        return
    }
    DFS(node)
    
    return result
}

//: Uses in-order traversal iteration. Similar to BFS but uses a stack instead of a queue and we can still determine in-order but front loading lefts, check current, then handle rights.
func isValidBSTAlt(_ node: BinaryTreeNode<Int>) -> Bool {
    var stack = [BinaryTreeNode<Int>]()
    var inorder = Int.min
    var current: BinaryTreeNode<Int>? = node
        
    while !stack.isEmpty || current != nil {
        while current != nil {
            // need to check current != nil while looping might get nil left
            stack.append(current!)
            current = current?.left
        }
        
        current = stack.removeLast()
        
        if current!.val < inorder {
            return false
        }
        
        inorder = current!.val
        current = current?.right
    }
    
    return true
}

//: keep track of a lower and upper limit to compare each node to its min and max
func isValidBSTDFS(_ node: BinaryTreeNode<Int>?, max: Int = Int.max, min: Int = Int.min ) -> Bool {
    guard let node = node else { return true }
    
    if node.val < min || node.val > max { return false }
    
    guard isValidBSTDFS(node.left, max: node.val, min: min) else {
        return false
    }
    guard isValidBSTDFS(node.right, max: max, min: node.val) else {
        return false
    }
    
    return true
}

//: Iterative version, address first node and then DFS using a stack. We could use BSF with a queue too to track min and max.
func isValidBSTDFSAlt(_ node: BinaryTreeNode<Int>) -> Bool {
    var stack = [(node, min: Int.min, max: Int.max)]
    
    while !stack.isEmpty {
        let (node, min, max) = stack.removeLast()
//        print(node.val)
        if node.val < min || node.val >= max { return false }
        print("root", node.val, node.right?.val, node.left?.val)
        print("min", min)
        print("max", max)
        print(node.val < min || node.val >= max)
        if let right = node.right {
            stack.append((right, min: node.val, max: max))
        }
        
        if let left = node.left {
            stack.append((left, min: min, max: node.val))
        }
    }
    
    return true
}

// tree tests edge case wehre left < current < right is true but not for the tree as a whole
let tree = BinaryTreeNode(val: 8)
tree.left = BinaryTreeNode(val: 7)
tree.right = BinaryTreeNode(val: 10)
tree.left?.left = BinaryTreeNode(val: 2)
tree.left?.right = BinaryTreeNode(val: 9)
tree.right?.left = BinaryTreeNode(val: 9)
tree.right?.right = BinaryTreeNode(val: 20)



let alt = BinaryTreeNode(val: 1)
alt.left = nil
alt.right = BinaryTreeNode(val: 1)

isValidBST(tree)
isValidBSTAlt(tree)
isValidBSTDFS(tree)
isValidBSTDFSAlt(alt)

//: [Next](@next)
