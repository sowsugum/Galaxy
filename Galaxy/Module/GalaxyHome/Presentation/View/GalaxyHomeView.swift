//
//  ContentView.swift
//  Galaxy
//
//  Created by Sowrirajan Sugumaran on 17/01/25.
//

import SwiftUI
import Kingfisher

struct GalaxyHomeView: View {
    @StateObject var viewModel: GalaxyViewModel = AppIDContainer().galaxyViewmodel
    
    var body: some View {
        VStack {
            GalaxyListView(galaxyList: viewModel.galaxyList)
        }
        .navigationTitle(Constants.Home.title)
        .onAppear {
            Task {
                try await viewModel.fetch()
            }
        }
        .alert(isPresented: $viewModel.shouldShowError) {
            return Alert(title: Text("Error"),
                    message: Text(viewModel.error.desc),
                         dismissButton: .default(Text("Ok")) {
                    }
                )
        }
    }
}
