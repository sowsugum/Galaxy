//
//  Color.swift
//  Galaxy
//
//  Created by Sowrirajan Sugumaran on 17/01/25.
//

import Foundation
import SwiftUICore

extension Color {
    static let paleLavender  = Color(Color.KeyType.palelavender.rawValue)
    static let duckEgg  = Color(Color.KeyType.duckegg.rawValue)

    enum KeyType: String {
        case palelavender = "Palelavender"
        case duckegg = "Duckegg"
    }
}
