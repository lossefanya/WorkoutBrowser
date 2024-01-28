//
//  ListPresenter.swift
//  WorkoutBrowser
//
//  Created by Yeongweon Park on 27.01.24.
//

import Foundation

final class ListPresenter: ObservableObject {
    @Published var isLoading: Bool = true
    @Published var workouts: [String] = []
    
    func loadWorkouts() {
        
    }
}
