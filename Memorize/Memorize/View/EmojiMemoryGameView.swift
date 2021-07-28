//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Nicholas Steven Bassett on 6/29/21.
//

import SwiftUI


struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame
   

    @Namespace private var dealingNameSpace

    var body: some View {
        ZStack(alignment: .bottom){
            VStack{
                HStack {
                    Spacer()
                titleText
                    Spacer()
                pointsTotal
                    Spacer()
                }
                gameBody
                deckBody
                Spacer()
                HStack {
                    Spacer()
                    restart
                    Spacer()
                    shuffle
                    Spacer()
                    newGame
                    Spacer()
            }
            .padding(.horizontal)
        }
        }
        .padding()
        .onAppear() {
            game.restart()
        }
    }

    
    
    @State private var dealt = Set<Int>()
    
    private func deal(_ card: EmojiMemoryGame.Card){
        dealt.insert(card.id)
    }
    
    private func isUndealt(_ card: EmojiMemoryGame.Card) -> Bool {
        !dealt.contains(card.id)
    }
    
    private func dealingAnimation(for card: EmojiMemoryGame.Card) -> Animation {
        
        var delay = 0.0
        
        if let index = game.cards.firstIndex(where: {$0.id == card.id}) {
            delay = Double(index) * (CardConstants.dealDuration / Double(game.cards.count))
        }
        return Animation.easeInOut(duration: CardConstants.dealDuration).delay(delay)
    }
    
    private func zIndex(of card: EmojiMemoryGame.Card) -> Double {
        -Double(game.cards.firstIndex(where: {$0.id == card.id}) ?? 0)
    }
    
    var gameBody: some View {
        AspectVGrid(items: game.cards, aspectRatio: 2/3){ card in
            if isUndealt(card) || card.isMatched && !card.isFaceUp {
                Color.clear
            } else {
                    CardView(card : card)
                        .matchedGeometryEffect(id: card.id, in: dealingNameSpace)
                    .padding(4)
                        .transition(AnyTransition.asymmetric(insertion: .identity, removal: .scale))
                        .zIndex(zIndex(of: card))
                    .onTapGesture {
                        withAnimation {
                        game.choose(card)
                        }
                    }
            }
        }
  
        .foregroundColor(Color(hex:game.selectedTheme.color))
    }
    
    var deckBody: some View {
        ZStack{
            ForEach(game.cards.filter(isUndealt)) {
                card in
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNameSpace)
                    .transition(AnyTransition.asymmetric(insertion: .opacity, removal: .identity))
                    .zIndex(zIndex(of: card))
            }
        }
        .frame(width: CardConstants.undealtWidth, height: CardConstants.undealtHeight)
        .foregroundColor(Color(hex:game.selectedTheme.color))
        .onTapGesture {
            for card in game.cards {
            withAnimation(dealingAnimation(for: card)){
                deal(card)
            }
            }
        }
    }
    
    var titleText: some View {
        Text(game.selectedTheme.name)
            .bold()
            .foregroundColor(Color(hex:game.selectedTheme.color))
    }
    
    var shuffle: some View {
        Button("Shuffle"){
            withAnimation(.easeInOut(duration: 1)){
                game.shuffle()
            }
        }
     
        .foregroundColor((Color(hex:game.selectedTheme.color)))
        .padding(5)
        .overlay(Capsule(style: .continuous)
                    .stroke((Color(hex:game.selectedTheme.color)), lineWidth: 5))
        
    }
    
    var pointsTotal: some View {
        Text("Points: \(game.points)")
            .foregroundColor(.black)
    }
    
    
    
    var newGame: some View {
        Button("New Game") {
            withAnimation(.easeInOut(duration:1)){
                dealt = []
                game.startNewGame()
            }
        }
        .foregroundColor((Color(hex:game.selectedTheme.color)))
        .padding(5)
        .overlay(Capsule(style: .continuous)
                    .stroke((Color(hex:game.selectedTheme.color)), lineWidth: 5))
    }
    
    var restart: some View {
        Button("Restart"){
            withAnimation{
                dealt = []
                game.restart()
            }
        }

        .foregroundColor((Color(hex:game.selectedTheme.color)))
        .padding(5)
        .overlay(Capsule(style: .continuous)
                    .stroke((Color(hex:game.selectedTheme.color)), lineWidth: 5))
    }
}



struct CardView: View {
    
    let card: EmojiMemoryGame.Card
    
    @State private var animatedBonusRemaining: Double = 0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                Group{
                    if card.isConsumingBonusTime{
                Pie(startAngle: Angle(degrees: 0 - 90), endAngle: Angle(degrees: 1-animatedBonusRemaining*360 - 90))
                    .onAppear(){
                        animatedBonusRemaining = card.bonusRemaining
                        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
                            animatedBonusRemaining = 0
                        }
                    }
                } else {
                Pie(startAngle: Angle(degrees: 0 - 90), endAngle: Angle(degrees: 1-card.bonusRemaining*360 - 90))
                }
            }
                .padding(5)
                .opacity(0.5)
                Text(card.content)
                    .rotationEffect(Angle.degrees(card.isMatched ? 360: 0))
                    .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: false))
                    .font(Font.system(size: DrawingConstants.fontSize))
                    .scaleEffect(scale(thatFits: geometry.size))
            }
         
            .cardify(isFaceUp: card.isFaceUp)
        }
    }
    
    private func scale(thatFits size: CGSize) -> CGFloat {
        min(size.width, size.height) / (DrawingConstants.fontSize / DrawingConstants.fontScale)
    }
    

       
}


extension View {
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}

 
private struct DrawingConstants {
    static let fontScale: CGFloat = 0.7
    static let fontSize: CGFloat = 32
}


private struct CardConstants {
    
//    static let color = (Color(hex:game.selectedTheme.color))
    static let aspectRatio: CGFloat = 2/3
    static let dealDuration: Double = 0.5
    static let totalDealDuration: Double = 2
    static let undealtHeight: CGFloat = 90
    static let undealtWidth = undealtHeight * aspectRatio
}
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            let game = EmojiMemoryGame(selectedTheme: ThemesForShop(id: 0, name: "hello", emojis: [""], color: "hello", numberOfPairs: 5))
            game.choose(game.cards.first!)
            return EmojiMemoryGameView(game: game)
        }
    }

