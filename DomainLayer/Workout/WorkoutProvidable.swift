//
//  WorkoutProvidable.swift
//  WorkoutBrowser
//
//  Created by Yeongweon Park on 27.01.24.
//

import Foundation

protocol WorkoutProvidable {
    func loadWorkouts() async -> [Workout]
    func loadWorkout(id: Int) async -> Workout
}
