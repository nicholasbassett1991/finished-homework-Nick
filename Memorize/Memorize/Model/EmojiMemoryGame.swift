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
        return MemoryGame<String>(numberOfParisOfCards: currentEmojiTheme.cardPairCount) {
            pairIndex in shuffleEmojisForGame(emojis: currentEmojiTheme.emojiContent, numberOfPairs: currentEmojiTheme.cardPairCount)[pairIndex]
        }
    }

    private static func changeEmojiMemoryGame(){
        let range = 0...5
        let emojiPicker = range.randomElement() ?? 0
        currentEmojiTheme = emojiThemes[emojiPicker]
        currentEmojiColor = Color(hex:currentEmojiTheme.themeColor)
    }
    
    
    static var currentEmojiTheme: Themes = emojiThemes[0]
    static var currentEmojiColor = Color(hex:currentEmojiTheme.themeColor)
    
        static let emojiThemes = [
            Themes(themeId: 0, theme: "Animals", emojiContent: ["🐱","🐶","🐹","🐰","🐻","🐼","🐮","🐵","🙈","🐥","🐣","🦉","🐽","🐺","🦊","🐷","🐸","🐭","🦇","🦄","🐝","🐗","🐴"], cardPairCount: 5, themeColor: "#FFA500"),
            
            Themes(themeId: 1, theme:"Bugs", emojiContent: ["🐝","🪱", "🐛","🦋","🐌","🐞","🐜","🪰","🪲","🪳","🦟","🦗","🕷","🕸","🦂"], cardPairCount: 5, themeColor: "#FF0000"),
            
            Themes(themeId: 2, theme:"Food", emojiContent: ["🥮","🍱","🥟","🍙","🍦","🥧","🍿","🍰","🍚","🍢","🍡","🍨","🍧"], cardPairCount: 5, themeColor: "#00FF00"),
            
            Themes(themeId: 3, theme:"Objects", emojiContent: ["🧯","📡","🪔","⚖️","📀","🕹","📱","⌚️","🪛","🔫","🗡","⚰️","📿","🔮","💊","🧽","💰","⏱"], cardPairCount: 8, themeColor: "#FFC0CB"),
            
            Themes(themeId: 4, theme:"Sea Life", emojiContent:  ["🐙","🐡","🐟","🦐","🦑","🦞","🦀","🐬","🐳","🦈","🦭","🐋","🐠"], cardPairCount: 5, themeColor: "#0000FF"),
            
            Themes(themeId: 5, theme:"Vehicles", emojiContent: ["🚂","🚀","🚁","🚜", "🚘", "🚌", "🛵", "🏍", "🚍","🚛", "🛴", "🚊", "🚢", "🛺", "🚑", "🚲", "🚒", "🚕", "🚞", "🚐",
                "🚗", "🛫", "🛩","🚓"], cardPairCount: 5, themeColor: "#800080")]
        
    static func shuffleEmojisForGame(emojis: [String], numberOfPairs: Int) -> Array<String> {
        
        var choppedDownEmojiArray = emojis.shuffled()
        let removalRange = numberOfPairs...emojis.count - 1
        
        var jhonson = choppedDownEmojiArray.uniqueElements()
        
        if choppedDownEmojiArray.count > numberOfPairs {
            jhonson.removeSubrange(removalRange)
        }
        
        return jhonson
    }
    
    
    @Published private var model = createMemoryGame(theme: currentEmojiTheme)
    
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
