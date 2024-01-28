//
//  DetailPresenter.swift
//  WorkoutBrowser
//
//  Created by Yeongweon Park on 27.01.24.
//

import Foundation

final class DetailPresenter {
    enum Content {
        case description(AttributedString)
        case images([String])
        case variations([WorkoutEntity])
    }
    
    let workout: WorkoutEntity
    let isVariation: Bool
    let useCase: WorkoutDetailUseCase
    private weak var router: DetailRoutable?
    @Published var contents: [Content] = []
    
    init(workout: WorkoutEntity, isVariation: Bool = false, useCase: WorkoutDetailUseCase, router: DetailRoutable? = nil) {
        self.workout = workout
        self.isVariation = isVariation
        self.useCase = useCase
        self.router = router
        
        var contents: [Content] = [.description(workout.description)]
        if workout.images.count > 0 {
            contents.append(.images(workout.images))
        }
        self.contents = contents
        
        if !isVariation, workout.variations.count > 0 {
            loadVariations()
        }
    }
    
    private func loadVariations() {
        Task {
            var variations: [WorkoutEntity] = []
            for id in workout.variations {
                let result = await useCase.loadWorkout(id: id)
                if case let .success(workoutEntity) = result {
                    variations.append(workoutEntity)
                }
            }
            
            contents = contents + [.variations(variations)]
        }
    }
    
    func show(variation: WorkoutEntity) {
        router?.showDetail(for: variation, isVariation: true)
    }
}

extension DetailPresenter.Content {
    var title: String {
        switch self {
        case .description: return "Description"
        case .images: return "Images"
        case .variations: return "Variations"
        }
    }
}
