//
//  CalendarMonthView.swift
//  Calendar
//
//  Created by Petr Kravnik on 06.12.2024.
//

import SwiftUI



struct CalendarMonthView: View {
    let calendarMonth: CalendarMonth
    let columns = Array(repeating: GridItem(.flexible()), count: Calendar.current.shortStandaloneWeekdaySymbols.count)
    let weekdaySymbols = Calendar.current.shortStandaloneWeekdaySymbolsLocalized
    let onTapPreviousMonth: () -> Void
    let onTapNextMonth: () -> Void
    let onTapDay: (Date) -> Void
    
    var body: some View {
        VStack {
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
            Spacer()
        }
        .fontWeight(.semibold)
        .padding()
    }
}

#Preview("This Month") {
    CalendarMonthView(calendarMonth: CalendarMonth(date: .now, highlightedDates: CalendarMonth.sampleDates)) {
        print("Tapped Previous Month")
    } onTapNextMonth: {
        print("Tapped Next Month")
    } onTapDay: { date in
        print("Tapped on day: \(date.description(with: .current))")
    }
}

