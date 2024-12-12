//
//  CalendarDay.swift
//  Calendar
//
//  Created by Petr Kravnik on 11.12.2024.
//

import Foundation

struct CalendarDay: Identifiable, Hashable {
    let date: Date
    let isCurrentMonth: Bool
    let isWeekend: Bool
    let isToday: Bool
    var isHighlighted: Bool
    
    var id: Date { date }
    
    init(date: Date, isCurrentMonth: Bool, isHighlighted: Bool) {
        let today = Date.now
        self.date = date
        self.isCurrentMonth = isCurrentMonth
        self.isWeekend = Calendar.current.isDateInWeekend(date)
        self.isToday = Calendar.current.startOfDay(for: today) == Calendar.current.startOfDay(for: date)
        self.isHighlighted = self.isCurrentMonth && isHighlighted
    }
}
