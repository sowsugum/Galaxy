//
//  Injection.swift
//  Galaxy
//
//  Created by Sowrirajan Sugumaran on 17/01/25.
//

import Foundation

final class AppIDContainer {
    var service: NetworkProtocol {
        NetworkClientManager(session: SharedURLSession.shared)
    }
    
    lazy var galaxyViewmodel: GalaxyViewModel = {
        let galaxyModule = GalaxyModule(service: service)
        return galaxyModule.generateGalaxyViewModel()
    }()
}
