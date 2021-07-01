//
//  Themes.swift
//  Memorize
//
//  Created by Nicholas Steven Bassett on 7/1/21.
//

import SwiftUI





struct Themes {
    let themeId: Int
    let theme: String
    let emojiContent: Array<String>
    let cardPairCount: Int
    let themeColor: Color
    
    
    enum emojiList {
        case animalEmoji(Array<String>)

    }

    
//    switch emojiList {
//    case .0: ["🐱","🐶","🐹","🐰","🐻","🐼","🐮","🐵","🙈","🐥","🐣","🦉","🐽","🐺","🦊","🐷","🐸","🐭","🦇","🦄","🐝","🐗","🐴"]
//
//    }
    static let animalEmoji = ["🐱","🐶","🐹","🐰","🐻","🐼","🐮","🐵","🙈","🐥","🐣","🦉","🐽","🐺","🦊","🐷","🐸","🐭","🦇","🦄","🐝","🐗","🐴"]
    static let bugEmojis =
        ["🐝","🪱", "🐛","🦋","🐌","🐞","🐜","🪰","🪲","🪳","🦟","🦗","🕷","🕸","🦂"]

    static let foodEmojis =
        ["🥮","🍱","🥟","🍙","🍦","🥧","🍿","🍰","🍨","🍚","🍢","🍡","🍨","🍧"]

    static let objectEmojis = ["🧯","📡","🪔","⚖️","📀","🕹","📱","⌚️","🪛","🔫","🗡","⚰️","📿","🔮","💊","🧽","💰","⏱"]
    static let seaLifeEmojis = [
        "🐙","🐡","🐟","🦐","🦑","🦞","🦀","🐬","🐳","🦈","🦭","🐋","🐠"]

    func selectCurrentTheme(_ selectedId: Int) -> Array<String> {
        let emojiList = [Themes.animalEmoji, Themes.bugEmojis, Themes.foodEmojis, Themes.objectEmojis, Themes.seaLifeEmojis]
        return emojiList[selectedId]
    }
    
}


