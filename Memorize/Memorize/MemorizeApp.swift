//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Nicholas Steven Bassett on 6/29/21.
//

import SwiftUI

@main
struct MemorizeApp: App {
    @StateObject var emojiStore = (EmojiStore(named: "dragon god"))
    @StateObject var game = EmojiMemoryGame(selectedTheme: EmojiStore(named: "dragon god").theme(at: 0))
    @StateObject var themeTracker = EmojiThemeTracker()
    
    var body: some Scene {
        WindowGroup {
            HomeScreen(game: game, themeChecker: themeTracker)
                .environmentObject(emojiStore)

        }
    }
}
