//: [Previous](@previous)

import Foundation

//: ### Design a musical jukebox using object-oriented principles

// Assume Jukebox is free

struct ID<T>: ExpressibleByStringLiteral {
    let string: String
    
    init(stringLiteral value: String) {
        string = value
    }
}


struct Song {
    // id, title, length, artists
}

struct Record {
    let songlist: [Song]
    let id: ID<Record>
    // title, band, totalLength
}

class JukeBox {
    let records: [Record]
    var songQueue = [Song]()
    
    init(records: [Record]){
        self.records = records
    }
    
    func selectSong(_ song: Song){
        songQueue.append(song)
    }
    
    // song completed remove from quue
    // pick song add to queue
    // can we stop a song or shuffle or only select and it plays queue in order
    
}

class PlayList {
    // possibly to manage the songQueue
}

//: [Next](@next)
