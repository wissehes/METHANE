//
//  Navigation.swift
//  METHANE
//
//  Created by Wisse Hes on 14/02/2026.
//

import Foundation
import SwiftUI

@Observable
final class Navigation {
    var path = NavigationPath()
}

extension EnvironmentValues {
    private struct NavigationKey: EnvironmentKey {
        static let defaultValue = Navigation()
    }

    var navigation: Navigation {
        get { self[NavigationKey.self] }
        set { self[NavigationKey.self] = newValue }
    }
}
