//
//  EmojiStore.swift
//  Memorize
//
//  Created by Nicholas Steven Bassett on 7/26/21.
//


import SwiftUI

class EmojiStore: ObservableObject {
    let name: String
    static var themeSelected = 1
    
    @Published var themes = [ThemesForShop]() {
    didSet {
    storeInUserDefaults()
        }
    }
    
    private var userDefaultsKey: String {
        "EmojiShop:" + name
    }
    
    private func storeInUserDefaults() {
        UserDefaults.standard.set(try? JSONEncoder().encode(themes), forKey: userDefaultsKey)
    }
    
    private func restoreFromUserDefaults() {
        if let jsonData = UserDefaults.standard.data(forKey: userDefaultsKey),
           let decodedThemes = try? JSONDecoder().decode(Array<ThemesForShop>.self, from: jsonData) {
            themes = decodedThemes
        }
    }
    
    init(named name: String) {
        self.name = name
        restoreFromUserDefaults()
        if themes.isEmpty {
            insertTheme(named: "Animals", emojis: ["🐱","🐶","🐹","🐰","🐻","🐼","🐮","🐵","🙈","🐥","🐣","🦉","🐽","🐺","🦊","🐷","🐸","🐭","🦇","🦄","🐗","🐴"], color: "#FFA500", numberOfPairs: 3)
            insertTheme(named: "Bugs", emojis: ["🐝","🪱", "🐛","🦋","🐌","🐞","🐜","🪰","🪲","🪳","🦟","🦗","🕷","🕸","🦂"], color: "#FF0000", numberOfPairs: 3)
            insertTheme(named: "Food", emojis: ["🥮","🍱","🥟","🍙","🍦","🥧","🍿","🍰","🍨","🍚","🍢","🍡","🍨","🍧"],color: "#00FF00", numberOfPairs: 3)
            insertTheme(named: "Objects", emojis: ["🧯","📡","🪔","⚖️","📀","🕹","📱","⌚️","🪛","🔫","🗡","⚰️","📿","🔮","💊","🧽","💰","⏱"], color: "#FFC0CB", numberOfPairs: 3)
            insertTheme(named: "Sea Life", emojis: [
                                    "🐙","🐡","🐟","🦐","🦑","🦞","🦀","🐬","🐳","🦈","🦭","🐋","🐠"], color: "#0000FF", numberOfPairs: 3)
            insertTheme(named: "Vehicles", emojis: ["🚂","🚀","🚁","🚜", "🚘", "🚌", "🛵", "🏍", "🚍","🚛", "🛴", "🚊", "🚢", "🛺", "🚑", "🚲", "🚒", "🚕", "🚞","🚐","🚗", "🛫", "🛩", "🚓"], color: "#800080", numberOfPairs: 3)
        }
    }
    
    
    
    func theme(at index: Int) -> ThemesForShop {
        let safeIndex = min(max(index, 0), themes.count - 1)
        return themes[safeIndex]
    }
    
    @discardableResult
    func removeTheme(at index: Int) -> Int {
        if themes.count > 1, themes.indices.contains(index) {
            themes.remove(at: index)
        }
        return index % themes.count
    }
    
    func insertTheme(named name: String, emojis: [String]? = nil, color: String, numberOfPairs: Int, at index: Int = 0) {
        let unique = (themes.max(by: { $0.id < $1.id })?.id ?? 0) + 1
        let theme = ThemesForShop(id: unique, name: name, emojis: emojis ?? [], color: color, numberOfPairs: numberOfPairs)
        let safeIndex = min(max(index, 0), themes.count)
        themes.insert(theme, at: safeIndex)
    }
}
