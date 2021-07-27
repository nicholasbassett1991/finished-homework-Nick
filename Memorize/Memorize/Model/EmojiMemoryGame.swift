//
//  EmojiMemoryGameViewModel.swift
//  Memorize
//
//  Created by Nicholas Steven Bassett on 6/29/21.
//

import SwiftUI




class EmojiMemoryGame: ObservableObject {
    
    typealias Card = MemoryGame<String>.Card
    
    static private(set) var theme: ThemesForShop = EmojiStore.init(named: "Default").theme(at: 0)
    
    init(theme: ThemesForShop? = nil) {
        EmojiMemoryGame.theme = theme ?? EmojiStore.init(named: "Default").themes[0]
        
    }
    
    
    private static func createMemoryGame(theme: ThemesForShop) -> MemoryGame<String> {
//        let emojisShuffled = currentEmojiTheme.emojiContent.shuffled().uniqueElements()
//
//        return MemoryGame<String>(numberOfParisOfCards: currentEmojiTheme.cardPairCount) {
//            pairIndex in emojisShuffled[pairIndex]
//        }
        
        let emojisShuffled = theme.emojis.shuffled().uniqueElements()
        
        return MemoryGame<String>(numberOfParisOfCards: theme.numberOfPairs) {
            pairIndex in emojisShuffled[pairIndex]
        }
    }

    private static func changeEmojiMemoryGame(){
        currentEmojiTheme = theme
        currentEmojiColor = Color(hex:theme.color)
    }
        
    static var currentEmojiTheme: ThemesForShop = theme
    static var currentEmojiColor = Color(hex: theme.color)
    
        static let emojiThemes = [
            Themes(themeId: 0, theme: "Animals", emojiContent: ["🐱","🐶","🐹","🐰","🐻","🐼","🐮","🐵","🙈","🐥","🐣","🦉","🐽","🐺","🦊","🐷","🐸","🐭","🦇","🦄","🐝","🐗","🐴"], cardPairCount: 10, themeColor: "#FFA500"),
            
            Themes(themeId: 1, theme:"Bugs", emojiContent: ["🐝","🪱", "🐛","🦋","🐌","🐞","🐜","🪰","🪲","🪳","🦟","🦗","🕷","🕸","🦂"], cardPairCount: 8, themeColor: "#FF0000"),
            
            Themes(themeId: 2, theme:"Food", emojiContent: ["🥮","🍱","🥟","🍙","🍦","🥧","🍿","🍰","🍚","🍢","🍡","🍨","🍧"], cardPairCount: 6, themeColor: "#00FF00"),
            
            Themes(themeId: 3, theme:"Objects", emojiContent: ["🧯","📡","🪔","⚖️","📀","🕹","📱","⌚️","🪛","🔫","🗡","⚰️","📿","🔮","💊","🧽","💰","⏱"], cardPairCount: 8, themeColor: "#FFC0CB"),
            
            Themes(themeId: 4, theme:"Sea Life", emojiContent:  ["🐙","🐡","🐟","🦐","🦑","🦞","🦀","🐬","🐳","🦈","🦭","🐋","🐠"], cardPairCount: 5, themeColor: "#0000FF"),
            
            Themes(themeId: 5, theme:"Vehicles", emojiContent: ["🚂","🚀","🚁","🚜", "🚘", "🚌", "🛵", "🏍", "🚍","🚛", "🛴", "🚊", "🚢", "🛺", "🚑", "🚲", "🚒", "🚕", "🚞", "🚐",
                "🚗", "🛫", "🛩","🚓"], cardPairCount: 11, themeColor: "#800080")]
    
    


    @Published private var model = createMemoryGame(theme: theme)
    
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
        model = EmojiMemoryGame.createMemoryGame(theme: EmojiMemoryGame.theme)
    }
    
    func shuffle(){
        model.shuffle()
    }
    
    func restart(){
        model = EmojiMemoryGame.createMemoryGame(theme: EmojiMemoryGame.theme)
        
    }
    


    
}
