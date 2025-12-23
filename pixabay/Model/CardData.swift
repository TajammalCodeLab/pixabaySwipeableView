//
//  CardData.swift
//  pixabay
//
//  Created by Ml bench-iOS Dev on 12/23/25.
//


import Foundation

struct CardData: Identifiable {
  let id = UUID()
  let title: String
  let items: String
  let size: String
  let color: String
}
