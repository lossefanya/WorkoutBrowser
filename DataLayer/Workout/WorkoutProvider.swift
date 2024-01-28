//
//  WorkoutProvider.swift
//  WorkoutBrowser
//
//  Created by Yeongweon Park on 27.01.24.
//

import Foundation

final class WorkoutProvider: WorkoutProvidable {
    func loadWorkouts() async -> [WorkoutEntity] {
        return []
    }
    
    func loadWorkout(id: Int) async -> WorkoutEntity {
        return WorkoutEntity(id: 0, name: "", uuid: "", description: "", images: [], variations: [])
    }
}
