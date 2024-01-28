//
//  MockWorkoutProvider.swift
//  WorkoutBrowserTests
//
//  Created by Yeongweon Park on 28.01.24.
//

import Foundation
@testable import WorkoutBrowser

final class MockWorkoutProvider: WorkoutProvidable {
    
    var loadWorkoutsCallCount = 0
    var expectedLoadWorkoutsResult: Result<[WorkoutBrowser.WorkoutEntity], Error>!
    func loadWorkouts() async -> Result<[WorkoutBrowser.WorkoutEntity], Error> {
        loadWorkoutsCallCount += 1
        return expectedLoadWorkoutsResult
    }
    
    var loadWorkoutCallCount = 0
    var idValue = 0
    var expectedLoadWorkousResult: Result<WorkoutBrowser.WorkoutEntity, Error>!
    func loadWorkout(id: Int) async -> Result<WorkoutBrowser.WorkoutEntity, Error> {
        loadWorkoutCallCount += 1
        idValue = id
        return expectedLoadWorkousResult
    }
}
