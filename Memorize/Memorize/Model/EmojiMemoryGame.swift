//
//  EmojiMemoryGameViewModel.swift
//  Memorize
//
//  Created by Nicholas Steven Bassett on 6/29/21.
//

import SwiftUI




class EmojiMemoryGame: ObservableObject {
    
    static var themeSelected = 0
    
    typealias Card = MemoryGame<String>.Card
    private static let vehicleEmojis = ["🚂","🚀","🚁","🚜", "🚘", "🚌", "🛵", "🏍", "🚍",
    "🚛", "🛴", "🚊", "🚢", "🛺", "🚑", "🚲", "🚒", "🚕", "🚞", "🚐",
    "🚗", "🛫", "🛩", "🚓"]
    
    private static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfParisOfCards: 8) {
        pairIndex in vehicleEmojis[pairIndex]
        }
    }
    
    private static func getMemoryGameTheme(selectedTheme: Int) -> Themes {

        let emojiThemes = [
            Themes(themeId: 0, theme: "Animals", emojiContent: Themes.animalEmoji, cardPairCount: 4, themeColor: .orange),
            Themes(themeId: 1, theme:"Bugs", emojiContent: Themes.bugEmojis, cardPairCount: 8, themeColor: .red),
            Themes(themeId: 2, theme:"Food", emojiContent: Themes.foodEmojis, cardPairCount: 9, themeColor: .green),
            Themes(themeId: 3, theme:"Objects", emojiContent: Themes.objectEmojis, cardPairCount: 10, themeColor: .pink),
            Themes(themeId: 4, theme:"Sea Life", emojiContent: Themes.seaLifeEmojis, cardPairCount: 5, themeColor: .blue),
            Themes(themeId: 5, theme:"Vehicles", emojiContent: vehicleEmojis, cardPairCount: 7, themeColor: .purple)]
        
        return emojiThemes[selectedTheme]
        
    }

    
    @Published private var model = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card>{
        model.cards
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card: Card){
        model.choose(card)
    }
    
    func startNewGame(){
        model = EmojiMemoryGame.createMemoryGame()
            
    }
    
    func shuffle(){
        model.shuffle()
    }
    
    func restart(){
        model = EmojiMemoryGame.createMemoryGame()
    }
}
