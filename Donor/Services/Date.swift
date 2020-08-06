//
//  Date.swift
//  Donor
//
//  Created by Egor Tereshonok on 8/6/20.
//  Copyright © 2020 Egor Tereshonok. All rights reserved.
//

import Foundation

fileprivate var dateFormatterLocale: Locale?

public extension DateFormatter {
    
    static func setLocale(_ locale: Locale) { dateFormatterLocale = locale }
    
    convenience init(_ format: String) {
        self.init()
        self.dateFormat = format
        if let locale = dateFormatterLocale { self.locale = locale }
    }
}

public extension Date {
    
    //MARK: - Elements
    
    var second:        Int { return Calendar.current.component(.second,  from: self) }
    var minute:        Int { return Calendar.current.component(.minute,  from: self) }
    var hour:          Int { return Calendar.current.component(.hour,    from: self) }
    var day:           Int { return Calendar.current.component(.day,     from: self) }
    var month:         Int { return Calendar.current.component(.month,   from: self) }
    var year:          Int { return Calendar.current.component(.year,    from: self) }
    var weekdayNumber: Int { return Calendar.current.component(.weekday, from: self) }
    
    static func today() -> Date {
        let current = Date()
        var dateComponents = DateComponents()
        dateComponents.year = current.year
        dateComponents.month = current.month
        dateComponents.day = current.day 
        return NSCalendar(calendarIdentifier: .gregorian)!.date(from: dateComponents)!
    }
    static func todayPlus1() -> Date {
        let current = Date()
        var dateComponents = DateComponents()
        dateComponents.year = current.year
        dateComponents.month = current.month
        dateComponents.day = current.day + 1
        return NSCalendar(calendarIdentifier: .gregorian)!.date(from: dateComponents)!
    }
}

public func -(left: Date, right: Date) -> Date {
    return Date(timeIntervalSinceReferenceDate: left.timeIntervalSinceReferenceDate - right.timeIntervalSinceReferenceDate)
}
