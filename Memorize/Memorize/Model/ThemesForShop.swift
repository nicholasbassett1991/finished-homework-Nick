//
//  ThemesForShop.swift
//  Memorize
//
//  Created by Nicholas Steven Bassett on 7/26/21.
//

import Foundation


struct ThemesForShop: Identifiable, Codable, Hashable {
    
    var id: Int
    var name: String
    var emojis: [String]
    var color: String
    var numberOfPairs: Int

    init(id: Int, name: String, emojis: [String], color: String, numberOfPairs: Int) {
        self.id = id
        self.name = name
        self.emojis = emojis
        self.color = color
        self.numberOfPairs = numberOfPairs
    }
    
    
    
    
    
    
    
//    static var emojiShopTheme: [ThemesForShop] = [
//        ThemesForShop(id:name: "Animals", emojis: ["🐱","🐶","🐹","🐰","🐻","🐼","🐮","🐵","🙈","🐥","🐣","🦉","🐽","🐺","🦊","🐷","🐸","🐭","🦇","🦄","🐝","🐗","🐴"], color: "#FFA500", numberOfPairs: 10),
//        ThemesForShop(name: "Bugs", emojis: ["🐝","🪱", "🐛","🦋","🐌","🐞","🐜","🪰","🪲","🪳","🦟","🦗","🕷","🕸","🦂"], color: "#FF0000", numberOfPairs: 7),
//        ThemesForShop(name: "Food", emojis: ["🥮","🍱","🥟","🍙","🍦","🥧","🍿","🍰","🍨","🍚","🍢","🍡","🍨","🍧"],
//                     color: "#00FF00", numberOfPairs: 6),
//        ThemesForShop(name: "Objects", emojis: ["🧯","📡","🪔","⚖️","📀","🕹","📱","⌚️","🪛","🔫","🗡","⚰️","📿","🔮","💊","🧽","💰","⏱"], color: "#FFC0CB",
//                     numberOfPairs: 8),
//        ThemesForShop(name: "Sea Life", emojis: [
//                        "🐙","🐡","🐟","🦐","🦑","🦞","🦀","🐬","🐳","🦈","🦭","🐋","🐠"], color: "#0000FF", numberOfPairs: 9),
//        ThemesForShop(name: "Vehicles", emojis: ["🚂","🚀","🚁","🚜", "🚘", "🚌", "🛵", "🏍", "🚍","🚛", "🛴", "🚊", "🚢", "🛺", "🚑", "🚲", "🚒", "🚕", "🚞","🚐","🚗", "🛫", "🛩", "🚓"], color: "#800080", numberOfPairs: 12)
//  ]
    
}

