//: [Previous](@previous)

import Foundation

//: ## Lowest Common Ancestor of a Binary Tree (LCA)

//: ### Design an algorithm to find the first common ancestor of two nodes in a binary tree. Avoid storing additional nodes in a data structure. Note: This is not necessarily a binary search tree.

//https://leetcode.com/explore/learn/card/introduction-to-data-structure-binary-search-tree/142/conclusion/1012/

//https://leetcode.com/problems/lowest-common-ancestor-of-a-binary-tree/solution/


//: Post-order traversal allows us to visit left and right first to see if they contained the two nodes. If the left and right side contain the nodes then the current node is the LCA else we know which side the nodes exist

// See Carcking Code interview soution for when we have access to the parent. Similar to the intersection of 2 linked lists 2.7

// simplist solution returning node where left and right contain the node
func lowestCommonAncestor<T>(_ root: BinaryTreeNode<T>?, _ p: BinaryTreeNode<T>?, _ q: BinaryTreeNode<T>?) -> BinaryTreeNode<T>? {
    guard let root = root else { return nil }
    if root === p { return p }
    if root === q { return q }
    
    let left = lowestCommonAncestor(root.left, p, q)
    let right = lowestCommonAncestor(root.right, p, q)
    
    if left != nil && right != nil {
        return root
    }
    
    return left != nil ? left : right
}

// Similar to above but requires saving the LCA in a var
func lowestCommonAncestorDFS<T>(_ root: BinaryTreeNode<T>?, _ p: BinaryTreeNode<T>?, _ q: BinaryTreeNode<T>?) -> BinaryTreeNode<T>? {
    var LCA: BinaryTreeNode<T>? = nil
    
    func DFS(_ root: BinaryTreeNode<T>?) -> Bool {
        guard let root = root else { return false }
        
        let foundLeft = DFS(root.left)
        let foundRight = DFS(root.right)
        print(foundLeft, foundRight, root.val)
        
        if foundLeft && foundRight {
            LCA = root
            return true
        }
        
        if (root === p || root === q ) {
            if foundLeft || foundRight {
                LCA = root
            }
            print("root", root.val)
            return true
        }
        
        return foundLeft || foundRight
    }
    
    DFS(root)
    
    return LCA
}

// Iterative DFS soltuion using a State to add nodes to stack in post order

// we need all three cases for post order iterative traversal including complete
enum State {
    case complete
    case leftComplete
    case none
}

func lowestCommonAncestorIterative<T>(_ root: BinaryTreeNode<T>?, _ p: BinaryTreeNode<T>?, _ q: BinaryTreeNode<T>?) -> BinaryTreeNode<T>? {
    var stack = [(BinaryTreeNode<T>, State)]()
    var oneFound = false
    var LCA: BinaryTreeNode<T>? = nil
    
    if let root = root {
         stack.append((root, .none))
    }
    
    while !stack.isEmpty {
        if let (node, state) = stack.last {
           switch state {
             case .complete:
             print("post-order", node.val)
               stack.removeLast()
                if LCA === node && oneFound {
                    if let (nextTop, _) = stack.last {
                         LCA = nextTop
                    }
                }
               
             case .leftComplete:
               // set node to complete and add right child to stack
               stack.removeLast()
               stack.append((node, .complete))
               if let child = node.right {
                   stack.append((child, .none))
               }
               
             case .none:
               if node === p || node === q {
                   if (oneFound){
                       // means we have both
                       return LCA
                   }else {
                      oneFound = true
                      LCA = node
                   }
               }
               stack.removeLast()
               stack.append((node, .leftComplete))
               if let child = node.left {
                   stack.append((child, .none))
               }
           }
        }
    }
        
    return LCA
}

// Original attempt using DFS post order with vars to keep track of state
func lowestCommonAncestorOriginal<T>(_ root: BinaryTreeNode<T>?, _ p: BinaryTreeNode<T>?, _ q: BinaryTreeNode<T>?) -> BinaryTreeNode<T>? {
    var parent: BinaryTreeNode<T>? = nil
    var found = 0
    var foundLast = false
    
    func DFS(_ root: BinaryTreeNode<T>?) {
        guard let root = root else { return }
        DFS(root.left)
        DFS(root.right)
        
        if !foundLast && (root.left === parent || root.right === parent) {
            parent = root
            print("add parent", root.val, found, foundLast)
            if found == 2 {
                foundLast = true
            }
        }
        
        if (root === p || root === q ) {
            found += 1
            
            if found == 1 {
                parent = root
            }
            
            if root === parent && found == 2 {
                print("root is parent", root.val)
                foundLast = true
            }
            print("found:",found, root.val)
        }
    }
    
    DFS(root)
    
    return parent
}

//: [Next](@next)
