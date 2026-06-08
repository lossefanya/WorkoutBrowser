//
//  WorkoutBrowserTests.swift
//  WorkoutBrowserTests
//
//  Created by Yeongweon Park on 27.01.24.
//

import XCTest
@testable import WorkoutBrowser

final class WorkoutInteractorTests: XCTestCase {
    var mockProvider: MockWorkoutProvider!
    var mockPersistence: MockWorkoutPersistence!
    var sut: WorkoutInteractor!

    override func setUpWithError() throws {
        mockProvider = MockWorkoutProvider()
        mockPersistence = MockWorkoutPersistence()
        sut = WorkoutInteractor(provider: mockProvider, persistence: mockPersistence)
    }

    override func tearDownWithError() throws {
        mockProvider = nil
        mockPersistence = nil
        sut = nil
    }

    func testWhenNoCache_ThenItShouldFetchFromAPI() throws {
        // Given
        let workout = WorkoutEntity(
            id: 78,
            name: "Some",
            uuid: UUID().uuidString,
            description: "",
            images: ["someUrl", "anotherUrl"],
            variations: [123, 456]
        )
        mockProvider.expectedLoadWorkousResult = .success(workout)
        mockPersistence.expectedLoadWorkoutResult = .failure(WorkoutPersistableError.notFound)
        mockPersistence.expectedSaveResult = .success(())
        
        let expectation = XCTestExpectation(description: "Async/await function should complete")
        Task {
            // When
            let result = await sut.loadWorkout(id: 78)
            
            guard case let .success(workout) = result else {
                XCTFail("Should have result")
                return
            }
            
            // save is detached thread
            try? await Task.sleep(nanoseconds: 1_000_000_000 / 2)
            
            // Then
            XCTAssertEqual(workout.id, 78)
            XCTAssertEqual(mockPersistence.loadWorkoutCallCount, 0)
            XCTAssertEqual(mockProvider.loadWorkoutCallCount, 1)
            XCTAssertEqual(mockPersistence.saveCallCount, 1)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.6)
    }
    
    func testWhenLoadingList_ThenItShouldNotUseCache() throws {
        let workout = WorkoutEntity(
            id: 78,
            name: "Some",
            uuid: UUID().uuidString,
            description: "",
            images: ["someUrl", "anotherUrl"],
            variations: [123, 456]
        )
        mockProvider.expectedLoadWorkoutsResult = .success([workout])
        mockPersistence.expectedLoadWorkoutResult = .failure(WorkoutPersistableError.notFound)
        mockPersistence.expectedSaveResult = .success(())
        
        let expectation = XCTestExpectation(description: "Async/await function should complete")
        Task {
            // When
            let result = await sut.loadWorkouts()
            
            guard case let .success(workouts) = result else {
                XCTFail("Should have result")
                return
            }
            
            // save is detached thread
            try? await Task.sleep(nanoseconds: 1_000_000_000 / 2)
            
            // Then
            XCTAssertEqual(workouts.count, 1)
            XCTAssertEqual(mockProvider.loadWorkoutsCallCount, 1)
            XCTAssertEqual(mockPersistence.loadWorkoutCallCount, 0)
            XCTAssertEqual(mockPersistence.saveCallCount, 1)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.6)
    }

    func testWhenCacheExists_ThenItShouldPreferFreshAPIData() throws {
        let cachedWorkout = WorkoutEntity(
            id: 78,
            name: "Cached",
            uuid: UUID().uuidString,
            description: "",
            images: [],
            variations: []
        )
        let freshWorkout = WorkoutEntity(
            id: 78,
            name: "Fresh",
            uuid: UUID().uuidString,
            description: "",
            images: ["someUrl"],
            variations: [123]
        )
        mockProvider.expectedLoadWorkousResult = .success(freshWorkout)
        mockPersistence.expectedLoadWorkoutResult = .success(cachedWorkout)
        mockPersistence.expectedSaveResult = .success(())

        let expectation = XCTestExpectation(description: "Async/await function should complete")
        Task {
            let result = await sut.loadWorkout(id: 78)

            guard case let .success(workout) = result else {
                XCTFail("Should have result")
                return
            }

            XCTAssertEqual(workout.name, "Fresh")
            XCTAssertEqual(mockProvider.loadWorkoutCallCount, 1)
            XCTAssertEqual(mockPersistence.loadWorkoutCallCount, 0)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.6)
    }
}
