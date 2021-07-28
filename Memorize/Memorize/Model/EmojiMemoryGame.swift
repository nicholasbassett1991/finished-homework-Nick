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
//    static private(set) var theme: ThemesForShop = EmojiStore(named: "dragon").theme(at: EmojiStore.themeSelected)
//
//    init(theme: ThemesForShop? = nil) {
//        EmojiMemoryGame.theme = theme ?? EmojiStore(named: "dragon")
//            .themes[EmojiStore.themeSelected]
//    }
//
//
//    private static func createMemoryGame(theme: ThemesForShop) -> MemoryGame<String> {
//        print("MemeoryGame Created: \(theme)")
//
//        let emojisShuffled = currentEmojiTheme.emojis.shuffled().uniqueElements()
//
//        return MemoryGame<String>(numberOfParisOfCards: theme.numberOfPairs) {
//            pairIndex in emojisShuffled[pairIndex]
//        }
//    }

//    private static func changeEmojiMemoryGame(){
//        currentEmojiTheme = EmojiStore(named: "dragon").theme(at: 3)
//        currentEmojiColor = Color(hex: currentEmojiTheme.color)
//    }
//
//    static var currentEmojiTheme: ThemesForShop = theme
//    static var currentEmojiColor = Color(hex: theme.color)

//    @Published private var model = createMemoryGame(theme: currentEmojiTheme)
    
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
