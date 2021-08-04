//
//  EmojiMemoryGameViewModel.swift
//  Memorize
//
//  Created by Nicholas Steven Bassett on 6/29/21.
//

import SwiftUI


class EmojiMemoryGame: ObservableObject {
    var selectedTheme: ThemesForShop
    @Published var model: MemoryGame<String>? {
        didSet {
            saveTheGame()
        }
    }

    
    typealias Card = MemoryGame<String>.Card
    
    private var autoSaveIdentifier : String {
        selectedTheme.name
    }
    
    private func saveTheGame() {
        UserDefaults.standard.set(try? JSONEncoder().encode(model), forKey: autoSaveIdentifier)
    }
    
    private func restoreTheGame() {
        if let jsonData = UserDefaults.standard.data(forKey: autoSaveIdentifier),
           let modelFromSave = try? JSONDecoder().decode(MemoryGame<String>.self, from: jsonData) {
            model = modelFromSave
        } else {
            model = MemoryGame(numberOfParisOfCards: selectedTheme.numberOfPairs ?? selectedTheme.emojis.count) { index in
                selectedTheme.emojis[index]
                }
            }
    }
    

    init(selectedTheme: ThemesForShop) {
        self.selectedTheme = selectedTheme
        self.selectedTheme.emojis.shuffle()
        restoreTheGame()
    }



    
    var cards: Array<MemoryGame<String>.Card>{
        model!.cards
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card: Card){
        model!.choose(card)

    }
    
    var points: Int{
        model!.points
    }
    
    
    func startNewGame(){
        selectedTheme.emojis.shuffle()
        model = MemoryGame(numberOfParisOfCards: selectedTheme.numberOfPairs  ?? selectedTheme.emojis.count, createCardContent: { index in
            selectedTheme.emojis[index]
        })
    }
    
    func shuffle(){
        model!.shuffle()
    }
    
    func restart(){
        model = MemoryGame(numberOfParisOfCards: selectedTheme.numberOfPairs  ?? selectedTheme.emojis.count, createCardContent: { index in
            selectedTheme.emojis[index]
        })
        
    }
    


    
}
