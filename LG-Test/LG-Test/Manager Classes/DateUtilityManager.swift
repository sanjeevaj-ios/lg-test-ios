//
//  DateUtilityManager.swift
//  LG-Test
//
//  Copyright © 2019 Sanjeeva-Test. All rights reserved.
//

import Foundation

class DateUtilityManager {

    let millisecondInterval = 1595275200000.0

    func getTheRemainingTime() -> String {
        let remainingDate = Date(timeIntervalSince1970: millisecondInterval/1000.0)
        let calendarDays = Calendar.current.dateComponents([.hour, .minute, .second], from: Date(), to: remainingDate)
        return "\(calendarDays.hour ?? 0) : \(calendarDays.minute ?? 0) : \(calendarDays.second ?? 0)"
    }
}

