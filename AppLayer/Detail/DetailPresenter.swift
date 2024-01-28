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
        case variants([WorkoutEntity])
    }
    let isVariant: Bool
    let useCase: WorkoutDetailUseCase
    let workout: WorkoutEntity
    @Published var contents: [Content] = []
    
    init(workout: WorkoutEntity, isVariant: Bool = false, useCase: WorkoutDetailUseCase) {
        self.workout = workout
        self.isVariant = isVariant
        self.useCase = useCase
        
        var contents: [Content] = [.description(workout.description)]
        if workout.images.count > 0 {
            contents.append(.images(workout.images))
        }
        self.contents = contents
    }
    
    func loadDetail(id: Int) {
        Task {
            let result = await useCase.loadWorkout(id: id)
            switch result {
            case .success(let workout):
                DispatchQueue.main.async { [weak self] in
                    
                }
            case .failure(let error):
                break
            }
        }
    }
}

extension DetailPresenter.Content {
    var title: String {
        switch self {
        case .description: return "Description"
        case .images: return "Images"
        case .variants: return "Variants"
        }
    }
}
