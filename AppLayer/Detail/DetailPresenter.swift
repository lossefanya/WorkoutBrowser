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
    
    private(set) var workout: WorkoutEntity
    let isVariation: Bool
    let useCase: WorkoutDetailUseCase
    private weak var router: DetailRoutable?
    @Published var contents: [Content] = []
    
    init(workout: WorkoutEntity, isVariation: Bool = false, useCase: WorkoutDetailUseCase, router: DetailRoutable? = nil) {
        self.workout = workout
        self.isVariation = isVariation
        self.useCase = useCase
        self.router = router

        self.contents = Self.makeContents(for: workout)

        if !isVariation {
            loadDetails()
        }
    }

    private func loadDetails() {
        Task {
            let result = await useCase.loadWorkout(id: workout.id)
            guard case let .success(workoutEntity) = result else {
                return
            }

            workout = workoutEntity
            contents = Self.makeContents(for: workoutEntity)

            guard workoutEntity.variations.count > 0 else {
                return
            }

            await loadVariations(from: workoutEntity)
        }
    }

    private func loadVariations(from workout: WorkoutEntity) async {
        var variations: [WorkoutEntity] = []
        for id in workout.variations {
            let result = await useCase.loadWorkout(id: id)
            if case let .success(workoutEntity) = result {
                variations.append(workoutEntity)
            }
        }

        guard variations.count > 0 else {
            return
        }

        contents = Self.makeContents(for: workout) + [.variations(variations)]
    }
    
    func show(variation: WorkoutEntity) {
        router?.showDetail(for: variation, isVariation: true)
    }
}

extension DetailPresenter {
    private static func makeContents(for workout: WorkoutEntity) -> [Content] {
        var contents: [Content] = [.description(workout.description)]
        if workout.images.count > 0 {
            contents.append(.images(workout.images))
        }

        return contents
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
