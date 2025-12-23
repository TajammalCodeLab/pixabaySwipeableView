//
//  IconCircleButton.swift
//  pixabay
//
//  Created by SID on 23/12/2025.
//


import SwiftUI

struct IconCircleButton: View {
    let systemName: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: systemName)
                .foregroundStyle(.black)
                .font(.title2)
                .padding(10)
                .background(
                    Circle()
                        .fill(Color.white)
                        .shadow(color: .dropshadow, radius: 5, x: 2, y: 5)
                )
        }
    }
}
