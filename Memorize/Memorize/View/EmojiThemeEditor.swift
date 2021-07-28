//
//  EmojiThemeEditor.swift
//  Memorize
//
//  Created by Nicholas Steven Bassett on 7/27/21.
//

import SwiftUI

struct EmojiThemeEditor: View {
    @Binding var theme: ThemesForShop
    
    
    
    var body: some View {
        Form {
            nameSection
        }
    }
    
    
    var nameSection: some View {
        Section(header: Text("Name")) {
            TextField("Name", text: $theme.name)
        }
    }
    
    
    
    
    
    
    
    
    
}

struct EmojiThemeEditor_Previews: PreviewProvider {
    static var previews: some View {
        EmojiThemeEditor(theme:
                            .constant(EmojiStore(named: "Dragon God").theme(at: 0)))
    }
}
