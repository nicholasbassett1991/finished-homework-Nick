//
//  HomeScreen.swift
//  Memorize
//
//  Created by Nicholas Steven Bassett on 7/27/21.
//
import SwiftUI

struct HomeScreen: View {
    @EnvironmentObject var store: EmojiStore
    @EnvironmentObject var game: EmojiMemoryGame
    @Environment(\.presentationMode) var presentationMode
    
    @State private var editMode: EditMode = .inactive
    
    init() {
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.green]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.purple]
        
    }
    var body: some View {
        NavigationView {
            List {
                ForEach(store.themes) { theme in
                    NavigationLink(
                        destination: EmojiMemoryGameView(game: EmojiMemoryGame(theme: theme)),
                        label: {
                            HomeScreenListItem(theme: theme)
                        })
                }
                .onDelete { indexSet in
                    store.themes.remove(atOffsets: indexSet)
                }
                .onMove { indexSet, newOffset in
                    store.themes.move(fromOffsets: indexSet, toOffset: newOffset)
                }
            }
            .navigationTitle("Card Themes")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem { EditButton()
                    
                }
            }
        }
        .environment(\.editMode, $editMode)
    }
    
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        Group {
//            HomeScreen()
//                .environmentObject(EmojiStore(named: "Default"))
            HomeScreen()
                .environmentObject(EmojiStore(named: "Random"))

        }
    }
}

