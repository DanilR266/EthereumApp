//
//  GetTime.swift
//  EthApp
//
//  Created by Данила on 30.07.2022.
//

import UIKit
import Foundation


func getDay() -> String {
    let index = Calendar.current.component(.weekday, from: Date()) // this returns an Int
    if index == 1 {
        return "Вс"
    }
    switch Calendar.current.weekdaySymbols[index - 1] {
    case "понедельник", "Monday":
        return "Пн"
    case "вторник", "Tuesday":
        return "Вт"
    case "среда", "Wednesday":
        return "Ср"
    case "четверг", "Thursday":
        return "Чт"
    case "пятница", "Friday":
        return "Пт"
    case "суббота", "Saturday":
        return "Сб"
    case "воскресенье", "Sunday":
        return "Вс"
    default:
        return ""
    }
}

func getDayPrevious() -> String {
    let index = Calendar.current.component(.weekday, from: Date()) // this returns an Int
    if index == 1 {
        return "Сб"
    }
    switch Calendar.current.weekdaySymbols[index - 2] {
    case "понедельник", "Monday":
        return "Пн"
    case "вторник", "Tuesday":
        return "Вт"
    case "среда", "Wednesday":
        return "Ср"
    case "четверг", "Thursday":
        return "Чт"
    case "пятница", "Friday":
        return "Пт"
    case "суббота", "Saturday":
        return "Сб"
    case "воскресенье", "Sunday":
        return "Вс"
    default:
        return ""
    }
}

extension Date {
    static var yesterday: Date { return Date().dayBefore }
    static var tomorrow:  Date { return Date().dayAfter }
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var lastWeek: Date {
        return Calendar.current.date(byAdding: .second, value: -604800, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: self)!
    }
    var month: Int {
        return Calendar.current.component(.month,  from: self)
    }
    var isLastDayOfMonth: Bool {
        return dayAfter.month != month
    }
}


