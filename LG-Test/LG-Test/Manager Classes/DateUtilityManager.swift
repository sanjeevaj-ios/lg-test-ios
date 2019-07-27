//
//  DateUtilityManager.swift
//  LG-Test
//
//  Copyright © 2019 Sanjeeva-Test. All rights reserved.
//

import Foundation

class DateUtilityManager {

    let dateFormatter = DateFormatter()

    func getTheRemainingTime(fromDate: Date, toDate: Date) -> String {
        let calendarDays = Calendar.current.dateComponents([.hour, .minute, .second], from: fromDate, to: toDate)
        if (calendarDays.hour != nil && calendarDays.minute != nil && calendarDays.second != nil) {
            let displayHour = calendarDays.hour! < 10 ? "0\(calendarDays.hour!)" : "\(calendarDays.hour!)"
            let displayMinute = calendarDays.minute! < 10 ? "0\(calendarDays.minute!)" : "\(calendarDays.minute!)"
            let displaySeconds = calendarDays.second! < 10 ? "0\(calendarDays.second!)" : "\(calendarDays.second!)"

            return displayHour + ":" + displayMinute + ":" + displaySeconds
            
        } else {
            return "00:00:00"
        }

    }
}

