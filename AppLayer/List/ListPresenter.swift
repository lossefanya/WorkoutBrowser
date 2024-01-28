//
//  ListPresenter.swift
//  WorkoutBrowser
//
//  Created by Yeongweon Park on 27.01.24.
//

import Foundation

class ListPresenter: ObservableObject {
    @Published var isLoading: Bool
    @Published var workouts: [WorkoutEntity]
    let listUseCase: WorkoutListUseCase
    
    init(isLoading: Bool = true, workouts: [WorkoutEntity] = [], listUseCase: WorkoutListUseCase) {
        self.isLoading = isLoading
        self.workouts = workouts
        self.listUseCase = listUseCase
    }
    
    func loadWorkouts() {
        Task {
            let result = await listUseCase.loadWorkouts()
            try? await Task.sleep(nanoseconds: 1_000_000_000) // to show animation little bit
            switch result {
            case .success(let workouts):
                self.workouts = workouts
                isLoading = false
            case .failure(let error):
                break
            }
        }
    }
    
    func select(workout: WorkoutEntity) {
        
    }
}

