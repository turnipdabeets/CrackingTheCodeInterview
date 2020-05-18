//: [Previous](@previous)

import Foundation

// ## Topological sort

//: ### You are given a list of projects and a list of dependencies (which is a list of pairs of projects, where the second project is dependent on the first project). All of the projects's dependencies must be built before the project is. Find a build order that will allow the project to be built. If there is no valid order, return an error.

//: Example:
//: - Projects:  a,b,c,d,e,f
//: - Dependencies: (a,d), (f,b), (b,d), (f,a), (d,c)
//: - Output: f,e,a,b,d,c

//: Adjacency List, also check out Alien Dictionary

// https://www.raywenderlich.com/773-swift-algorithm-club-graphs-with-adjacency-list

func buildOrder(_ projects: [String], deps: [(String, String)]) -> String {
    var adjacenyList = [String: [String]]()
    var incomingCount = [String: Int]()
    var queue = [String]()
    var order = ""
    
    // init with all projects
    for project in projects {
        adjacenyList[project] = []
        incomingCount[project] = 0
    }
    
    // fill in graph representation
    for dep in deps {
        adjacenyList[dep.0, default: []].append(dep.1)
        incomingCount[dep.1, default: 0] += 1
    }
    
    // init queue with root nodes
    queue = incomingCount.reduce(into: []){ (array, node) in
        if node.value == 0 {
            array.append(node.key)
        }
    }
    
    while !queue.isEmpty {
        let dep = queue.removeFirst()
        order.append(contentsOf: dep)
        
        // subtract one from children and if child is a root then add to queue
        if let children = adjacenyList[dep] {
            children.forEach { child in
                // weve build a dep, decrement the child's totoal deps count
                incomingCount[child, default: 0] -= 1
                if let count = incomingCount[child], count == 0 {
                    queue.append(child)
                }
            }
        }
    }
    
    // check for any loops by way of missing nodes that didn't get added to the queue
    return order.count == projects.count ? order : ""
}


//: Alternative is to use DFS, same time complexity but need to mark nodes with "graph coloring" to check for cycles

func buildOrderDFS(_ projects: [String], deps: [(String, String)]) -> String {
    var adjacenyList = [String: [String]]()
    var order = ""
    
    // use "graph coloring" to detect cycles, False = grey, True = black
    var seen = [String: Bool]()
    
    // put all unique letters into the adj list.
    for project in projects {
        adjacenyList[project] = []
    }
    
    // if we made a reverse adjacency list instead of a forward one, the output order would be correct (without needing to be reversed) since DFS is reversed
    for dep in deps {
        adjacenyList[dep.1, default: []].append(dep.0)
    }
    
    func DFS(_ project: String) -> Bool {
        // if this color was grey (false), a cycle was detected. black is ok we already took care of it
        if let color = seen[project] {
            return color
        }
        
        // mark as grey
        seen[project] = false
                
        if let children = adjacenyList[project] {
            for child in children {
                if !DFS(child){
                    return false // cycle detected lower down
                }
            }
        }
        
        // mark as black
        seen[project] = true
        
        order += project
        return true
    }
    
    for project in adjacenyList {
        if !DFS(project.key){
            return ""
        }
    }

    // check for any loops by way of missing nodes that didn't get added to the queue
    return order.count == projects.count ? order : ""
}

buildOrder(["a","b","c","d","e","f"], deps: [("a","d"), ("f","b"), ("b","d"), ("f","a"), ("d","c")])

buildOrderDFS(["a","b","c","d","e","f"], deps: [("a","d"), ("f","b"), ("b","d"), ("f","a"), ("d","c")])

//: [Next](@next)
