import Foundation

/*:
 - A heap (min or max) is a complete binary tree, meaning it fills all elements other than maybe the right most on the last level.
 - A min heap holds the minimum element on top
 - A max heap holds the maximum element on top
 - A Heap is a Binary tree, but since it is "complete" it can be represented as an Array
 - As an array the root node will always be at index 0
 - As an array we can access a node's parent with its (index - 1) / 2
 - As an array we can access a node's left child with (2 * index) + 1
 - As an array we can access a node's right child with (2 * index) + 2
 - Insertions and Removal has a time complexity of O(log N) time but grabbing the priority element on top is O(N)
 - A Priority Queue is an abstract data structure that is usually implemented with a Heap
 - A nice visualiztaion: https://www.cs.usfca.edu/~galles/JavascriptVisual/Heap.html
*/

public struct Heap<T:Comparable> {
    private var queue = [T]()
    
    // generalized so that we can have min or max heap
    let priority: (T, T) -> Bool
    
    public var isEmpty: Bool {
        return queue.isEmpty
    }
    
    public var count : Int {
      return queue.count
    }
    
    public var peek: T? {
        return queue.first
    }
    
    public init(_ priority: @escaping (T, T) -> Bool){
        self.priority = priority
    }
    
    public mutating func insert(_ item: T) {
        queue.append(item)
        bubbleUp()
    }
    
    public mutating func extract() -> T? {
        guard !queue.isEmpty else { return nil }
        queue.swapAt(0, queue.endIndex - 1)
        let initial = queue.removeLast()
        if !queue.isEmpty { bubbleDown(0) }
        return initial
    }
    
    private mutating func bubbleUp() {
        var index = queue.endIndex - 1
        while hasParent(index) && priority(queue[index], queue[getParentIndex(index)]) {
            let parentIndex = getParentIndex(index)
            queue.swapAt(parentIndex, index)
            index = parentIndex
        }
    }
    
    private mutating func bubbleDown(_ index: Int) {
        guard let higherPriorityIndex = getHigherPriorityIndex(index) else { return }
        queue.swapAt(higherPriorityIndex, index)
        bubbleDown(higherPriorityIndex)
    }
    
    private func getHigherPriorityIndex(_ index: Int) -> Int? {
       let current = queue[index]
        
       if let left = leftChild(index), let right = rightChild(index) {
            if priority(left, right) && priority(left, current) {
                return getLeftChildIndex(index)
            }
            
            if priority(right, left) && priority(right, current) {
                return getRightChildIndex(index)
            }
        }
        
        if let left = leftChild(index), priority(left, current) {
            return getLeftChildIndex(index)
        }
        
        if let right = rightChild(index), priority(right, current) {
            return getRightChildIndex(index)
        }
        
        return nil
    }
    
    private func hasParent(_ childIndex: Int) -> Bool {
        return getParentIndex(childIndex) >= 0
    }
    
    private func getParentIndex(_ childIndex: Int) -> Int {
        return (childIndex - 1) / 2
    }
    
    private func leftChild(_ parentIndex: Int) -> T? {
        guard getLeftChildIndex(parentIndex) < queue.count else { return nil }
        return queue[getLeftChildIndex(parentIndex)]
    }
    
    private func rightChild(_ parentIndex: Int) -> T? {
        guard getRightChildIndex(parentIndex) < queue.count else { return nil }
        return queue[getRightChildIndex(parentIndex)]
    }
    
    private func getLeftChildIndex(_ parentIndex: Int) -> Int {
        return (2 * parentIndex) + 1
    }

    private func getRightChildIndex(_ parentIndex: Int) -> Int {
        return (2 * parentIndex) + 2
    }
}
