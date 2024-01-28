//
//  WorkoutPersistence.swift
//  WorkoutBrowser
//
//  Created by Yeongweon Park on 27.01.24.
//

import Foundation

final class WorkoutPersistence: WorkoutPersistable {
    func save(workouts: [WorkoutEntity]) async -> Result<Void, Error> {
        return .success(())
    }
    
    func load(id: Int) async -> Result<WorkoutEntity, Error> {
        return .success(WorkoutEntity(id: 0, name: "", uuid: "", description: "", images: [], variations: []))
    }
}
