//
//  CalendarDayView.swift
//  Calendar
//
//  Created by Petr Kravnik on 11.12.2024.
//

import SwiftUI

extension CalendarDay {
    var foregroundColor: Color {
        if isCurrentMonth {
            if isHighlighted {
                return .white
            } else if isToday {
                return .cyan
            } else if isWeekend {
                return .red
            } else {
                return .primary
            }
        } else {
            return .primary.opacity(0.3)
        }
    }
    
    var backgroundColor: Color {
        if isHighlighted {
            if isWeekend {
                return .red.opacity(0.7)
            } else {
                return .cyan.opacity(0.7)
            }            
        } else if isToday {
            return .gray.opacity(0.3)
        } else {
            return .clear
        }
    }
}

struct CalendarDayView: View {
    let calendarDay: CalendarDay
    let onTapCalendarDay: (Date) -> Void
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(calendarDay.backgroundColor)
            
            Text(calendarDay.date, format: .dateTime.day())
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .font(.title2)
                .foregroundStyle(calendarDay.foregroundColor)
        }
        .onTapGesture {
            onTapCalendarDay(calendarDay.date)
        }
    }
}

#Preview {
    VStack {
        CalendarDayView(calendarDay: CalendarDay(date: .now.addingTimeInterval(-86400), isCurrentMonth: true, isHighlighted: false)) { _ in }
        CalendarDayView(calendarDay: CalendarDay(date: .now.addingTimeInterval(-86400), isCurrentMonth: true, isHighlighted: true)) { _ in }
        CalendarDayView(calendarDay: CalendarDay(date: .now, isCurrentMonth: true, isHighlighted: false)) { _ in }
        CalendarDayView(calendarDay: CalendarDay(date: Calendar.current.date(from: DateComponents(year: 2024, month: 12, day: 14, hour: 12, minute: 0))!, isCurrentMonth: true, isHighlighted: false)) { _ in }
        CalendarDayView(calendarDay: CalendarDay(date: Calendar.current.date(from: DateComponents(year: 2024, month: 12, day: 14, hour: 12, minute: 0))!, isCurrentMonth: true, isHighlighted: true)) { _ in }
    }
    .frame(width: 60, height: 240)
}
