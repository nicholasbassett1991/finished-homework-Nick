//
//  EmojiMemoryGameViewModel.swift
//  Memorize
//
//  Created by Nicholas Steven Bassett on 6/29/21.
//

import SwiftUI




class EmojiMemoryGame: ObservableObject {
    
    var themeSelected = 0
    
    typealias Card = MemoryGame<String>.Card
    private static let emojis = ["🚂","🚀","🚁","🚜", "🚘", "🚌", "🛵", "🏍", "🚍",
    "🚛", "🛴", "🚊", "🚢", "🛺", "🚑", "🚲", "🚒", "🚕", "🚞", "🚐",
    "🚗", "🛫", "🛩", "🚓"]
    
    private static func createMemoryGame() -> MemoryGame<String> {    MemoryGame<String>(numberOfParisOfCards: 8) { pairIndex in emojis[pairIndex]
        }
    }
    
    private static func getMemoryGameTheme() -> Themes<Theme> {
        
    }
    private static let emojiThemes = [
        Themes(theme: "Animals", emojiContent: animalEmoji, cardPairCount: 4, themeColor: .orange),
        Themes(theme:"Bugs", emojiContent: bugEmojis, cardPairCount: 8, themeColor: .red),
        Themes(theme:"Food", emojiContent: foodEmojis, cardPairCount: 9, themeColor: .green),
        Themes(theme:"Objects", emojiContent: objectEmojis, cardPairCount: 10, themeColor: .pink),
        Themes(theme:"Sea Life", emojiContent: seaLifeEmojis, cardPairCount: 5, themeColor: .blue),
        Themes(theme:"Vehicles", emojiContent: emojis, cardPairCount: 7, themeColor: .purple)]
    
    @Published private var model = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card>{
        model.cards
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card: Card){
        
        model.choose(card)
    }
    
    func shuffle(){
        model.shuffle()
    }
    
    func restart(){
        model = EmojiMemoryGame.createMemoryGame()
    }
}
