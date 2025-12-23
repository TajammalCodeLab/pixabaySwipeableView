//
//  CustomSegmentedControl.swift
//  pixabay
//
//  Created by SID on 23/12/2025.
//


import SwiftUI

struct CustomSegmentedControl: View {
    @State private var selection = 0

    private let items: [SegmentItem] = [
        .init(id: 0, title: "Memories", icon: "photo.fill"),
        .init(id: 1, title: "AI Album", icon: "photo.on.rectangle.angled")
    ]

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 40)
                .fill(Color.white)
                .frame(maxWidth: .infinity)
                .frame(height: 54)
                .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)

            GeometryReader { geo in
                let width = geo.size.width / CGFloat(items.count)

                UnevenRoundedRectangle(
                    topLeadingRadius: selection == 0 ? 40 : 0,
                    bottomLeadingRadius: selection == 0 ? 40 : 0,
                    bottomTrailingRadius: selection == items.count - 1 ? 40 : 0,
                    topTrailingRadius: selection == items.count - 1 ? 40 : 0
                )
                .fill(
                    LinearGradient(
                      colors: [Color.blue.opacity(0.7), Color.blue.mix(with: .purple, by: 0.08)],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .frame(width: width)
                .offset(x: CGFloat(selection) * width)
                .animation(.spring(response: 0.3, dampingFraction: 0.7), value: selection)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 54)

            HStack(spacing: 0) {
                ForEach(items) { item in
                    SegmentButton(
                        item: item,
                        isSelected: selection == item.id
                    ) {
                        selection = item.id
                    }
                }
            }
        }
        
    }
}

#Preview {
  CustomSegmentedControl()
}

