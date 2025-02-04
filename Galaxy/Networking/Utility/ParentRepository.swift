//
//  ParentRepository.swift
//  Galaxy
//
//  Created by Sowrirajan Sugumaran on 23/01/25.
//

import Foundation
import Combine

protocol ServiceMapper: AnyObject {
    func handleModel<ReturnType>(_ publisher: AnyPublisher<ReturnType,
                          APIError>) async throws -> ReturnType
}


open class ParentRepository: ServiceMapper, ObservableObject {

    private let subscriber = Cancelable()

    func handleModel<ReturnType>(_ publisher: AnyPublisher<ReturnType,
                          APIError>) async throws -> ReturnType {
        
        try await withCheckedThrowingContinuation { continuation in
            
            publisher
                .receive(on: DispatchQueue.main)
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                } receiveValue: { data in
                    continuation.resume(returning: data)
                }
                .store(in: subscriber)
        }
    }
}

final class Cancelable {
    fileprivate(set) var subscriptions = Set<AnyCancellable>()
    func cancel() {
        subscriptions.removeAll()
    }
}

extension AnyCancellable {
    func store(in subscriber: Cancelable) {
        subscriber.subscriptions.insert(self)
    }
}
