//
//  InteractiveStackView.swift
//  pixabay
//
//  Created by Ml bench-iOS Dev on 12/23/25.
//


import SwiftUI

struct InteractiveStackView: View {
  @Binding var cards:[PixabayImage]
  @State private var dragOffset: CGSize = .zero
  private let maxVisibleCards = 4
  private let swipeThreshold: CGFloat = -120

  var body: some View {
    ZStack {
      ForEach(Array(cards/*.prefix(maxVisibleCards)*/.enumerated().reversed()), id: \.element.id) { index, card in
        CardViews(card: card)
          .transition(.asymmetric(insertion: .scale, removal: .opacity))
          .offset(x: calculateOffset(for: index), y: 0)
          .opacity(calculateOpacity(for: index))
          .blur(radius: index == 0 ? 0 : CGFloat(index * 1))
          .scaleEffect(calculateScale(for: index))
          .zIndex(Double(-index))
          .gesture(index == 0 ? dragGesture() : nil)
      }
    }
  }

  private func dragGesture() -> some Gesture {
          DragGesture()
              .onChanged { value in
                  if value.translation.width < 0 {
                      dragOffset = value.translation
                  }
              }
              .onEnded { value in
                  withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                      if value.translation.width < swipeThreshold {
                          removeTopCard()
                      }
                      dragOffset = .zero
                  }
              }
      }

  private func calculateOpacity(for index: Int) -> Double {
    if index >= maxVisibleCards {
      return 0
    } else if index == 0 {
      return max(0, 1 - (Double(abs(dragOffset.width)) / 200))
    } else {
      return 1.0
    }

  }

  private func calculateOffset(for index: Int) -> Double {
    if index >= maxVisibleCards {
      return CGFloat(4) * 55
    } else if index == 0 {
      return dragOffset.width
    } else {
      return CGFloat(index) * 55
    }

  }

  private func calculateScale(for index: Int) -> Double {
    if index > maxVisibleCards {
      return (1.0 - (CGFloat(4) * 0.09))
    } else if index == 0 {
      return 1.0
    } else {
      return (1.0 - (CGFloat(index) * 0.09))
    }
  }

  func removeTopCard() {
    if !cards.isEmpty { cards.removeFirst() }
  }

}



#Preview {

  InteractiveStackView(cards: .constant([.init(),.init()]))

}
