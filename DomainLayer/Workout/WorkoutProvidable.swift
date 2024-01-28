//
//  WorkoutProvidable.swift
//  WorkoutBrowser
//
//  Created by Yeongweon Park on 27.01.24.
//

import Foundation

protocol WorkoutProvidable {
    func loadWorkouts() async -> Result<[WorkoutEntity], Error>
    func loadWorkout(id: Int) async -> Result<WorkoutEntity, Error>
}

enum WorkoutProvidableError: Error {
    case invalidURL
    case parsingFailure
}
