//
//  WorkoutListUseCase.swift
//  WorkoutBrowser
//
//  Created by Yeongweon Park on 27.01.24.
//

import Foundation

protocol WorkoutListUseCase {
    func loadWorkouts() async -> Result<[WorkoutEntity], Error>
}
