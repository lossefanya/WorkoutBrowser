//
//  ViewController.swift
//  WorkoutBrowser
//
//  Created by Yeongweon Park on 27.01.24.
//

import UIKit
import Lottie

class IntroViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let animationView = LottieAnimationView(animation: .named("Workout"))
        animationView.frame = view.bounds
        view.addSubview(animationView)
        animationView.play(toProgress: 1, loopMode: .loop)
    }

    
}

