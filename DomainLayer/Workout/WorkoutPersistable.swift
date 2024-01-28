//
//  WorkoutPersistable.swift
//  WorkoutBrowser
//
//  Created by Yeongweon Park on 27.01.24.
//

import Foundation

protocol WorkoutPersistable {
    func save(workouts: [Workout])
    func load(id: Int) -> Workout
}
