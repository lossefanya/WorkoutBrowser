//
//  DetailPresenterTests.swift
//  WorkoutBrowserTests
//
//  Created by Yeongweon Park on 28.01.24.
//

import XCTest
@testable import WorkoutBrowser

private enum DetailPresenterTestError: Error {
    case sample
}

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
        mockUseCase.expectedResult = .success(workout)
        
        // When
        sut = DetailPresenter(
            workout: workout,
            isVariation: false,
            useCase: mockUseCase,
            router: mockRouter
        )
        
        let exp = expectation(description: "callingAPI")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            exp.fulfill()
        }
        wait(for: [exp], timeout: 0.5)
        
        // Then
        XCTAssertEqual(sut.contents.count, 3)
        XCTAssertEqual(mockUseCase.loadWorkoutCallCount, 3)
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            exp.fulfill()
        }
        wait(for: [exp], timeout: 0.5)
        
        // Then
        XCTAssertEqual(sut.contents.count, 2)
        XCTAssertEqual(mockUseCase.loadWorkoutCallCount, 0)
    }

    func testWhenLoadingDetailsFails_ThenItShouldKeepInitialContents() throws {
        let workout = WorkoutEntity(
            id: 78,
            name: "Some",
            uuid: UUID().uuidString,
            description: "",
            images: ["someUrl", "anotherUrl"],
            variations: [123, 456]
        )
        mockUseCase.expectedResult = .failure(DetailPresenterTestError.sample)

        sut = DetailPresenter(
            workout: workout,
            isVariation: false,
            useCase: mockUseCase,
            router: mockRouter
        )

        let exp = expectation(description: "callingAPI")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            exp.fulfill()
        }
        wait(for: [exp], timeout: 0.5)

        XCTAssertEqual(sut.contents.count, 2)
        XCTAssertEqual(mockUseCase.loadWorkoutCallCount, 1)
    }

    func testWhenLoadedWorkoutHasNoVariations_ThenItShouldNotAppendVariationSection() throws {
        let initialWorkout = WorkoutEntity(
            id: 78,
            name: "Some",
            uuid: UUID().uuidString,
            description: "",
            images: ["someUrl", "anotherUrl"],
            variations: [123, 456]
        )
        let refreshedWorkout = WorkoutEntity(
            id: 78,
            name: "Updated",
            uuid: UUID().uuidString,
            description: "",
            images: ["someUrl"],
            variations: []
        )
        mockUseCase.expectedResult = .success(refreshedWorkout)

        sut = DetailPresenter(
            workout: initialWorkout,
            isVariation: false,
            useCase: mockUseCase,
            router: mockRouter
        )

        let exp = expectation(description: "callingAPI")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            exp.fulfill()
        }
        wait(for: [exp], timeout: 0.5)

        XCTAssertEqual(sut.contents.count, 2)
        XCTAssertEqual(mockUseCase.loadWorkoutCallCount, 1)
        XCTAssertEqual(sut.workout.name, "Updated")
    }

    func testWhenShowingVariation_ThenItShouldRouteAsVariation() throws {
        let workout = WorkoutEntity(
            id: 78,
            name: "Some",
            uuid: UUID().uuidString,
            description: "",
            images: ["someUrl", "anotherUrl"],
            variations: []
        )
        let variation = WorkoutEntity(
            id: 123,
            name: "Variation",
            uuid: UUID().uuidString,
            description: "",
            images: [],
            variations: []
        )
        mockUseCase.expectedResult = .success(workout)
        sut = DetailPresenter(
            workout: workout,
            isVariation: true,
            useCase: mockUseCase,
            router: mockRouter
        )

        sut.show(variation: variation)

        XCTAssertEqual(mockRouter.showDetailCallCount, 1)
        XCTAssertTrue(mockRouter.isVariationValue)
    }

    func testContentTitles() throws {
        XCTAssertEqual(DetailPresenter.Content.description(AttributedString("desc")).title, "Description")
        XCTAssertEqual(DetailPresenter.Content.images(["image"]).title, "Images")
        XCTAssertEqual(DetailPresenter.Content.variations([]).title, "Variations")
    }
}
