//: [Previous](@previous)

import Foundation

//: ### You are implementing a binary tree class from scratch which, in addition to insert, find, and delete has a method getRandomNode which returns a random node from the tree. All nodes should be equally likely to be chosen. Design and implement an algorithm for getRandomNode, and explain how you would implemet the rest of the methods.

//: A non-optimal solution would be to dump all values of tree into an array and then get a radnom index for that array. O(N) space and time. We could also keep track of the total number of nodes and just travse the tree until we get that node position but that will still be O(N) time, however we save on space.


//: Since we control the class we can add a counter for total nodes and children nodes. Get a random number based on total number of nodes in the tree and then find that node position using Binary Search for O(log N). Below implements insert and getRandomNode, but we can make sure to decremenet node size when deleting a node. 

//https://www.youtube.com/watch?v=nj5jFhglw8U

class TreeNode<T: Comparable> {
    var size: Int = 0
    var left: TreeNode? = nil
    var right: TreeNode? = nil
    var val: T
    
    init(_ val: T){
        self.val = val
    }
    
    func insert(_ val: T){
        if val <= self.val { 
            // go left
            if left == nil {
                left = TreeNode(val)
            }else {
                left?.insert(val)
            }
        }else {
            // go right
            if right == nil {
                right = TreeNode(val)
            }else {
                right?.insert(val)
            }
        }
        size += 1
    }
}

class Tree<T: Comparable> {
    let root: TreeNode<T>
    var total: Int {
        return root.size
    }
    
    init(val: T){
        self.root = TreeNode(val)
    }
    
    func insert(_ val: T){
        root.insert(val)
    }
    
    func getRandomNode() -> TreeNode<T>? {
        let randomNumber = Int.random(in: 0...total)
        print("randomNumber", randomNumber, "total", total)
        return getRandom(root, at: randomNumber)
    }
    
    private func getRandom(_ node: TreeNode<T>?, at count: Int) -> TreeNode<T>? {
        let leftSize = size(of: node?.left)
        if count == leftSize { return node }
        if count < leftSize { return getRandom(node?.left, at: count) }
        // subtract extra one for the current node
        return getRandom(node?.right, at: count - leftSize - 1)
    }
    
    private func size(of node: TreeNode<T>?) -> Int {
        guard let node = node else { return 0 }
        // add one for the node itself
        return node.size + 1
    }
}

let tree = Tree(val: 3)
tree.insert(1)
tree.insert(5)
tree.insert(4)
tree.insert(6)
tree.insert(2)
tree.insert(0)

//print(tree.root.asString)
tree.getRandomNode()?.val


