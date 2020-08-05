//: [Previous](@previous)

import Foundation

//: ### Design a parking lot using object-oriented principles

class ParkingLot {
    let ticketDispenser: TicketHandler
    let level: [ParkingLevel]
    
    init(ticketDispenser: TicketHandler, level: [ParkingLevel]){
        self.ticketDispenser = ticketDispenser
        self.level = level
    }
    
}

class ParkingLevel {
    let name: String
    var spots: [ParkingSpot]
    
    var availableSpots: Int {
        spots.filter({!$0.isOccupied}).count
    }
    
    init(name: String, spots: [ParkingSpot]){
        self.name = name
        self.spots = spots
    }
    
    func park(at index: Int) {
        spots[index].isOccupied = true
    }
    
    func spotFreed(at index: Int) {
        spots[index].isOccupied = false
    }
}

enum VehicleType { case car, bike, bus }

struct ParkingSpot {
    let name: String
    let isReserved: Bool
    var isOccupied: Bool
    let size: VehicleType
}

class TicketHandler {
    let priceTable: [Int: Decimal]
    
    init(priceTable: [Int: Decimal]) {
        self.priceTable = priceTable
    }
    
    func getPrice(_ ticket: Ticket) -> Decimal {
        let duration = ticket.timeStamp.timeIntervalSinceNow
        // use diration to return money
        return 5.00
    }
}

struct Ticket {
    let timeStamp: Date
}


//: [Next](@next)
