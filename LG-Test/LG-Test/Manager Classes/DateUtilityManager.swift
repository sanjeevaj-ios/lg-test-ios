//
//  DateUtilityManager.swift
//  LG-Test
//
//  Copyright © 2019 Sanjeeva-Test. All rights reserved.
//

import Foundation

class DateUtilityManager {

    func getTheRemainingTime(fromDate: Date, toDate: Date) -> String {
        let calendarDays = Calendar.current.dateComponents([.hour, .minute, .second], from: fromDate, to: toDate)
        return "\(calendarDays.hour ?? 0):\(calendarDays.minute ?? 0):\(calendarDays.second ?? 0)"
    }
}

