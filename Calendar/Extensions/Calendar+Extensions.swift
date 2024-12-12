//
//  Calendar+Extensions.swift
//  Calendar
//
//  Created by Petr Kravnik on 06.12.2024.
//

import Foundation



extension Calendar {
    var shortStandaloneWeekdaySymbolsLocalized: [String] {
        var localizedSymbols: [String] = shortStandaloneWeekdaySymbols
        let weekDaysCount = localizedSymbols.count
        for index in 0..<firstWeekday-1 {
            localizedSymbols.append(localizedSymbols[index])
        }
        return Array(localizedSymbols.suffix(weekDaysCount))
    }
    
    func daysInMonthCalendar(from effectiveDate: Date, highlightedDates: Set<Date> = []) -> [CalendarDay] {
        var result: [CalendarDay] = []
        let effectiveMonth = self.component(.month, from: effectiveDate)
        let matchingComponents = DateComponents(hour: 0, minute: 0, second: 0)
        
        self.enumerateDates(startingAfter: effectiveDate, matching: matchingComponents, matchingPolicy: .nextTime, direction: .backward) { date, exactMatch, stop in
            guard let date else { stop = true; return }
            result.append(CalendarDay(date: date, isCurrentMonth: component(.month, from: date) == effectiveMonth, isHighlighted: highlightedDates.contains(date)))
            if component(.weekday, from: date) == firstWeekday && (component(.month, from: date) != effectiveMonth || component(.day, from: date) == 1) {
                stop = true
            }
        }
        result.reverse()
        result.append(CalendarDay(date: effectiveDate, isCurrentMonth: true, isHighlighted: highlightedDates.contains(effectiveDate)))
        
        self.enumerateDates(startingAfter: effectiveDate, matching: matchingComponents, matchingPolicy: .nextTime, direction: .forward) { date, exactMatch, stop in
            guard let date else { stop = true; return }
            result.append(CalendarDay(date: date, isCurrentMonth: component(.month, from: date) == effectiveMonth, isHighlighted: highlightedDates.contains(date)))
            if component(.weekday, from: date) == firstWeekday && (component(.month, from: date) != effectiveMonth || component(.day, from: date) == 1) {
                stop = true
            }
        }
        
        return result.dropLast()
    }
    
    func daysTwoMonthAround(from effectiveDate: Date, count: Int) -> [Date] {
        var result: [Date] = []
        var countFound = 0
        let matchingComponents = DateComponents(day: 1, hour: 13, minute: 0, second: 0)
        self.enumerateDates(startingAfter: effectiveDate, matching: matchingComponents, matchingPolicy: .nextTime, direction: .backward) { date, exactMatch, stop in
            guard let date else { stop = true; return }
            result.append(date)
            countFound += 1
            if countFound == count { stop = true }
        }
        result.reverse()
        countFound = 0
        self.enumerateDates(startingAfter: effectiveDate, matching: matchingComponents, matchingPolicy: .nextTime, direction: .forward) { date, exactMatch, stop in
            guard let date else { stop = true; return }
            result.append(date)
            countFound += 1
            if countFound == count { stop = true }
        }
        
        return result
    }
}
