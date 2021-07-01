//
//  Themes.swift
//  Memorize
//
//  Created by Nicholas Steven Bassett on 7/1/21.
//

import SwiftUI





struct Themes<ThemeId> {
    let themeId: Int
    let theme: String
    let emojiContent: Array<String>
    let cardPairCount: Int
    let themeColor: Color
    
    static let animalEmoji = ["🐱","🐶","🐹","🐰","🐻","🐼","🐮","🐵","🙈","🐥","🐣","🦉","🐽","🐺","🦊","🐷","🐸","🐭","🦇","🦄","🐝","🐗","🐴"]
    static let bugEmojis =
        ["🐝","🪱", "🐛","🦋","🐌","🐞","🐜","🪰","🪲","🪳","🦟","🦗","🕷","🕸","🦂"]

    static let foodEmojis =
        ["🥮","🍱","🥟","🍙","🍦","🥧","🍿","🍰","🍨","🍚","🍢","🍡","🍨","🍧"]

    static let objectEmojis = ["🧯","📡","🪔","⚖️","📀","🕹","📱","⌚️","🪛","🔫","🗡","⚰️","📿","🔮","💊","🧽","💰","⏱"]
    static let seaLifeEmojis = [
        "🐙","🐡","🐟","🦐","🦑","🦞","🦀","🐬","🐳","🦈","🦭","🐋","🐠"]

}


