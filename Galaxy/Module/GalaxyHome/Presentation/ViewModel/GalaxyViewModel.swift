//
//  HomeViewModel.swift
//  Galaxy
//
//  Created by Sowrirajan Sugumaran on 17/01/25.
//

import Foundation

protocol GalaxyViewModelProtocol {
    func fetch() async throws
    var galaxyList: [GalaxyPresentationData] { get }
}

final class GalaxyViewModel: ObservableObject, GalaxyViewModelProtocol {
    private let useCase: GalaxyUseCaseProtocol
    @Published var galaxyList: [GalaxyPresentationData] = []
    @Published var error: APIError = .general
    @Published var shouldShowError: Bool = false

    init(useCaseProtocol: GalaxyUseCaseProtocol) {
        self.useCase = useCaseProtocol
    }
    /// Initializes the fetch action through use cases.
    ///
    @MainActor
    func fetch() async throws {
        do {
            let data = try await useCase.execute()
            DispatchQueue.main.async {
                self.galaxyList = data
            }
        } catch {
            self.error = error as! APIError
            shouldShowError = true
        }
    }
}
