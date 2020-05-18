import Foundation

public class ListNode<T> {
    public var val: T
    public var next: ListNode? = nil
    public init(_ val: T) {
        self.val = val
    }
}

public struct LinkedList<T> {
    private var head: ListNode<T>?
    private var tail: ListNode<T>?
    
    public var isEmpty: Bool {
        return head == nil && tail == nil
    }
    
    public var first: T? {
        return head?.val
    }
    
    public mutating func append(_ item: T){
        let node = ListNode(item)
        if let tail = tail {
            tail.next = node
        }else {
            head = node
        }
        tail = node
    }
    
    public mutating func removeFirst() -> T? {
        guard let _ = head else { return nil }
            let item = head!.val
        if tail === head {
            head = nil
            tail = nil
        }else {
            head = head!.next
        }
        
        return item
    }
}

//MARK: LL printing helpers:

public func printList<T>(_ node: ListNode<T>?) {
    guard let node = node else { return }
    print(node.val)
    printList(node.next)
}

public func makeLL(_ str: String) -> ListNode<String>? {
    guard let first = str.first else { return nil }
    let node = ListNode<String>(String(first))
    let newNode = makeLL(String(str[str.index(after: str.startIndex)..<str.endIndex]))
    node.next = newNode
    return node
}

public func printLL<T>(_ node: ListNode<T>){
    var current: ListNode? = node
    print(current!.val)
    while(current != nil) {
        guard let next = current!.next else { break }
        print(next.val)
        current = next
    }
}

public func RP<T>(_ node: ListNode<T>?, apply: @escaping (_ node: ListNode<T>)-> Void) {
    guard let node = node else { return }
    apply(node)
    RP(node.next, apply: apply)
}

public func printLast<T>(_ node: ListNode<T>, target: Int) -> (_ node: ListNode<T>)-> Void {
    var count = 0
    return { n in
        count += 1
        if count == target {
            print(n.val, "C", count)
        }
    }
}
