//
//  Untitled.swift
//  Galaxy
//
//  Created by Sowrirajan Sugumaran on 23/01/25.
//

import SwiftUI

struct GalaxyListView: View {
    var galaxyList: [GalaxyPresentationData]
    
    var body: some View {
        NavigationStack {
            List(galaxyList, id: \.id) { galaxy in
                NavigationLink {
                    GalaxyDetailView(galaxy: galaxy)
                } label: {
                    GalaxyRowView(galaxy: galaxy)
                }
            }
        }
    }
}
