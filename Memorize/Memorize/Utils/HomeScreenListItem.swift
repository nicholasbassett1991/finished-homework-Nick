//
//  HomeScreenListItem.swift
//  Memorize
//
//  Created by Nicholas Steven Bassett on 7/27/21.
//
import SwiftUI

struct HomeScreenListItem: View {
    var theme: ThemesForShop
    @State private var emojiIndexForCarosel = 0
    @EnvironmentObject var store: EmojiStore
    

  
    
    var body: some View {
        let shape = RoundedRectangle(cornerRadius: Cardify.DrawingConstants.cornerRadius)
        let timer = Timer.publish(every: 3, on: .current, in: .common).autoconnect()


        ZStack(alignment: .leading) {
            ZStack {
                shape
                    .foregroundColor(Color(hex: theme.color).darker(by: 3 ))
                    
                HStack {
                    ZStack {
                        shape
                            .foregroundColor(Color(hex: theme.color).lighter(by: 20))
                            .shadow(radius: 10)
                            .opacity(0.8)
                        Circle()
                            .foregroundColor(Color(hex: theme.color).darker(by: 10))
                            .frame(width: 60, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        Text(theme.emojis.isEmpty ? "?" : theme.emojis[emojiIndexForCarosel] )
                            .onReceive(timer) { time in
                                if emojiIndexForCarosel != theme.numberOfPairs {
                                    emojiIndexForCarosel += 1 }
                                else {
                                    emojiIndexForCarosel = 0
                                }
                        }
                            .font(.title)
                            .transition(rollTransition)
                            .animation(.easeInOut)
                            .id(theme.emojis.isEmpty ? "?" : theme.emojis[emojiIndexForCarosel])
                    }
                    .frame(width: 70, height: 70)
                    .padding(5)

                    VStack(alignment: .leading) {
                    Text(theme.name)
                        .font(.title)
                        .bold()
                        Text("Number of pairs: \(theme.numberOfPairs ?? theme.emojis.count)")
                    }
                    .foregroundColor(.white)
                    .padding(.leading, 0)
                    
                    Spacer()
                }
                Spacer()
            }
        }
        .frame(height: 75)
    }
    
    
    
    var rollTransition: AnyTransition {
        AnyTransition.asymmetric(insertion: .offset(x: 0, y: 15), removal: .offset(x: 0, y: -15))
    }
    
 
    
}




struct HomeScreenListItem_Previews: PreviewProvider {
    static var themes = EmojiStore(named: "Dragon God").themes
    static var previews: some View {
        HomeScreenListItem(theme: themes[0])
    }
}

