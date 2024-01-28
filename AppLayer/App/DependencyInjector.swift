//
//  DependencyInjector.swift
//  WorkoutBrowser
//
//  Created by Yeongweon Park on 27.01.24.
//

import Foundation

final class DependencyInjector {
    static let shared = DependencyInjector()

    private var dependencies: [String: Any] = [:]

    func registerDependency<T>(_ dependency: T.Type, instance: Any) {
        let key = String(describing: dependency)
        dependencies[key] = instance
    }

    func resolveDependency<T>(_ dependency: T.Type) -> T? {
        let key = String(describing: dependency)
        return dependencies[key] as? T
    }
}

extension DependencyInjector {
    func registerDependencies() {
        let provider = WorkoutProvider()
        let persistence = WorkoutPersistence()
        let interactor = WorkoutInteractor(
            provider: provider,
            persistence: persistence
        )
        registerDependency(WorkoutListUseCase.self, instance: interactor)
        registerDependency(WorkoutDetailUseCase.self, instance: interactor)
    }
}
