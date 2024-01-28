//
//  MainRouter.swift
//  WorkoutBrowser
//
//  Created by Yeongweon Park on 27.01.24.
//

import UIKit

final class MainRouter {
    let navigation = UINavigationController()
    
    func start() {
        let provider = WorkoutProvider()
        let persistence = WorkoutPersistence()
        let useCase = WorkoutInteractor(
            provider: provider,
            persistence: persistence
        )
        let presenter = ListPresenter(listUseCase: useCase)
        let view = ListView(presenter: presenter).hosting
        view.navigationItem.title = "Workouts"
        navigation.pushViewController(view, animated: false)
    }
    
}
