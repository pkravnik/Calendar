//
//  CalendarApp.swift
//  Calendar
//
//  Created by Petr Kravnik on 06.12.2024.
//

import SwiftUI

@main
struct CalendarApp: App {
    @State private var eventStore = EventStore()
    var body: some Scene {
        WindowGroup {
            CalendarCarouselView()
                .environment(eventStore)
        }
    }
}
