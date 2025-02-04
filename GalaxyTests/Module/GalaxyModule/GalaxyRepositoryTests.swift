//
//  GalaxyRepositoryTest.swift
//  GalaxyTests
//
//  Created by Sowrirajan Sugumaran on 23/01/25.
//

import Foundation
import Combine
@testable import Galaxy
import XCTest

final class GalaxyRepositoryTests: XCTestCase {
    
    var galaxyRepository: GalaxyRepositoryProtocol!
    var mockGalaxyService: MockGalaxyService!
    var cancellables: Set<AnyCancellable> = []

    
    override func setUp() {
        super.setUp()
        mockGalaxyService = MockGalaxyService()
        galaxyRepository = GalaxyRepository(service: mockGalaxyService)
    }
    
    override func tearDown() {
        mockGalaxyService = nil
        galaxyRepository = nil
        cancellables = []
    }
    
    func testGalaxyRepositorySuccess() async {
        
        let data = try! JSONEncoder().encode(MockTestData.galaxy)
        mockGalaxyService.resultToReturn = .success(data)
        let expectation = expectation(description: "Galaxy Repository Success Case")
        
        mockGalaxyService.fetchGalaxyList()
            .sink(receiveCompletion: { completion in
                if case .failure = completion {
                    XCTFail("Expected success, but got failure")
                }
            }, receiveValue: { galaxyList in
                // Then
                XCTAssertEqual(galaxyList.count, 17)
                XCTAssertEqual(galaxyList.first?.title, "Starburst Galaxy M94 from Hubble")
                expectation.fulfill()
            })
            .store(in: &cancellables)
        await fulfillment(of: [expectation], timeout: 1.0)
    }
    
    func testGalaxyRepositoryFailure() async {
        
        mockGalaxyService.resultToReturn = .failure(.invalidResponse)
        let expectation = expectation(description: "Galaxy Repository Success Case")
        
        mockGalaxyService.fetchGalaxyList()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTAssertEqual(error, .invalidResponse)
                    expectation.fulfill()
                }
            }, receiveValue: { galaxyList in
                XCTFail("Expected failure, but got success")
            })
            .store(in: &cancellables)
        await fulfillment(of: [expectation], timeout: 1.0)
    }
}
