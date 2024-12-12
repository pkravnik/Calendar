//
//  Array+Next.swift
//  Calendar
//
//  Created by Petr Kravnik on 08.12.2024.
//

import Foundation

extension Array where Element: Equatable {
    public func next(of element: Element) -> Element? {
        guard let index = self.firstIndex(where: {$0 == element}) else { return self.last }
        if index+1 < self.endIndex {
            return self[index+1]
        } else {
            return self.last
        }
    }
    
    public func previous(of element: Element) -> Element? {
        guard let index = self.firstIndex(where: {$0 == element}) else { return self.first }
        if index-1 >= self.startIndex {
            return self[index-1]
        } else {
            return self.first
        }
    }
}

