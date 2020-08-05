//: [Previous](@previous)

import Foundation

//: ### Explain the data structures and alogrithms the you would use to design an in-memory file system. Illustrate with an example in code where possible.

// - Use a tree!
// - keep pointer reference to root and user
// - Desktop may save a pointer to files in the root tree
// - permisisons?


class FileType {
    // could make private(set) vars and add getter setter funcs
    var dateAccessed: Date
    var dateCreated: Date
    var dateModified: Date
    var name: String
    var parent: Directory?
    
    init(dateAccessed: Date, dateCreated: Date, dateModified: Date, name: String, parent: Directory?){
        self.dateAccessed = dateAccessed
        self.dateCreated = dateCreated
        self.dateModified = dateModified
        self.name = name
        self.parent = parent
    }
    
    func getFullPath() -> String {
        guard let parent = parent else { return name }
        print(name)
        return parent.getFullPath() + "/" + name
    }
    
    func delete(){
        parent?.removeContent(self)
    }
    
}


class Directory: FileType {
    private(set) var contents: [FileType] = []
    
    init(name: String, parent: Directory?){
        super.init(dateAccessed: Date(), dateCreated: Date(), dateModified: Date(), name: name, parent: parent)
    }
    
    func addContent(_ content: FileType) -> Directory {
        content.parent = self
        contents.append(content)
        if let directory = content as? Directory { return directory}
        return self
    }
    
    func removeContent(_ content: FileType) -> Directory {
        // maybe have id and find index and then remove at index
        contents.removeAll(where: { $0.name == content.name})
        return self
    }
    
    func numberOfFiles() -> Int {
        var count = 0
        for content in contents {
            if let _ = content as? File {
                count += 1
            }
        }
        return count
    }
}

class File: FileType {
    var data: Data
    
    /// The number of bytes in the data.
    var size: Int {
        return data.count
    }
    
    init(data: Data, name: String, parent: Directory?){
        self.data = data
        super.init(dateAccessed: Date(), dateCreated: Date(), dateModified: Date(), name: name, parent: parent)
    }
}

let root = Directory(name: "root", parent: nil)

let user = Directory(name: "anna", parent: nil)
let develop = Directory(name: "develop", parent: nil)
let myFile = File(data: Data(), name: "my file", parent: nil)
let deleteThisFile = File(data: Data(), name: "deleteMe", parent: nil)

let developDirectory = root
        .addContent(user)
        .addContent(develop)
        .addContent(myFile)
        .addContent(deleteThisFile)

developDirectory.contents.count
developDirectory.contents.first?.getFullPath()
developDirectory.contents[1].getFullPath()

developDirectory.contents[1].delete()
developDirectory.contents.count

//: [Next](@next)
