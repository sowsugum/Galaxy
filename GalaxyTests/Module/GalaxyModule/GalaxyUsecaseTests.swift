//
//  GalaxyUsecaseTest.swift
//  GalaxyTests
//
//  Created by Sowrirajan Sugumaran on 23/01/25.
//

import Foundation
@testable import Galaxy
import XCTest

final class GalaxyUsecaseTests: XCTestCase {
    
    var galaxyUsecase: GalaxyUseCaseProtocol!
    var mockGalaxyRepository: MockGalaxyRepository!
    
    override func setUp() {
        super.setUp()
        mockGalaxyRepository = MockGalaxyRepository()
        galaxyUsecase = GalaxyUseCase(repository: mockGalaxyRepository)
    }
    
    override func tearDown() {
        mockGalaxyRepository = nil
        galaxyUsecase = nil
    }
    
    func testGalaxyUseCaseSuccess() async {
        let expectation = expectation(description: "Galaxy Use case Success Case")
        mockGalaxyRepository.galaxy = MockTestData.galaxyDomainData
        
        do {
            let presentationData: [GalaxyPresentationData] = try await galaxyUsecase.execute()
            XCTAssertEqual(presentationData.count, 17)
            expectation.fulfill()
        } catch {
            
        }
        await fulfillment(of: [expectation], timeout: 5.0)
    }
    
    func testGalaxyUseCaseFailure() async {
        let expectation = expectation(description: "Galaxy use case Failure Case")
        mockGalaxyRepository.error = APIError.general
        mockGalaxyRepository.galaxy = nil
        do {
            let _ = try await galaxyUsecase.execute()
            XCTFail("Success not expected")
        } catch {
            XCTAssertEqual(error as! APIError, APIError.serverError(error: "Bad Request"))
            expectation.fulfill()
        }
        await fulfillment(of: [expectation], timeout: 5.0)
    }
}
