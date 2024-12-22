//
//  Date+Extensions.swift
//  Calendar
//
//  Created by Petr Kravnik on 09.12.2024.
//

import Foundation

extension Date {
    var startOfMonth: Date {
        Calendar.current.dateInterval(of: .month, for: self)!.start
    }
}
