//
//  DetailView.swift
//  Galaxy
//
//  Created by Sowrirajan Sugumaran on 17/01/25.
//

import SwiftUI
import Kingfisher

struct GalaxyDetailView: View {
    
    let galaxy: GalaxyPresentationData
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                Text(galaxy.name.whenNoValue(.empty))
                    .multilineTextAlignment(.center)
                    .font(.system(size: 24))
                    .fontWeight(.semibold)
                if let url = URL(string: galaxy.hdImageUrl) {
                    KFImage(url)
                        .fade(duration: 0.25)
                        .placeholder({ _ in
                            ProgressView()
                        })
                        .resizable()
                        .frame(maxWidth: .infinity)
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(16)
                }
                Text(galaxy.description.whenNoValue(.empty))
                    .multilineTextAlignment(.center)
                    .lineLimit(200)
                Spacer(minLength: 24)
                Text(Constants.GalaxyDetail.copyright + galaxy.copyright.whenNoValue(.empty))
                    .font(.footnote)
                    .foregroundStyle(Color.paleLavender)
            }
            .padding()
        }
        .padding(.top, 88)
        .ignoresSafeArea(edges: .top)
    }
}
