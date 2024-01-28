//
//  MockWorkoutDetailUseCase.swift
//  WorkoutBrowserTests
//
//  Created by Yeongweon Park on 28.01.24.
//

import Foundation
@testable import WorkoutBrowser

final class MockWorkoutDetailUseCase: WorkoutDetailUseCase {
    
    var loadWorkoutCallCount = 0
    var idValue = 0
    var expectedResult: Result<WorkoutBrowser.WorkoutEntity, Error>!
    func loadWorkout(id: Int) async -> Result<WorkoutBrowser.WorkoutEntity, Error> {
        loadWorkoutCallCount += 1
        idValue = id
        return expectedResult
    }
}
