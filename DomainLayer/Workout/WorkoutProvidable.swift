//
//  WorkoutProvidable.swift
//  WorkoutBrowser
//
//  Created by Yeongweon Park on 27.01.24.
//

import Foundation

protocol WorkoutProvidable {
    func loadWorkouts() async -> [WorkoutEntity]
    func loadWorkout(id: Int) async -> WorkoutEntity
}
