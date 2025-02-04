//
//  MockGalaxyService.swift
//  GalaxyTests
//
//  Created by Sowrirajan Sugumaran on 23/01/25.
//

import Foundation
@testable import Galaxy
import Combine

final class MockGalaxyService: GalaxyServiceProtocol {
    
    var error: Error?
    var resultToReturn: Result<Data, APIError>?
    
    func fetchGalaxyList() -> AnyPublisher<[GalaxyResponseModel], APIError> {
        guard let result = resultToReturn else {
            fatalError("No result in mock network service.")
        }
        
        switch result {
        case .success(let data):
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode([GalaxyResponseModel].self, from: data)
                return Just(responseObject)
                    .setFailureType(to: APIError.self)
                    .eraseToAnyPublisher()
            } catch {
                return Fail(error: APIError.invalidResponse)
                    .eraseToAnyPublisher()
            }
        case .failure(let error):
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
    }
}

