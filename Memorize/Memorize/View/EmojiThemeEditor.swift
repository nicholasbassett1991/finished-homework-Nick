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
            
        }
    }
    
    
    
    
    
    
    
}

struct EmojiThemeEditor_Previews: PreviewProvider {
    static var previews: some View {
        EmojiThemeEditor(theme:
                            .constant(EmojiStore(named: "Default").theme(at: 0)))
    }
}
