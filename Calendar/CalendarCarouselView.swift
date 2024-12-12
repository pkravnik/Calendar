//
//  CalendarCarouselView.swift
//  Calendar
//
//  Created by Petr Kravnik on 07.12.2024.
//

import SwiftUI
import Algorithms

struct CalendarCarouselView: View {
    @Environment(EventStore.self) private var eventStore
    @State private var navigationPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            TabView(selection: Bindable(eventStore).selection) {
                ForEach(eventStore.months.indices, id: \.self) { index in
                    CalendarMonthView(calendarMonth: eventStore.months[index], onTapPreviousMonth: eventStore.previousMonth, onTapNextMonth: eventStore.nextMonth) { date in
                        print("Date: \(date)")
                    }
                    .tag(index)
                }
            }
            .animation(.default, value: eventStore.selection)
            .tabViewStyle(.page)
            .toolbar(.hidden, for: .navigationBar)
            .navigationDestination(for: CalendarEvent.self) { event in
                Text(event.title)
            }
        }
    }
}

#Preview {
    CalendarCarouselView()
        .environment(EventStore())
}
