//: [Previous](@previous)

import Foundation

//: ### Othello is played as follows: Each Othello piece is white on one side and black on the other. When a piece is surrounded by its opponents on both the left and right sides, or both the top and bottom, it is said to be captured and its color is flipped. On your turn, you must capture at least one of your opponent's pieces. The game ends when either user has no more valid moves. The win is assigned to the person with the most pieces. Implement the object-oriented design for Othello.

//: [Next](@next)

enum Color { case black, white }

class Piece {
    var color: Color
    
    init(color: Color){
        self.color = color
    }
    
    func flipColor(){
        switch color {
        case .black:
            color = .white
        case .white:
            color = .black
        }
    }

}

class Player {
    var pieces: [Piece] = []
    let team: Color
    let game: Game
    
    init(color: Color, game: Game) {
        team = color
        self.game = game
    }
    
    func move(_ piece: Piece, direction: Direction){
        game.move(piece, direction: direction)
    }
}

enum Direction {case left, up, right, down}

class Game {
    let players: [Player]
    private(set) var board: [[Piece]] = []
    
    var hasValidMoves: Bool {
        //check either players has valid move
        return true
    }
    
    var winner: Player? {
        // could also just keep a black and white count
        if hasValidMoves == false {
            return (players.first?.pieces.count)! > players[1].pieces.count ? players.first : players[1]
        }
        return nil
    }
    
    init(players: [Player]){
        // make sure has 2 players only
        self.players = players
        // init board size with pieces
    }
    
    func move(_ piece: Piece, direction: Direction){}
    
    func hasCapture(_ piece: Piece) -> Bool { return true }
    
    func reassign(_ piece: Piece, from player1: Player, to player2: Player) {
        remove(piece, from: player1)
        add(piece, to: player2)
    }
    
    private func add(_ piece: Piece, to player: Player){
       player.pieces.append(Piece(color: .black))
    }
    
    private func remove(_ piece: Piece, from player: Player){
        guard let index = player.pieces.firstIndex(where: { $0 === piece }) else { return }
        player.pieces.remove(at: index)
    }
    
}