//// Printing helper
//extension TreeNode {
//    public var asString: String {
//        return treeString(self){("\($0.val)",$0.left,$0.right)}
//    }
//
//    func treeString<T>(_ node:T, reversed:Bool=false, isTop:Bool=true, using nodeInfo:(T)->(String,T?,T?)) -> String
//    {
//        // node value string and sub nodes
//        let (stringValue, leftNode, rightNode) = nodeInfo(node)
//
//        let stringValueWidth  = stringValue.count
//
//        // recurse to sub nodes to obtain line blocks on left and right
//        let leftTextBlock     = leftNode  == nil ? []
//            : treeString(leftNode!,reversed:reversed,isTop:false,using:nodeInfo)
//                .components(separatedBy:"\n")
//
//        let rightTextBlock    = rightNode == nil ? []
//            : treeString(rightNode!,reversed:reversed,isTop:false,using:nodeInfo)
//                .components(separatedBy:"\n")
//
//        // count common and maximum number of sub node lines
//        let commonLines       = min(leftTextBlock.count,rightTextBlock.count)
//        let subLevelLines     = max(rightTextBlock.count,leftTextBlock.count)
//
//        // extend lines on shallower side to get same number of lines on both sides
//        let leftSubLines      = leftTextBlock
//            + Array(repeating:"", count: subLevelLines-leftTextBlock.count)
//        let rightSubLines     = rightTextBlock
//            + Array(repeating:"", count: subLevelLines-rightTextBlock.count)
//
//        // compute location of value or link bar for all left and right sub nodes
//        //   * left node's value ends at line's width
//        //   * right node's value starts after initial spaces
//        let leftLineWidths    = leftSubLines.map{$0.count}
//        let rightLineIndents  = rightSubLines.map{$0.prefix{$0==" "}.count  }
//
//        // top line value locations, will be used to determine position of current node & link bars
//        let firstLeftWidth    = leftLineWidths.first   ?? 0
//        let firstRightIndent  = rightLineIndents.first ?? 0
//
//
//        // width of sub node link under node value (i.e. with slashes if any)
//        // aims to center link bars under the value if value is wide enough
//        //
//        // ValueLine:    v     vv    vvvvvv   vvvvv
//        // LinkLine:    / \   /  \    /  \     / \
//        //
//        let linkSpacing       = min(stringValueWidth, 2 - stringValueWidth % 2)
//        let leftLinkBar       = leftNode  == nil ? 0 : 1
//        let rightLinkBar      = rightNode == nil ? 0 : 1
//        let minLinkWidth      = leftLinkBar + linkSpacing + rightLinkBar
//        let valueOffset       = (stringValueWidth - linkSpacing) / 2
//
//        // find optimal position for right side top node
//        //   * must allow room for link bars above and between left and right top nodes
//        //   * must not overlap lower level nodes on any given line (allow gap of minSpacing)
//        //   * can be offset to the left if lower subNodes of right node
//        //     have no overlap with subNodes of left node
//        let minSpacing        = 2
//        let rightNodePosition = zip(leftLineWidths,rightLineIndents[0..<commonLines])
//            .reduce(firstLeftWidth + minLinkWidth)
//            { max($0, $1.0 + minSpacing + firstRightIndent - $1.1) }
//
//
//        // extend basic link bars (slashes) with underlines to reach left and right
//        // top nodes.
//        //
//        //        vvvvv
//        //       __/ \__
//        //      L       R
//        //
//        let linkExtraWidth    = max(0, rightNodePosition - firstLeftWidth - minLinkWidth )
//        let rightLinkExtra    = linkExtraWidth / 2
//        let leftLinkExtra     = linkExtraWidth - rightLinkExtra
//
//        // build value line taking into account left indent and link bar extension (on left side)
//        let valueIndent       = max(0, firstLeftWidth + leftLinkExtra + leftLinkBar - valueOffset)
//        let valueLine         = String(repeating:" ", count:max(0,valueIndent))
//            + stringValue
//        let slash             = reversed ? "\\" : "/"
//        let backSlash         = reversed ? "/"  : "\\"
//        let uLine             = reversed ? "¯"  : "_"
//        // build left side of link line
//        let leftLink          = leftNode == nil ? ""
//            : String(repeating: " ", count:firstLeftWidth)
//            + String(repeating: uLine, count:leftLinkExtra)
//            + slash
//
//        // build right side of link line (includes blank spaces under top node value)
//        let rightLinkOffset   = linkSpacing + valueOffset * (1 - leftLinkBar)
//        let rightLink         = rightNode == nil ? ""
//            : String(repeating:  " ", count:rightLinkOffset)
//            + backSlash
//            + String(repeating:  uLine, count:rightLinkExtra)
//
//        // full link line (will be empty if there are no sub nodes)
//        let linkLine          = leftLink + rightLink
//
//        // will need to offset left side lines if right side sub nodes extend beyond left margin
//        // can happen if left subtree is shorter (in height) than right side subtree
//        let leftIndentWidth   = max(0,firstRightIndent - rightNodePosition)
//        let leftIndent        = String(repeating:" ", count:leftIndentWidth)
//        let indentedLeftLines = leftSubLines.map{ $0.isEmpty ? $0 : (leftIndent + $0) }
//
//        // compute distance between left and right sublines based on their value position
//        // can be negative if leading spaces need to be removed from right side
//        let mergeOffsets      = indentedLeftLines
//            .map{$0.count}
//            .map{leftIndentWidth + rightNodePosition - firstRightIndent - $0 }
//            .enumerated()
//            .map{ rightSubLines[$0].isEmpty ? 0  : $1 }
//
//
//        // combine left and right lines using computed offsets
//        //   * indented left sub lines
//        //   * spaces between left and right lines
//        //   * right sub line with extra leading blanks removed.
//        let mergedSubLines    = zip(mergeOffsets.enumerated(),indentedLeftLines)
//            .map{ ( $0.0, $0.1, $1 + String(repeating:" ", count:max(0,$0.1)) ) }
//            .map{ $2 + String(rightSubLines[$0].dropFirst(max(0,-$1))) }
//
//        // Assemble final result combining
//        //  * node value string
//        //  * link line (if any)
//        //  * merged lines from left and right sub trees (if any)
//        let treeLines = [leftIndent + valueLine]
//            + (linkLine.isEmpty ? [] : [leftIndent + linkLine])
//            + mergedSubLines
//
//        return (reversed && isTop ? treeLines.reversed(): treeLines)
//            .joined(separator:"\n")
//    }
//}


//: [Next](@next)






