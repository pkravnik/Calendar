//
//  Sequence+Extensions.swift
//  Calendar
//
//  Created by Petr Kravnik on 12.12.2024.
//

import Foundation

extension Sequence {
    func sorted<T: Comparable>(by keyPath: KeyPath<Element, T>) -> [Element] {
        return sorted { a, b in
            return a[keyPath: keyPath] < b[keyPath: keyPath]
        }
    }
    
    func uniqued() -> [Element] where Element: Hashable {
        var set = Set<Element>()
        return self.compactMap { element in
            if set.contains(element) {
                return nil
            } else {
                set.insert(element)
                return element
            }
        }
    }
}
