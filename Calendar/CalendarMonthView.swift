//
//  CalendarMonthView.swift
//  Calendar
//
//  Created by Petr Kravnik on 06.12.2024.
//

import SwiftUI



struct CalendarMonthView: View {
    @Environment(EventStore.self) private var eventStore
    let calendarMonth: CalendarMonth
    let columns = Array(repeating: GridItem(.flexible()), count: Calendar.current.shortStandaloneWeekdaySymbols.count)
    let weekdaySymbols = Calendar.current.shortStandaloneWeekdaySymbolsLocalized
    let onTapPreviousMonth: () -> Void
    let onTapNextMonth: () -> Void
    let onTapDay: (Date) -> Void
    
    var body: some View {
        List {
            VStack {
                header
                calendar
                
            }
            .fontWeight(.semibold)
            
            ForEach(eventStore.events(for: calendarMonth)) { event in
                HStack {
                    RoundedRectangle(cornerRadius: 3)
                        .frame(width: 6)
                        .foregroundStyle(Color.cyan)
                    VStack(alignment: .leading) {
                        Text(event.title)
                            .font(.headline)
                            .foregroundStyle(.primary)
                        Text("⚐ \(event.location)")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text(event.startDate, format: .dateTime.hour().minute())
                            .foregroundStyle(.primary)
                        Text(event.endDate, format: .dateTime.hour().minute())
                            .foregroundStyle(.secondary)
                    }
                }
            }
        }
        .listStyle(.plain)
    }
    
    var header: some View {
        Grid {
            GridRow {
                Button(action: onTapPreviousMonth) {
                    Image(systemName: "chevron.left")
                }
                Text(calendarMonth.startDate, format: .dateTime.month(.wide).year())
                    .font(.title)
                    .frame(maxWidth: .infinity)
                    .gridCellColumns(5)
                
                Button(action: onTapNextMonth) {
                    Image(systemName: "chevron.right")
                }
            }
        }
    }
    
    var calendar: some View {
        CalendarLayout(daysInWeek: 7, spacing: 4)/*LazyVGrid(columns: columns)*/ {
            ForEach(weekdaySymbols.indices, id: \.self) { index in
                Text(weekdaySymbols[index])
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .fontWeight(.heavy)
                    .font(.title3)
                    .foregroundStyle(.primary.opacity(0.7))
            }
            
            ForEach(calendarMonth.calendayDays) { calendarDay in
                CalendarDayView(calendarDay: calendarDay, onTapCalendarDay: onTapDay)
            }
        }
    }
}

#Preview("This Month") {
    let eventStore = EventStore()
    CalendarMonthView(calendarMonth: eventStore.months.last!) {
        print("Tapped Previous Month")
    } onTapNextMonth: {
        print("Tapped Next Month")
    } onTapDay: { date in
        print("Tapped on day: \(date.description(with: .current))")
    }
    .environment(eventStore)
}

