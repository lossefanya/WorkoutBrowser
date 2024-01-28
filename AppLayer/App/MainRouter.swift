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
        let presenter = ListPresenter()
        let view = ListView(presenter: presenter).hosting
        view.navigationController?.isNavigationBarHidden = true
        navigation.pushViewController(view, animated: false)
    }
    
}
