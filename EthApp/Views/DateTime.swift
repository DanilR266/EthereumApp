//
//  DateTime.swift
//  EthApp
//
//  Created by Данила on 31.07.2022.
//

import Foundation
import UIKit


class FieldsDateTime {
    
    let labelDate = DateAndTime()
    let datePicker = UIDatePicker()
    
    
    lazy var buttonDate: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0.949, green: 0.953, blue: 0.961, alpha: 1)
        button.layer.cornerRadius = 10
        button.setTitle(Resources.Labels.setDate, for: .normal)
        button.setTitleColor(UIColor(red: 0.486, green: 0.537, blue: 0.639, alpha: 1), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        button.titleLabel?.textAlignment = .center
        button.translatesAutoresizingMaskIntoConstraints = false
        
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .inline
        return button
    }()
    
    lazy var buttonTime: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0.949, green: 0.953, blue: 0.961, alpha: 1)
        button.layer.cornerRadius = 10
        button.setTitle(Resources.Labels.setTime, for: .normal)
        button.setTitleColor(UIColor(red: 0.486, green: 0.537, blue: 0.639, alpha: 1), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        button.titleLabel?.textAlignment = .center
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
}

protocol NotifyReloadCoreData {
    func notifyDelegate()
}
