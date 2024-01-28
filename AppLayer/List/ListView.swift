//
//  ListView.swift
//  WorkoutBrowser
//
//  Created by Yeongweon Park on 27.01.24.
//

import SwiftUI
import Lottie

struct ListView: View {
    @ObservedObject var presenter: ListPresenter
    var body: some View {
        if presenter.isLoading {
            LottieView(animation: .named("Workout"))
                .playing(loopMode: .loop)
        }
    }
}

#Preview {
    ListView(presenter: ListPresenter())
}
