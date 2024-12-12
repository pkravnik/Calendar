//
//  CalendarEvent.swift
//  Calendar
//
//  Created by Petr Kravnik on 09.12.2024.
//

import Foundation

struct CalendarEvent: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let location: String
    let startDate: Date
    let endDate: Date
    
    static func sampleDaysAgo(count: Int) -> [Int] {
        return (0..<count)
            .map { _ in Int.random(in: -30..<0) }
    }
    
    static var sampleLocations: [String] {
        ["London", "Paris", "Berlin", "Madrid", "Tokyo", "New York"]
    }
    
    static var sampleTitles: [String] {
        ["SwiftUI", "Combine", "UIKit", "Dynamics AX", "Next ERP", "Agile"]
    }
    
    static var sampleDurations: [TimeInterval] {
        [0.5, 1, 1.5, 2, 2.5].map { $0 * 3_600 }
    }
    
    static var sampleStartTime: [Int] {
        [8, 12, 14, 16, 18]
    }
    
    static var sampleEvents: [CalendarEvent] {
        let today = Date.now
        return sampleDaysAgo(count: 10).map { daysAgo in
            let eventHour = sampleStartTime.randomElement()!
            let eventTime = Calendar.current.date(bySetting: .hour, value: eventHour, of: today)!
            let startDate = Calendar.current.date(byAdding: .day, value: daysAgo, to: eventTime)!
            let endDate = startDate.addingTimeInterval(sampleDurations.randomElement()!)
            return CalendarEvent(title: sampleTitles.randomElement()!, location: sampleLocations.randomElement()!, startDate: startDate, endDate: endDate)
        }.sorted(by: \.startDate)
    }
}
