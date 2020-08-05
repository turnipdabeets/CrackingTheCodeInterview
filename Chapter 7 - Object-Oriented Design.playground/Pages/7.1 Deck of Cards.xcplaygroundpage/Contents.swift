//: [Previous](@previous)

import Foundation

//: ### Design a data structure for a generic deck of cards. Explain how you would subclass the data structure to implement blackjack.

enum Suit {
    case club, diamond, heart, spade
}

enum FaceValue: Int {
    case one, two, three, four, five, six, seven, eight, nine, ten, jack, queen, king, ace
}

struct Card {
    let suit: Suit
    let faceValue: FaceValue
}

struct Deck {
    let cards: [Card]
    private var dealtIndex: Int = 0
    
    var currentCard: Card {
        return cards[dealtIndex]
    }
    
    func dealCard(){ /*...*/ }
    func shuffle(){ /*...*/ }
}

class Hand {
    var cards: [Card]
    var score: Int = 0
    
    init(cards: [Card]) {
        self.cards = cards
    }
    
    func addCard(_ card: Card){ cards.append(card) }
    func useCard(){ /*...*/ }
    func setScore(){ /*...*/ }
}

// BlackJack example overriding Hand func, property and extending Card

extension Card {
    var value: Int {
        switch self.faceValue {
        case .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .ten:
            return faceValue.rawValue + 1
        case .jack, .queen, .king:
            return 10
        case .ace:
            return 11
        }
    }
}

class BlackJackHand: Hand {
    
    override func setScore() {
        let scores = possibleScores()
        var maxUnder: Int = Int.min
        var minOver: Int = Int.max
        
        for score in scores {
            if score > 21 && score < minOver {
                minOver = score
            } else if score <= 21 && score > maxUnder {
                maxUnder = score
            }
        }
        
        // need a way to get closest to 21 not just favor maxUnder
        score = maxUnder == Int.min ? minOver : maxUnder
    }
    
    func isBlackJack(){ /*...*/ }
    
    private func possibleScores() -> [Int] {
        // evaluate all card with ace being 1 or 11
        // below doesn't work becasue we need to consider 2 aces only hand
        // but just to show override setScore() and assigning score from Hand
        var scores = [Int]()
        let score = cards.filter { $0.faceValue != .ace }.map(\.value)
        let aces = cards.filter { $0.faceValue == .ace }
        
        if !aces.isEmpty {
            aces.forEach { _ in
                let score = score.first ?? 0
                scores.append(score + 1)
                scores.append(score + 11)
            }
        }else {
            scores.append(score.first ?? 0)
        }
        
        return [22, 12]//scores
    }
}

let b = BlackJackHand(cards: [
    Card(suit: .heart, faceValue: .ace),
    Card(suit: .heart, faceValue: .ace)]
)
b.setScore()
b.score
