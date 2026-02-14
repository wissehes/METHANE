//
//  Set+Toggle.swift
//  METHANE
//
//  Created by Wisse Hes on 14/02/2026.
//

import Foundation

extension Set where Element: Hashable {
    /// Toggle a specific value inside the set.
    ///
    /// If the value exists, it will be removed, otherwise it will be inserted
    mutating func toggle(_ element: Element) {
        if self.contains(element) {
            self.remove(element)
        } else {
            self.insert(element)
        }
    }
}
