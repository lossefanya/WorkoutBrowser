//
//  WorkoutInteractor.swift
//  WorkoutBrowser
//
//  Created by Yeongweon Park on 27.01.24.
//

import Foundation

actor WorkoutInteractor {
    let provider: WorkoutProvidable
    let persistence: WorkoutPersistable
    
    init(provider: WorkoutProvidable, persistence: WorkoutPersistable) {
        self.provider = provider
        self.persistence = persistence
    }
}

extension WorkoutInteractor: WorkoutListUseCase {
    func loadWorkouts() async -> Result<[WorkoutEntity], Error> {
        let result = await provider.loadWorkouts()
        if case let .success(workouts) = result {
            Task.detached {
                await self.persistence.save(workouts: workouts)
            }
        }
        return result
    }
}

extension WorkoutInteractor: WorkoutDetailUseCase {
    func loadWorkout(id: Int) async -> Result<WorkoutEntity, Error> {
        let result = await loadWorkoutFromAPI(id: id)
        switch result {
        case .success:
            return result
        case .failure:
            return await persistence.loadWorkout(id: id)
        }
    }
    
    private func loadWorkoutFromAPI(id: Int) async -> Result<WorkoutEntity, Error> {
        let result = await provider.loadWorkout(id: id)
        if case let .success(workout) = result {
            Task.detached {
                await self.persistence.save(workouts: [workout])
            }
        }
        return result
    }
}
