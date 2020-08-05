//: [Previous](@previous)

import Foundation
import UIKit

//: ### Explain how you would design a chat server. In particular, provide details about the various backend components, classes, and methods. What would be the hardest problems to solve?

/*
 User signs on and connects websocket
 Client GETs any previous chat messages to display
 User sends message POST to server.
 POST includes userID, channelID and message payload
 Server receives payload and saves in SQL DB
 Sever sends message to clients connected to channel via websocket
 */

/*
 Problems:
    - serve scalability and security/ DOS attacks
    - out of sync messages, server receives message at timestamp and sends to other clients based on the servers timestamp but may vary slightly when user signs back on and gets messages from DB
    - how do we know if someone is online? ping cleint regularily?
 */

struct User {
    let icon: UIImage
    let id: ID<User>
    let friends: [User]
    let name: String
}

struct Channel {
    let icon: UIImage
    let id: ID<Channel>
    let members: [User]
    let name: String
}

//: [Next](@next)
