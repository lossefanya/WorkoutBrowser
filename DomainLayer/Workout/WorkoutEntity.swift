//
//  Workout.swift
//  WorkoutBrowser
//
//  Created by Yeongweon Park on 27.01.24.
//

import Foundation

struct WorkoutEntity: Codable {
    let id: Int
    let name: String
    let uuid: String
    let description: AttributedString
    let images: [String]
    let variations: [Int]
}
