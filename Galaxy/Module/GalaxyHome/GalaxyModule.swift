//
//  GalaxyModule.swift
//  Galaxy
//
//  Created by Sowrirajan Sugumaran on 22/01/25.
//

import Foundation


final class GalaxyModule {
    
    private let service: NetworkProtocol
    
    init(service: NetworkProtocol) {
        self.service = service
    }
    
    func generateGalaxyView() -> GalaxyHomeView {
        GalaxyHomeView(viewModel: self.generateGalaxyViewModel())
    }
    
    func generateGalaxyViewModel() -> GalaxyViewModel {
        GalaxyViewModel(useCaseProtocol: generateGalaxyUseCase())
    }
    
    func generateGalaxyUseCase() -> GalaxyUseCase {
        GalaxyUseCase(repository: generateGalaxyRepository())
    }
    
    func generateGalaxyRepository() -> GalaxyRepository {
        GalaxyRepository(service: generateGalaxyService())
    }
    
    func generateGalaxyService() -> GalaxyServiceProtocol {
        GalaxyService(service: service)
    }
}
