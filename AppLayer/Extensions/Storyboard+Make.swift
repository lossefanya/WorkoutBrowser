//
//  Storyboard+Make.swift
//  WorkoutBrowser
//
//  Created by Yeongweon Park on 28.01.24.
//

import UIKit

protocol Identifiable {}
extension Identifiable {
    static var identifier: String { return String(describing: Self.self) }
}

extension UIViewController: Identifiable {}

extension UIViewController {
    static func make() -> Self? {
        let storyBoard = UIStoryboard(name: identifier, bundle: nil)
        return storyBoard.instantiateViewController(withIdentifier: identifier) as? Self
    }
}
