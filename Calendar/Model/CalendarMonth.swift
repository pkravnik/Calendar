//
//  CalendarMonth.swift
//  Calendar
//
//  Created by Petr Kravnik on 11.12.2024.
//

import Foundation

struct CalendarMonth: Identifiable, Hashable {
    let startDate: Date
    let hightlightedDates: Set<Date>
    
    init(date: Date = .now, highlightedDates: Set<Date> = []) {
        self.startDate = date.startOfMonth
        self.hightlightedDates = highlightedDates
    }
    
    var id: Date { startDate }

    static var sampleDates: Set<Date> {
        let today = Date.now
        let dates = (0..<10)
            .map { _ in Int.random(in: -15..<15) }
            .map { today.addingTimeInterval(Double($0*24*60*60)) }
            .map { Calendar.current.startOfDay(for: $0) }
        return Set(dates)
    }
    
    var calendayDays: [CalendarDay] {
        Calendar.current.daysInMonthCalendar(from: startDate, highlightedDates: hightlightedDates)
    }
}
