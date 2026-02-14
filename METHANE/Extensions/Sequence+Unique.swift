//
//  Sequence+Unique.swift
//  METHANE
//
//  Created by Wisse Hes on 14/02/2026.
//

import Foundation

extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var seen: Set<Iterator.Element> = []
        return filter { seen.insert($0).inserted }
    }
}
