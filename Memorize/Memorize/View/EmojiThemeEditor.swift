//
//  EmojiThemeEditor.swift
//  Memorize
//
//  Created by Nicholas Steven Bassett on 7/27/21.
//

import SwiftUI

struct EmojiThemeEditor: View {
    @Binding var theme: ThemesForShop
    @State private var bgColor = Color.white
    
    
    var body: some View {
        Form {
            nameSection
            addEmojisSection
            ColorPicker("Set theme color", selection: $bgColor, supportsOpacity: false)
            pairEditor
            removeEmojis
        }
    }
    
    
    var nameSection: some View {
        Section(header: Text("Name")) {
            TextField("Name", text: $theme.name)
        }
    }
    
    @State private var emojisToAdd = ""
    
    var addEmojisSection: some View {
        Section(header: Text("Add Emojis")) {
            TextField("", text: $emojisToAdd)
                .onChange(of: emojisToAdd, perform: { emojis in
                    addEmojis(emojis)
                })
        }
    }

    
    var removeEmojis: some View {
        Section(header: Text("Remove Emojis")) {
            let emojis = theme.emojis.joined().removingDuplicateCharacters.map {
                String($0) }
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 50))]) {
                ForEach(emojis, id: \.self) { emoji in
                    Text(emoji)
                        .onTapGesture {
                            withAnimation {
                                theme.emojis.removeAll(where: {
                                    String($0) == emoji
                                })
                            }
                        }
                        .font(.system(size: 40))
                }
            }
        }
}

    var pairEditor: some View {
        Section(header: Text("Number of Pairs")) {
            TextField("10", value: $theme.numberOfPairs, formatter: NumberFormatter())
        }
    }
    
    func convertColorIntoTheme(_ color: Color) {
        theme.color = UIColor(color).toHexString()
    }
    
    func addEmojis(_ emojis: String) {
        let listOfEmojis = Array(emojis.withNoRepeatedCharacters)
        for char in listOfEmojis {
            if !theme.emojis.contains(String(char)), char.isEmoji {
                theme.emojis.append(String(char))
            }
        }
    }
    
    
  
}

struct EmojiThemeEditor_Previews: PreviewProvider {
    static var previews: some View {
        EmojiThemeEditor(theme:
                            .constant(EmojiStore(named: "Dragon God").theme(at: 0)))
    }
}
