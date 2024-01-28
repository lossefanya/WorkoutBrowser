//
//  WorkoutPersistence.swift
//  WorkoutBrowser
//
//  Created by Yeongweon Park on 27.01.24.
//

import Foundation

final class WorkoutPersistence: WorkoutPersistable {
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private let keyValueStore = UserDefaults.standard
    private let prefix = "WorkoutID"
    
    func save(workouts: [WorkoutEntity]) async -> Result<Void, Error> {
        for workout in workouts {
            do {
                let data = try encoder.encode(workout)
                keyValueStore.set(data, forKey: "\(prefix)\(workout.id)")
            } catch {
                return .failure(error)
            }
        }
        return .success(())
    }
    
    func loadWorkout(id: Int) async -> Result<WorkoutEntity, Error> {
        let key = "\(prefix)\(id)"
        guard let data = keyValueStore.data(forKey: key) else {
            return .failure(WorkoutPersistableError.notFound)
        }
        do {
            let workout = try decoder.decode(WorkoutEntity.self, from: data)
            return .success(workout)
        } catch {
            return .failure(error)
        }
    }
}
