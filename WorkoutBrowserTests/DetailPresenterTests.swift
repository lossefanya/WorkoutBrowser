//
//  DetailPresenterTests.swift
//  WorkoutBrowserTests
//
//  Created by Yeongweon Park on 28.01.24.
//

import XCTest
@testable import WorkoutBrowser

final class DetailPresenterTests: XCTestCase {
    var sut: DetailPresenter!
    var mockUseCase: MockWorkoutDetailUseCase!
    var mockRouter: MockRouter!

    override func setUpWithError() throws {
        mockUseCase = MockWorkoutDetailUseCase()
        mockRouter = MockRouter()
    }

    override func tearDownWithError() throws {
        mockUseCase = nil
        mockRouter = nil
        sut = nil
    }

    func testWhenInitialized_ThenItShouldHaveAllContents() throws {
        // Given
        let workout = WorkoutEntity(
            id: 78,
            name: "Some",
            uuid: UUID().uuidString,
            description: "",
            images: ["someUrl", "anotherUrl"],
            variations: [123, 456]
        )
        let variation = WorkoutEntity(
            id: 123,
            name: "Some",
            uuid: UUID().uuidString,
            description: "",
            images: ["someUrl", "anotherUrl"],
            variations: [78, 456]
        )
        mockUseCase.expectedResult = .success(variation)
        
        // When
        sut = DetailPresenter(
            workout: workout,
            isVariation: false,
            useCase: mockUseCase,
            router: mockRouter
        )
        
        let exp = expectation(description: "callingAPI")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            exp.fulfill()
        }
        wait(for: [exp], timeout: 0.1)
        
        // Then
        XCTAssertTrue(sut.contents.count == 3)
        XCTAssertTrue(mockUseCase.loadWorkoutCallCount == 2)
    }

    func testWhenItsVariation_ThenItShouldHaveSomeContents() throws {
        // Given
        let workout = WorkoutEntity(
            id: 78,
            name: "Some",
            uuid: UUID().uuidString,
            description: "",
            images: ["someUrl", "anotherUrl"],
            variations: [123, 456]
        )
        let variation = WorkoutEntity(
            id: 123,
            name: "Some",
            uuid: UUID().uuidString,
            description: "",
            images: ["someUrl", "anotherUrl"],
            variations: [78, 456]
        )
        mockUseCase.expectedResult = .success(variation)
        
        // When
        sut = DetailPresenter(
            workout: workout,
            isVariation: true,
            useCase: mockUseCase,
            router: mockRouter
        )
        
        let exp = expectation(description: "callingAPI")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            exp.fulfill()
        }
        wait(for: [exp], timeout: 0.1)
        
        // Then
        XCTAssertTrue(sut.contents.count == 2)
        XCTAssertTrue(mockUseCase.loadWorkoutCallCount == 0)
    }
}
