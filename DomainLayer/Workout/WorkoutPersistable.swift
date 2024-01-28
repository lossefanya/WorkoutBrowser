//
//  WorkoutPersistable.swift
//  WorkoutBrowser
//
//  Created by Yeongweon Park on 27.01.24.
//

import Foundation

protocol WorkoutPersistable {
    func save(workouts: [WorkoutEntity]) async -> Result<Void, Error>
    func load(id: Int) async -> Result<WorkoutEntity, Error>
}
