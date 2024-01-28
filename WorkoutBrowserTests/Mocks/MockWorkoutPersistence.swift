//
//  MockWorkoutPersistence.swift
//  WorkoutBrowserTests
//
//  Created by Yeongweon Park on 28.01.24.
//

import Foundation
@testable import WorkoutBrowser

final class MockWorkoutPersistence: WorkoutPersistable {
    
    var saveCallCount = 0
    var workoutsValue: [WorkoutBrowser.WorkoutEntity] = []
    var expectedSaveResult: Result<Void, Error>!
    func save(workouts: [WorkoutBrowser.WorkoutEntity]) async -> Result<Void, Error> {
        saveCallCount += 1
        workoutsValue = workouts
        return expectedSaveResult
    }
    
    var loadWorkoutCallCount = 0
    var idValue = 0
    var expectedLoadWorkoutResult: Result<WorkoutBrowser.WorkoutEntity, Error>!
    func loadWorkout(id: Int) async -> Result<WorkoutBrowser.WorkoutEntity, Error> {
        loadWorkoutCallCount += 1
        idValue = id
        return expectedLoadWorkoutResult
    }
}
