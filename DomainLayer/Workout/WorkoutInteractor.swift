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
        return await provider.loadWorkouts()
    }
}

extension WorkoutInteractor: WorkoutDetailUseCase {
    func loadWorkout(id: Int) async -> Result<WorkoutEntity, Error> {
        return await provider.loadWorkout(id: id)
    }
}
