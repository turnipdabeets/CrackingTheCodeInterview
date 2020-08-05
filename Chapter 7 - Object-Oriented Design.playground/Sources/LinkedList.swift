public class ListNode<T> {
    public var val: T
    public var next: ListNode? = nil
    public init(_ val: T) {
        self.val = val
    }
}

public struct LinkedList<T> {
    public var head: ListNode<T>? = nil
    public var tail: ListNode<T>? = nil
    
    public init(){}
    
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
