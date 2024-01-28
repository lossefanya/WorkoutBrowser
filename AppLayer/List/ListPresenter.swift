//
//  ListPresenter.swift
//  WorkoutBrowser
//
//  Created by Yeongweon Park on 27.01.24.
//

import Foundation

final class ListPresenter: ObservableObject {
    @Published var isLoading: Bool
    @Published var workouts: [WorkoutEntity]
    private let listUseCase: WorkoutListUseCase
    private weak var router: DetailRoutable?
    
    init(isLoading: Bool = true, workouts: [WorkoutEntity] = [], listUseCase: WorkoutListUseCase, router: DetailRoutable? = nil) {
        self.isLoading = isLoading
        self.workouts = workouts
        self.listUseCase = listUseCase
        self.router = router
    }
    
    func loadWorkouts() {
        Task {
            let result = await listUseCase.loadWorkouts()
            try? await Task.sleep(nanoseconds: 1_000_000_000) // to show animation little bit
            switch result {
            case .success(let workouts):
                DispatchQueue.main.async { [weak self] in
                    self?.workouts = workouts
                    self?.isLoading = false
                }
            case .failure(let error):
                break
            }
        }
    }
    
    func select(workout: WorkoutEntity) {
        router?.showDetail(for: workout, isVariation: false)
    }
}

