//
//  CardViews.swift
//  pixabay
//
//  Created by Ml bench-iOS Dev on 12/23/25.
//


import SwiftUI
struct CardViews: View {
  let card: PixabayImage
  var body: some View {
    ZStack(alignment: .bottomLeading) {
      AsyncImage(url: URL(string: card.largeImageURL)) { phase in
          switch phase {
          case .empty:
              ProgressView()
              .frame(width: 250, height: 380)
          case .success(let image):
              image
              .resizable()
              .aspectRatio(contentMode: .fill)
              .frame(width: 250, height: 380)
              .clipShape(
                RoundedRectangle(cornerRadius: 13)
              )
          case .failure:
              Image(systemName: "photo")
          @unknown default:
              EmptyView()
          }
      }
      HStack{
        VStack(alignment: .leading) {
          Text(card.user).font(.system(size: 14, weight: .heavy))
          Text("\(card.downloads) Downloads").font(.system(size: 11, weight: .medium))
        }
        Spacer()
        Text("\(card.likes) Likes")
          .font(.system(size: 10, weight: .bold))
          .padding(.horizontal, 8).padding(8)
          .background(Capsule().fill(LinearGradient(
            colors: [Color.blue.opacity(0.7), Color.blue.mix(with: .purple, by: 0.08)],
              startPoint: .leading,
              endPoint: .trailing
          )))
      }
      .padding()
      .background(UnevenRoundedRectangle(bottomLeadingRadius: 13, bottomTrailingRadius: 13).fill(.black.opacity(0.4)))
      .foregroundStyle(.white)
    }
    .frame(width: 250, height: 380)
  }
}

#Preview {
  CardViews(card: .init(id: 1, pageURL: "", type: "", tags: "23 items", previewURL: "", previewWidth: 1, previewHeight: 1, webformatURL: "", webformatWidth: 1, webformatHeight: 1, largeImageURL: "https://pixabay.com/get/g6aaa3bacc5f733cfd90b81541bd5bb107cee9098e8947f3e0c51720b96d053758a160cb5d8f89afc3a8ce06baa823b6b04c54e6a0d878a6b3b5a16cd433ae5a7_1280.jpg", imageWidth: 1, imageHeight: 1, imageSize: 1, views: 1, downloads: 1, collections: 1, likes: 1, comments: 1, userID: 1, user: "Ali ", userImageURL: "", userURL: "", noAiTraining: true, isAiGenerated: true, isGRated: true, isLowQuality: false))
}
