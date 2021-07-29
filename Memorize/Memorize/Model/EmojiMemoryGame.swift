//
//  EmojiMemoryGameViewModel.swift
//  Memorize
//
//  Created by Nicholas Steven Bassett on 6/29/21.
//

import SwiftUI


class EmojiMemoryGame: ObservableObject {
    
    var selectedTheme: ThemesForShop
    @Published var model: MemoryGame<String>
    
    typealias Card = MemoryGame<String>.Card
    
    
    init(selectedTheme: ThemesForShop) {
        self.selectedTheme = selectedTheme
        self.selectedTheme.emojis.shuffle()
        model = MemoryGame(numberOfParisOfCards: selectedTheme.numberOfPairs, createCardContent: { index in
            selectedTheme.emojis[index]
        })
    }

    
    var cards: Array<MemoryGame<String>.Card>{
        model.cards
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card: Card){
        model.choose(card)
    }
    
    var points: Int{
        model.points
    }
    
    func startNewGame(){
        selectedTheme.emojis.shuffle()
        model = MemoryGame(numberOfParisOfCards: selectedTheme.numberOfPairs, createCardContent: { index in
            selectedTheme.emojis[index]
        })
    }
    
    func shuffle(){
        model.shuffle()
    }
    
    func restart(){
        model = MemoryGame(numberOfParisOfCards: selectedTheme.numberOfPairs, createCardContent: { index in
            selectedTheme.emojis[index]
        })
        
    }
    


    
}
