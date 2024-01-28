//
//  MockWorkoutListUseCase.swift
//  WorkoutBrowserTests
//
//  Created by Yeongweon Park on 28.01.24.
//

import Foundation
@testable import WorkoutBrowser

final class MockWorkoutListUseCase: WorkoutListUseCase {
    
    var loadWorkoutsCallCount = 0
    var expectedResult: Result<[WorkoutBrowser.WorkoutEntity], Error>!
    func loadWorkouts() async -> Result<[WorkoutBrowser.WorkoutEntity], Error> {
        loadWorkoutsCallCount += 1
        return expectedResult
    }
}
