//
//  EmojiThemeEditor.swift
//  Memorize
//
//  Created by Nicholas Steven Bassett on 7/27/21.
//

import SwiftUI

struct EmojiThemeEditor: View {
    @Binding var theme: ThemesForShop
    @State private var bgColor: Color = Color.white
    @State private var pairError: IdentifiableAlert?
    
    
    
    var body: some View {
        Form {
            nameSection
            addEmojisSection
            ThemeColorPicker
            pairEditor
            removeEmojis
         
        }
        .alert(item: $pairError) { pairError in
            pairError.alert()
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
    
    var ThemeColorPicker: some View {
        Section(header: Text("Set Theme Color")) {
            ColorPicker("Set theme color", selection: $bgColor, supportsOpacity: true)
                .onChange(of: bgColor) { color in
                    convertColorIntoTheme()
                    print(theme)
                }
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

    @State private var numberOfPairs = ""
    
    var pairEditor: some View {
        Section(header: Text("Number of Pairs")) {
            TextField("Number of Pairs", text: $numberOfPairs)
                .onChange(of: numberOfPairs) { number in
                    updateNumberOfPairs(numberOfPairs: number)
                    print(theme)
                }
        }
    }
    
    func convertColorIntoTheme() {
        theme.color = UIColor(bgColor).toHex() ?? ""
    }
    
    func updateNumberOfPairs(numberOfPairs: String) {
        if let numberOfPairsConvertered = Int(numberOfPairs) {
        if theme.emojis.count >= numberOfPairsConvertered {
        theme.numberOfPairs = numberOfPairsConvertered
        } else {
            print("Not Enough Pairs")
            pairErrorAlert(Int(numberOfPairs) ?? 1)

        }
    }
}
    
    private func pairErrorAlert(_ pairs: Int){
        pairError = IdentifiableAlert(id: "Not Enough Pairs", alert: {
            Alert(
                title: Text("Not Enough Pairs"),
                message: Text("More pairs than emojis \(pairs)."),
                dismissButton: .default(Text("OK"))
            )
        })
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

struct IdentifiableAlert: Identifiable {
    var id: String
    var alert: () -> Alert
}

struct EmojiThemeEditor_Previews: PreviewProvider {
    static var previews: some View {
        EmojiThemeEditor(theme:
            .constant(EmojiStore(named: "Dragon God").theme(at: 0)))
    }
}
