//
//  GalaxyRowView.swift
//  Galaxy
//
//  Created by Sowrirajan Sugumaran on 23/01/25.
//

import SwiftUI
import Kingfisher

struct GalaxyRowView: View {
    var galaxy: GalaxyPresentationData
    var body: some View {
        HStack {
            KFImage(URL(string: galaxy.imageUrl)!)
                .placeholder({ _ in
                    ProgressView()
                })
                .resizable()
                .frame(width: 60, height: 60)
                .fixedSize()
                .scaledToFit()
                .cornerRadius(40)

            VStack(alignment: .leading) {
                Text(galaxy.name.whenNoValue(.empty))
                    .font(.headline)
            }
        }
    }
}
