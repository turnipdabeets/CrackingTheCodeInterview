//: [Previous](@previous)

import Foundation

//: ### A binary search tree was create by traversing through an array from left to right and inserting each element. Given a BST with distinct elements, print all possible arrays that could have led to this tree.

//similar to or opposite https://leetcode.com/problems/unique-binary-search-trees-ii/

//https://medium.com/@jackwootton/binary-search-tree-sequences-53163b1f374a

// the root node of any sub-tree must be inserted before its children so add it to a prefix first
func bstSequences(_ root: BinaryTreeNode<Int>?) -> [[Int]] {
    var result = [[Int]]()
    
    // lefts in rights loop will loop w/ single array
    guard let root = root else { return [[]] }
    
    let lefts = bstSequences(root.left)
    let rights = bstSequences(root.right)
    print("LEFTS", lefts)
    print("RIGHTS", rights)
    
    for left in lefts {
        for right in rights {
            let weaveList = weave(first: left, second: right, prefix: [root.val])
            for list in weaveList {
                result.append(list)
            }
        }
    }
    
    return result
}

func weave(first: [Int], second: [Int], prefix: [Int]) -> [[Int]] {
    var weaved: [[Int]] = []
    
    func weave(first: [Int], second: [Int], prefix: [Int]) {
        if first.isEmpty || second.isEmpty {
            weaved.append(prefix + first + second)
            return
        }
        
        var newFirst = first
        var prefixWithFirstInitial = prefix
        prefixWithFirstInitial.append(newFirst.removeFirst())
        weave(first: newFirst, second: second, prefix: prefixWithFirstInitial)
        
        var newSecond = second
        var prefixWithSecondInitial = prefix
        prefixWithSecondInitial.append(newSecond.removeFirst())
        weave(first: first, second: newSecond, prefix: prefixWithSecondInitial)
    }
    
    weave(first: first, second: second, prefix: prefix)
    
    return weaved
}

//let tree = BinaryTreeNode(val: 2)
//tree.left = BinaryTreeNode(val: 1)
//tree.right = BinaryTreeNode(val: 3)

let tree = BinaryTreeNode(val: 10)
tree.left = BinaryTreeNode(val: 5)
tree.right = BinaryTreeNode(val: 20)
tree.right?.right = BinaryTreeNode(val: 30)
tree.left?.left = BinaryTreeNode(val: 2)
tree.left?.right = BinaryTreeNode(val: 4)

dump(bstSequences(tree))

//: [Next](@next)
