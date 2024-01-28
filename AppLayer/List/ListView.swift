//
//  ListView.swift
//  WorkoutBrowser
//
//  Created by Yeongweon Park on 27.01.24.
//

import SwiftUI
import Lottie

@MainActor
struct ListView: View {
    @ObservedObject var presenter: ListPresenter
    var body: some View {
        if presenter.isLoading {
            LottieView(animation: .named("Workout"))
                .playing(loopMode: .loop)
                .onAppear {
                    presenter.loadWorkouts()
                }
        } else {
            List(presenter.workouts, id: \.id) { workout in
                VStack {
                    AsyncImage(
                        url: workout.imageURL,
                        content: { image in
                            image.resizable()
                                 .aspectRatio(contentMode: .fit)
                                 .frame(maxWidth: .infinity, maxHeight: 100)
                        },
                        placeholder: {
                            Image(systemName: "dumbbell")
                                .resizable()
                                .frame(maxWidth: .infinity, maxHeight: 40)
                                .aspectRatio(contentMode: .fit)
                                .padding(30)
                        }
                    )
                    
                    Text(workout.name)
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding()
                .listRowSeparator(.hidden)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .onTapGesture {
                    presenter.select(workout: workout)
                }
            }
            .listStyle(.plain)
        }
    }
}

extension WorkoutEntity {
    var imageURL: URL? {
        guard let first = images.first else {
            return nil
        }
        return URL(string: first)
    }
}

#Preview {
    ListView(presenter: ListPresenter(listUseCase: MockUseCase()))
}

struct MockUseCase: WorkoutListUseCase {
    func loadWorkouts() async -> Result<[WorkoutEntity], Error> {
        return .success([])
    }
}
