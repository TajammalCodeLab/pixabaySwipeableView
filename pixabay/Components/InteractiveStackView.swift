//
//  InteractiveStackView.swift
//  pixabay
//
//  Created by Ml bench-iOS Dev on 12/23/25.
//


import SwiftUI

struct InteractiveStackView: View {
  // State to track which card is currently on top
  @Binding var cards:[PixabayImage]
  
  // State for the drag offset
  @State private var dragOffset: CGSize = .zero
  let maxVisibleCards = 4
  var body: some View {
    ZStack {
      ForEach(Array(cards.prefix(maxVisibleCards).enumerated().reversed()), id: \.element.id) { index, card in
          CardViews(card: card)
              // 1. Movement: Add the negative dragOffset to the default stacked offset
              .offset(x: index == 0 ? dragOffset.width : CGFloat(index) * 40)
              .offset(y: 0) // Strictly locked on X-axis
              
              // 2. Opacity: Using abs() because dragOffset.width will be negative
              // It reaches 0 visibility at -250px
              .opacity(index == 0 ? max(0, 1 - (Double(abs(dragOffset.width)) / 250)) : 1.0)
              
              // 3. Depth Effects
              .blur(radius: index == 0 ? 0 : CGFloat(index * 3))
              .scaleEffect(index == 0 ? 1.0 : 1.0 - (CGFloat(index) * 0.05))
              .zIndex(Double(-index))
              
              // 4. Left-Swiping Gesture
              .gesture(
                  index == 0 ?
                  DragGesture()
                      .onChanged { value in
                          if value.translation.width < 0 {
                              dragOffset = value.translation
                          }
                      }
                      .onEnded { value in
                          withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                              // Check if swipe left passed the threshold (-150px)
                              if value.translation.width < -150 {
                                  moveCardToBack()
                              }
                              // Reset to zero (snaps back if didn't swipe far enough)
                              dragOffset = .zero
                          }
                      } : nil
              )
      }
    }
  }
  
  // Function to cycle the cards
  func moveCardToBack() {
    cards.removeFirst()
  }
}

#Preview {
  InteractiveStackView(cards: .constant([.init(),.init()]))
}
