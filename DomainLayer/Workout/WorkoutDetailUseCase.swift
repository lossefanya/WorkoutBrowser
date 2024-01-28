//
//  WorkoutDetailUseCase.swift
//  WorkoutBrowser
//
//  Created by Yeongweon Park on 27.01.24.
//

import Foundation

protocol WorkoutDetailUseCase {
    func loadWorkout(id: Int) async -> Result<WorkoutEntity, Error>
}
