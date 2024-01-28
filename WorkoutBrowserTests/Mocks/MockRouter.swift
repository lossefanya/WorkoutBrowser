//
//  MockRouter.swift
//  WorkoutBrowserTests
//
//  Created by Yeongweon Park on 28.01.24.
//

import Foundation
@testable import WorkoutBrowser

final class MockRouter: DetailRoutable {
    
    var showDetailCallCount = 0
    var isVariationValue = false
    func showDetail(for workout: WorkoutBrowser.WorkoutEntity, isVariation: Bool) {
        showDetailCallCount += 1
        isVariationValue = isVariation
    }
}
