//
//  WorkoutInteractor.swift
//  WorkoutBrowser
//
//  Created by Yeongweon Park on 27.01.24.
//

import Foundation

final class WorkoutInteractor {
    let provider: WorkoutProvidable
    let persistence: WorkoutPersistable
    
    init(provider: WorkoutProvidable, persistence: WorkoutPersistable) {
        self.provider = provider
        self.persistence = persistence
    }
}

extension WorkoutInteractor: WorkoutListUseCase {
    func loadWorkouts() async -> [Workout] {
        return []
    }
}

extension WorkoutInteractor: WorkoutDetailUseCase {
    func loadWorkout(id: Int) async -> Workout {
        return Workout()
    }
}
