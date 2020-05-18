//: [Previous](@previous)

import Foundation

//: ### You are given a binary tree in which each node contains an integer value (which might be positive or negative). Design an algorithm to count the number of paths that sum to a given value. The path does not need to start or end at the root or a leaf, but it must go downwards (traveling only from parent nodes to child nodes).

//https://leetcode.com/problems/path-sum-iii/

// Brute Force solution is O(N log N) balances tree becasue for every node we traverse a log N path or O(N2) for unbalanced tree

func pathSum(_ root: BinaryTreeNode<Int>?, _ sum: Int ) -> Int {
    guard let root = root else { return 0 }
    
    let pathsFromRoot = countPaths(root, target: sum)
    
    let pathsFromLeft = pathSum(root.left, sum)
    let pathsFromRight = pathSum(root.right, sum)
    
    return pathsFromRoot + pathsFromLeft + pathsFromRight
}

private func countPaths(_ root: BinaryTreeNode<Int>?, target: Int, currentSum: Int = 0) -> Int {
    guard let root = root else { return 0 }
    
    let totalCount = root.val + currentSum
    var totalPaths = 0
    
    if totalCount == target {
        totalPaths += 1
    }
    
    totalPaths += countPaths(root.left, target: target, currentSum: totalCount)
    totalPaths += countPaths(root.right, target: target, currentSum: totalCount)
    
    return totalPaths
}

// Instead of repreating work, for example on node 10 we visit 10 -> 5-> 3-> -2, and redo work above when visiting node 5 -> 3-> -2.
// If we isolate a path as an array [10, 5, 3, -2] we can subtract the sum we are looking for (8) from the total running sum (10 + 5 + 3). If totalSum - sum = a node we saw before (18 - 8 = 10), then after that node is a start of the path equal the number we are looking for. 10 is at index 0, index 1-index 2 is a path. Index 2's totalSum is 18.
// This solution is O(N) time but we need to store previous node paths. For an array this storage would also be O(N) but for a tree we only need to store through the leaf we are exploring. This makes is even more essential to DFS traverse.

func pathSumFaster(_ root: BinaryTreeNode<Int>?, _ sum: Int) -> Int {
    guard let root = root else { return 0 }
    // cache stores previoud nodes visited as their runningSum value
    var cache = [0 : 1]
    var result = 0
    
    pathSum(root, sum, &cache, &result, 0)
    return result
}

private func pathSum(_ root: BinaryTreeNode<Int>?, _ sum: Int, _ cache: inout [Int:Int], _ result:inout Int, _ runningSum: Int) {
    guard let root = root else {
        return
    }
    // current total from adding previous nodes together
    let currentRunningTotal = runningSum + root.val
    
    if let seen = cache[currentRunningTotal - sum] {
        result += seen
    }
    
    cache[currentRunningTotal, default: 0] += 1
    pathSum(root.left, sum, &cache, &result, currentRunningTotal)
    pathSum(root.right, sum, &cache, &result, currentRunningTotal)
    // backtrack, remove node from cache, this leaf path has been compeletly explored
    cache[currentRunningTotal, default: 0] -= 1
}


let tree = BinaryTreeNode(val: 10)
tree.right = BinaryTreeNode(val: -3)
tree.right?.right = BinaryTreeNode(val: 11)
tree.left = BinaryTreeNode(val: 5)
tree.left?.right = BinaryTreeNode(val: 2)
tree.left?.right?.right = BinaryTreeNode(val: 1)
tree.left?.left = BinaryTreeNode(val: 3)
tree.left?.left?.right = BinaryTreeNode(val: -2)
tree.left?.left?.left = BinaryTreeNode(val: 3)

//
//pathSum(tree, sum: 8)

pathSumFaster(tree, 8)

//: [Next](@next)
