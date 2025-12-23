//
//  HomeView.swift
//  pixabay
//
//  Created by SID on 23/12/2025.
//

import SwiftUI

struct HomeView: View {
  @State var viewModel: HomeVM
    var body: some View {
      content
        .alert("", isPresented: $viewModel.showAlert) {
          Button("Ok") { viewModel.showAlert = false }
        } message: {
          Text(viewModel.alertMessage)
        }
        .task {
          await viewModel.getImages()
        }

    }
}
extension HomeView {
  private var content: some View {
    ZStack {
      LinearGradient(colors: [Color.top, Color.bottom], startPoint: .top, endPoint: .bottom)
        .ignoresSafeArea()
      VStack(spacing: 17) {
        headerSection
        CustomSegmentedControl()
        gallery
        Spacer()
      }
      .padding(.horizontal)
    }
  }
  private var headerSection: some View {
    HStack {
      VStack(alignment: .leading) {
        Text("Storage")
          .font(.system(size: 22, weight: .semibold))
        Text("Cleaner & Manager")
          .font(.system(size: 16, weight: .regular))
      }
      .foregroundStyle(.black)
      Spacer()

      HStack(spacing: 14) {
        IconCircleButton(systemName: "text.justify.left" ) {
            print("Settings tapped")
        }
        IconCircleButton(systemName: "gearshape.fill") {
            print("Settings tapped")
        }
        

      }
    }
  }
  
  private var gallery: some View {
    VStack(alignment: .leading) {
      Text("THIS DAY")
        .font(.system(size: 16, weight: .semibold))
        .foregroundStyle(.black)
      InteractiveStackView(cards: $viewModel.images.hits)
    }
    .frame(maxWidth: .infinity, alignment: .leading)
  }
}

#Preview {
  HomeView(viewModel: HomeVM())
}
