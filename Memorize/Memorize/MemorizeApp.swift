//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Nicholas Steven Bassett on 6/29/21.
//

import SwiftUI

@main
struct MemorizeApp: App {
    @StateObject var emojiStore = (EmojiStore(named: "dragon"))
    
    var body: some Scene {
        WindowGroup {
            HomeScreen()
                .environmentObject(emojiStore)
        }
    }
}
