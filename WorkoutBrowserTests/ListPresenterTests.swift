//
//  ListPresenterTests.swift
//  WorkoutBrowserTests
//
//  Created by Yeongweon Park on 28.01.24.
//

import XCTest
@testable import WorkoutBrowser

final class ListPresenterTests: XCTestCase {
    var sut: ListPresenter!
    var mockUseCase: MockWorkoutListUseCase!
    var mockRouter: MockRouter!
    
    override func setUpWithError() throws {
        mockUseCase = MockWorkoutListUseCase()
        mockRouter = MockRouter()
        sut = ListPresenter(listUseCase: mockUseCase, router: mockRouter)
    }

    override func tearDownWithError() throws {
        mockUseCase = nil
        mockRouter = nil
        sut = nil
    }

    func testWhenLoadSucceed_ThenItShouldShowContents() throws {
        // Given
        let workout1 = WorkoutEntity(
            id: 78,
            name: "Some",
            uuid: UUID().uuidString,
            description: "",
            images: ["someUrl", "anotherUrl"],
            variations: [123, 456]
        )
        let workout2 = WorkoutEntity(
            id: 123,
            name: "Some",
            uuid: UUID().uuidString,
            description: "",
            images: ["someUrl", "anotherUrl"],
            variations: [78, 456]
        )
        mockUseCase.expectedResult = .success([workout1, workout2])
        
        // When
        sut.loadWorkouts()
        
        let exp = expectation(description: "callingAPI")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1.1)
        
        // Then
        XCTAssertTrue(sut.workouts.count == 2)
        XCTAssertTrue(mockUseCase.loadWorkoutsCallCount == 1)
    }
}
