//
//  WorkoutProvider.swift
//  WorkoutBrowser
//
//  Created by Yeongweon Park on 27.01.24.
//

import Foundation

final class WorkoutProvider: WorkoutProvidable {
    func loadWorkouts() async -> Result<[WorkoutEntity], Error> {
        guard let url = URL(string: "https://wger.de/api/v2/exerciseinfo/") else {
            return .failure(WorkoutProvidableError.invalidURL)
        }
        let request = URLRequest(url: url)
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            guard let result = try? JSONDecoder().decode(WorkoutResponse.self, from: data) else {
                return .failure(WorkoutProvidableError.parsingFailure)
            }

            return .success(result.results.map { $0.asEntity })
        } catch {
            return .failure(error)
        }
    }
    
    func loadWorkout(id: Int) async -> Result<WorkoutEntity, Error> {
        guard let url = URL(string: "https://wger.de/api/v2/exerciseinfo/\(id)") else {
            return .failure(WorkoutProvidableError.invalidURL)
        }
        let request = URLRequest(url: url)
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            guard let result = try? JSONDecoder().decode(WorkoutInfoResponse.self, from: data) else {
                return .failure(WorkoutProvidableError.parsingFailure)
            }

            return .success(result.asEntity)
        } catch {
            return .failure(error)
        }
    }
}
