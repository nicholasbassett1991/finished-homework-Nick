//
//  EmojiMemoryGameViewModel.swift
//  Memorize
//
//  Created by Nicholas Steven Bassett on 6/29/21.
//

import SwiftUI




class EmojiMemoryGame: ObservableObject {
    
    
    typealias Card = MemoryGame<String>.Card
    
 
    private static func createMemoryGame(theme: Themes) -> MemoryGame<String> {
        MemoryGame<String>(numberOfParisOfCards: theme.cardPairCount) {
            pairIndex in currentEmojiTheme.emojiContent[pairIndex]
        }
    }


    
    private static func changeEmojiMemoryGame(){
        let range = 0...5
        let emojiPicker = range.randomElement() ?? 0
        currentEmojiTheme = emojiThemes[emojiPicker]
    }
    
    static var currentEmojiTheme: Themes = emojiThemes[0]

 
        static let emojiThemes = [
            Themes(themeId: 0, theme: "Animals", emojiContent: Themes.animalEmoji, cardPairCount: 10, themeColor: .orange),
            Themes(themeId: 1, theme:"Bugs", emojiContent: Themes.bugEmojis, cardPairCount: 7, themeColor: .red),
            Themes(themeId: 2, theme:"Food", emojiContent: Themes.foodEmojis, cardPairCount: 6, themeColor: .green),
            Themes(themeId: 3, theme:"Objects", emojiContent: Themes.objectEmojis, cardPairCount: 8, themeColor: .pink),
            Themes(themeId: 4, theme:"Sea Life", emojiContent: Themes.seaLifeEmojis, cardPairCount: 5, themeColor: .blue),
            Themes(themeId: 5, theme:"Vehicles", emojiContent: Themes.vehicleEmojis, cardPairCount: 4, themeColor: .purple)]
        



    @Published private var model = createMemoryGame(theme: currentEmojiTheme)
    
    var cards: Array<MemoryGame<String>.Card>{
        model.cards
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card: Card){
        model.choose(card)
    }
    
    func points(){
        model.points
    }
    
    func startNewGame(){
        EmojiMemoryGame.changeEmojiMemoryGame()
        model = EmojiMemoryGame.createMemoryGame(theme: EmojiMemoryGame.currentEmojiTheme)
    }
    
    func shuffle(){
        model.shuffle()
    }
    
    func restart(){
        model = EmojiMemoryGame.createMemoryGame(theme: EmojiMemoryGame.currentEmojiTheme)
        
    }
    


    
}
