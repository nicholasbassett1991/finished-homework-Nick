//
//  MemoryGameModel.swift
//  Memorize
//
//  Created by Nicholas Steven Bassett on 6/29/21.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable{
    
    private(set) var cards: Array<Card>
    
    private(set) var points: Int = 0
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
    get {cards.indices.filter({cards[$0].isFaceUp}).oneAndOnly }
    set {cards.indices.forEach{cards[$0].isFaceUp = ($0 == newValue) } }
    }
    
    mutating func choose(_ card: Card) {
    
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id}), !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched
        {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    if cards[chosenIndex].hasBeenSeen && cards[potentialMatchIndex].hasBeenSeen{
                        addPoints(points: 1)
                    }
                    else if cards[chosenIndex].hasBeenSeen == false && cards[potentialMatchIndex].hasBeenSeen == false {
                            addPoints(points: 3)
                        }
                    else {
                        addPoints(points: 2)
                    }
                }
                cards[chosenIndex].isFaceUp = true
                cards[chosenIndex].hasBeenSeen = true
                subtractPoints(points: points, cardOne: cards[chosenIndex], cardTwo: cards[potentialMatchIndex])
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
    
    }
    
    mutating func shuffle(){
        cards.shuffle()
    }
    
    mutating func addPoints(points:Int){
        self.points += points
    }
    
    mutating func subtractPoints(points:Int, cardOne: Card, cardTwo: Card){
        if cardOne.hasBeenSeen && cardTwo.hasBeenSeen  {
            addPoints(points: -2)
        }
    }

    init(numberOfParisOfCards: Int, createCardContent: (Int) -> CardContent){
        cards = []

        for pairIndex in 0..<numberOfParisOfCards {
            let content: CardContent = createCardContent(pairIndex)
            cards.append(Card(content:content, id:pairIndex*2))
            cards.append(Card(content:content, id:pairIndex*2+1))
        }
        cards.shuffle()
        
    }
    
    struct Card: Identifiable {
    
        var hasBeenSeen = false
        
        var isFaceUp = true {
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        var isMatched = false {
            didSet {
                stopUsingBonusTime()
            }
        }
        let content: CardContent
        let id: Int
        
    
        var bonusTimeLimit: TimeInterval = 6

        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = self.lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }

        var lastFaceUpDate: Date?

        var pastFaceUpTime: TimeInterval = 0

        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }

        var bonusRemaining: Double {
                (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining/bonusTimeLimit : 0
            }

        var hasEarnedBonus: Bool {
            isMatched && bonusTimeRemaining > 0
        }

        var isConsumingBonusTime: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }

        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }

        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            self.lastFaceUpDate = nil
            
        }
    }
}

extension Array {
    var oneAndOnly: Element? {
        if count == 1 {
        return first
    } else {
        return nil
    }
    }
    
    //Mark - Bonus Time

}

