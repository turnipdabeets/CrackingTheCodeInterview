import Foundation

public struct Graph<T> {
    public var root: GraphNode<T>
    
    public init(root: GraphNode<T>){
        self.root = root
    }
}

public class GraphNode<T> {
    public var children: [GraphNode]
    public var val: T
    public var visited = false
    
    public init(val: T, children: [GraphNode] = []){
        self.val = val
        self.children = children
    }
}
//
//public func createGraph() -> Graph {
//    
//}
