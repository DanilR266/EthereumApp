//
//  SetGetDateTime.swift
//  EthApp
//
//  Created by Данила on 01.08.2022.
//

import Foundation
import UIKit

class DateAndTime {
    var defaults = UserDefaults.standard
    func setDTString(dateTime: String) {
        
        defaults.set(dateTime, forKey: "DateTime")
    }
    func getDTString() -> String {
        if let stringOne = defaults.string(forKey: "DateTime") {
            if stringOne == "Выберите дату Выберите время" {
                return "Сейчас"
            }
            return stringOne
        }
        return "Сейчас"
    }
}
