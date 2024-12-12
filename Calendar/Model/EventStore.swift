//
//  EventStore.swift
//  Calendar
//
//  Created by Petr Kravnik on 12.12.2024.
//

import SwiftUI

@Observable
final class EventStore {
    private var events: [CalendarEvent]
    private(set) var months: [CalendarMonth]
    
    var selection: Int
    
    func events(for month: CalendarMonth) -> [CalendarEvent] {
        events.filter { Calendar.current.startOfDay(for: $0.startDate.startOfMonth) == month.startDate }
    }
    
    func previousMonth() {
        selection = max(selection - 1, 0)
    }
    
    func nextMonth() {
        selection = min(selection + 1, months.count - 1)
    }
    
    init(events: [CalendarEvent] = CalendarEvent.sampleEvents) {
        self.events = events
        var eventMonths = EventStore.months(from: events)
        let currentMonthStartDate = Date.now.startOfMonth
        if let indexOfCurrentMonth = eventMonths.firstIndex(where: { $0.startDate == currentMonthStartDate }) {
            self.selection = indexOfCurrentMonth
        } else {
            eventMonths.append(CalendarMonth())
            self.selection = eventMonths.count - 1
        }
        self.months = eventMonths
    }
    
    static func months(from events: [CalendarEvent]) -> [CalendarMonth] {
        events.map(\.startDate).chunked { $0.startOfMonth }.map { (date, events) in
            CalendarMonth(date: date, highlightedDates: Set(events.map { Calendar.current.startOfDay(for: $0) }))
        }
    }
}
