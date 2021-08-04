//
//  EmojiThemeTracker.swift
//  Memorize
//
//  Created by Nicholas Steven Bassett on 8/4/21.
//

import SwiftUI

class EmojiThemeTracker: ObservableObject {
    @Published var currentTheme: ThemesForShop?
    @Published var previousThemeCheck: ThemesForShop?

    init(){
        self.currentTheme = nil
        self.previousThemeCheck = nil
    }

    
    func updateCurrentTheme(theme: ThemesForShop) {
        currentTheme = theme
    }
    
    func updatePreviousThemeCheck(theme: ThemesForShop) {
        previousThemeCheck = theme
    }
}
