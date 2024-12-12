//
//  CalendarCarouselView.swift
//  Calendar
//
//  Created by Petr Kravnik on 07.12.2024.
//

import SwiftUI
import Algorithms

struct CalendarCarouselView: View {
    @State private var selection: CalendarMonth
    @State private var navigationPath = NavigationPath()
    
    let months: [CalendarMonth]
    let events: [CalendarEvent]
    
    init(events: [CalendarEvent]) {
        let a = events.map(\.startDate)
        let x = a.chunked { $0.startOfMonth }
        var localMonths: [CalendarMonth] = []
        for (date, events) in x {
            localMonths.append(CalendarMonth(date: date, highlightedDates: Set(events.map { Calendar.current.startOfDay(for: $0) })))
        }
        let today = Date.now
        let currentMonthStartDate = Calendar.current.startOfDay(for: today.startOfMonth)
        if let currentMonth = localMonths.first(where: { $0.startDate == currentMonthStartDate }) {
            print("found")
            self.selection = currentMonth
        } else {
            print("not found")
            let currentMonth = CalendarMonth(date: today)
            localMonths.append(currentMonth)
            self.selection = currentMonth
        }
        self.months = localMonths.sorted(by: \.startDate)
        self.events = events
    }
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            TabView(selection: $selection) {
                ForEach(months, id: \.self) { month in
                    CalendarView(calendarMonth: month) {
                        selection = months.previous(of: month)!
                    } onTapNextMonth: {
                        selection = months.next(of: month)!
                    } onTapDay: { date in
                        if let calendarEvent = events.first(where: { Calendar.current.startOfDay(for: $0.startDate) == date }) {
                            navigationPath.append(calendarEvent)
                        }
                    }
                    .tag(month)
                }
            }
            .animation(.default, value: selection)
            .tabViewStyle(.page)
            .toolbar(.hidden, for: .navigationBar)
            .navigationDestination(for: CalendarEvent.self) { event in
                Text(event.title)
            }
        }
    }
}

#Preview {
    CalendarCarouselView(events: CalendarEvent.sampleEvents)
}
