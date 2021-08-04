//
//  HomeScreen.swift
//  Memorize
//
//  Created by Nicholas Steven Bassett on 7/27/21.
//
import SwiftUI

struct HomeScreen: View {
    @EnvironmentObject var store: EmojiStore
    @ObservedObject var game: EmojiMemoryGame
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var themeChecker: EmojiThemeTracker

    @State private var currentTheme: ThemesForShop?
    @State private var themeToAddOrEdit: ThemesForShop?
    @State private var editMode: EditMode = .inactive

    
//    init(game: EmojiMemoryGame) {
//        let navBarAppearance = UINavigationBar.appearance()
//        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.green]
//        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.purple]
//        self.game = game
//    }
    var body: some View {
        //TODO Please Fix Me Nicholas by the Omnissiah please fix me.
        
        NavigationView {
            List {
                ForEach(store.themes)  { theme in
                    NavigationLink(
                        destination: EmojiMemoryGameView(game: EmojiMemoryGame(selectedTheme: theme), emojiThemeChecker: themeChecker),
                        tag: theme,
                        selection: self.$currentTheme) {
                        HomeScreenListItem(theme: theme)
                    }
                    .gesture(TapGesture(count: 1).onEnded {
                        if (editMode == .active) {
                            themeToAddOrEdit = theme
                        } else {
                            currentTheme = theme
                            themeChecker.currentTheme = theme
                            
                        }
                    })
                    // Get the previous theme
                    // Set the current theme

                }
                .onMove { indexSet, newOffset in
                    store.themes.move(fromOffsets: indexSet, toOffset: newOffset)
                }
                .onDelete { indexSet in
                    store.themes.remove(atOffsets: indexSet)
            }
                

        }
            .popover(item: $themeToAddOrEdit) { theme in
                EmojiThemeEditor(theme: $store.themes[theme])
                }
            
            .navigationTitle("Card Themes")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem {
                    EditButton()
                    }
                ToolbarItem(placement: .navigationBarLeading){
                    Button("Add") {
                        store.insertTheme(named: "", emojis: [], color: "", numberOfPairs: 0, at: store.themes.count + 1)
                        themeToAddOrEdit = store.themes.last
                }
            }
        }
        .environment(\.editMode, $editMode)
    }

}
    

}

//struct HomeScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
////            HomeScreen()
////                .environmentObject(EmojiStore(named: "Default"))
//            HomeScreen()
//                .environmentObject(EmojiStore(named: "Random"))
//
//        }
//    }
//}

