//
//  MainRouter.swift
//  WorkoutBrowser
//
//  Created by Yeongweon Park on 27.01.24.
//

import UIKit

protocol DetailRoutable: AnyObject {
    func showDetail(for workout: WorkoutEntity, isVariation: Bool)
}

final class MainRouter {
    let navigation: UINavigationController
    let dependencyInjector: DependencyInjector
    
    init(
        navigation: UINavigationController = UINavigationController(),
        dependencyInjector: DependencyInjector
    ) {
        self.navigation = navigation
        self.dependencyInjector = dependencyInjector
    }
    
    func start() {
        guard let useCase = dependencyInjector.resolveDependency(WorkoutListUseCase.self) else {
            assertionFailure("DEV: Please check dependency registration")
            return
        }
        let presenter = ListPresenter(listUseCase: useCase, router: self)
        let view = ListView(presenter: presenter).hosting
        view.navigationItem.title = "Workouts"
        navigation.pushViewController(view, animated: false)
    }
    
}

extension MainRouter: DetailRoutable {
    func showDetail(for workout: WorkoutEntity, isVariation: Bool) {
        guard let useCase = dependencyInjector.resolveDependency(WorkoutDetailUseCase.self) else {
            assertionFailure("DEV: Please check dependency registration")
            return
        }
        guard let view = DetailViewController.make() else {
            assertionFailure("DEV: Please check DetailViewController storyboard")
            return
        }
        let presenter = DetailPresenter(workout: workout, isVariation: isVariation, useCase: useCase, router: self)
        view.bind(presenter: presenter)
        navigation.pushViewController(view, animated: true)
    }
    
    
}
