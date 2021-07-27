//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Nicholas Steven Bassett on 6/29/21.
//

import SwiftUI

@main
struct MemorizeApp: App {
    private let game = EmojiMemoryGame()
    @StateObject var emojiStore = (EmojiStore(named: "Default"))
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
                .environmentObject(emojiStore)
        }
    }
}
