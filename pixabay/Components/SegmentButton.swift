//
//  SegmentButton.swift
//  pixabay
//
//  Created by SID on 23/12/2025.
//

import SwiftUI

struct SegmentButton: View {
    let item: SegmentItem
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Image(systemName: item.icon)
                    .font(.system(size: 24, weight: .bold))

                Text(item.title)
                    .font(.system(size: 18, weight: .bold))
            }
            .foregroundColor(isSelected ? .white : .black)
            .frame(maxWidth: .infinity)
        }
    }
}
