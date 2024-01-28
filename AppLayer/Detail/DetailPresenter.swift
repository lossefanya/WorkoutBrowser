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
    let isVariation: Bool
    let useCase: WorkoutDetailUseCase
    let workout: WorkoutEntity
    @Published var contents: [Content] = []
    
    init(workout: WorkoutEntity, isVariation: Bool = false, useCase: WorkoutDetailUseCase) {
        self.workout = workout
        self.isVariation = isVariation
        self.useCase = useCase
        
        var contents: [Content] = [.description(workout.description)]
        if workout.images.count > 0 {
            contents.append(.images(workout.images))
        }
        self.contents = contents
        
        if !isVariation, workout.variations.count > 0 {
            loadVariations()
        }
    }
    
    func loadVariations() {
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
