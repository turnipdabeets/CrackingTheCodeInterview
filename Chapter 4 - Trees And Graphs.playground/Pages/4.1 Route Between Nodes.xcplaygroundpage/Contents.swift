//: [Previous](@previous)

import Foundation

//: ### Given a direct graph, design an algorithm to find out whether there is a route between two nodes.

//: Directed graphs are like one way streets which means if there is a path we just need to traverse and if we find it then return true. When you are looking for the shortest path, or any path BFD is usually best because it searchs neighbors before searching the "whole world".

//: Mark nodes as visited to avoid infinite loops, we could also check for `to` node in the forEach to terminate slightly earlier if we want

func hasRouteBFS<T>(from: GraphNode<T>, to: GraphNode<T>, in graph: Graph<T>) -> Bool {
    if from === to { return true }
    
    var queue = Queue<GraphNode<T>>()
    queue.enqueue(graph.root)
    
    var hasFirst = false
    
    while !queue.isEmpty {
        if let node = queue.dequeue() {
            print(node.val)
            if !hasFirst && node === from { hasFirst = true }
            if hasFirst && node === to {
                return true
            }
            
            if !node.visited {
                node.visited = true
                node.children.forEach{ queue.enqueue($0) }
            }
        }
        
    }
    
    return false
}

//: DFS example. Note we need to be able to both return a Bool and Void to pop off the stack. Since this isn't possible like it might be in JavaScript we need to create a closure to capture the result. This is similar to LinkedList exercise 2.6

func hasRouteDFS<T>(from: GraphNode<T>, to: GraphNode<T>, in graph: Graph<T>) -> Bool {
    var result = false

    DFS(from: from, to: to, current: graph.root) {
        result = true
    }
    return result
}

func DFS<T>(from: GraphNode<T>, to: GraphNode<T>, current: GraphNode<T>?, seenFirst: Bool = false, apply: @escaping () -> Void) {
    guard let current = current else { return  }
    
    current.visited = true

    if seenFirst && current === to {
        apply()
        return
    }

    for node in current.children where !node.visited {
        let seen = seenFirst || current === from
        DFS(from: from, to: to, current: node, seenFirst: seen, apply: apply)
    }
    return
}

func printDFS<T>(_ node: GraphNode<T>?) {
    guard let node = node else { return }
    node.visited = true
    print(node.val)

    node.children.forEach {
        if !$0.visited {
            printDFS($0)
        }
    }
}

let n4 = GraphNode<String>(val: "D")
let n3 = GraphNode<String>(val: "C", children: [n4])
let n2 = GraphNode<String>(val: "B", children: [n3])
let n6 = GraphNode<String>(val: "L")
let n5 = GraphNode<String>(val: "H", children: [n6])
let n1 = GraphNode<String>(val: "A", children: [n2, n5])

let graph = Graph<String>(root: n1)

//hasRouteBFS(from: n1, to: n3, in: graph)
//hasRouteDFS(from: n1, to: n6, in: graph)
printDFS(graph.root)

//: [Next](@next)
