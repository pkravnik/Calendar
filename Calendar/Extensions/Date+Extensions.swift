//
//  Date+Extensions.swift
//  Calendar
//
//  Created by Petr Kravnik on 09.12.2024.
//

import Foundation

extension Date {
    static var yesterday: Date {
        Calendar.current.date(byAdding: .day, value: -1, to: .now)!
    }
    static var threeDaysAgo: Date {
        Calendar.current.date(byAdding: .day, value: -3, to: .now)!
    }
    
    var inOneHour: Date {
        Date(timeInterval: 1*60*60, since: self)
    }
    
    var inTwoHours: Date {
        Date(timeInterval: 2*60*60, since: self)
    }
    
    var startOfMonth: Date {
        Calendar.current.dateInterval(of: .month, for: self)!.start
    }
}
