//
//  View+HostingController.swift
//  WorkoutBrowser
//
//  Created by Yeongweon Park on 28.01.24.
//

import SwiftUI

extension View {
    var hosting: UIHostingController<Self> {
        .init(rootView: self)
    }
}
