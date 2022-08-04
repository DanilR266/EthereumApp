//
//  ButtonsLabels.swift
//  EthApp
//
//  Created by Данила on 31.07.2022.
//

import UIKit

class FieldsStyle {
    lazy var iconToday = UIImage(named: "today-2.png")
    lazy var iconYesterday = UIImage(named: "yesterday.png")
    lazy var iconLastWeek = UIImage(named: "lastWeek.png")
    lazy var iconNow = UIImage(named: "now.png")
    
    let screenSize = UIScreen.main.bounds
    
    lazy var iconViewToday = UIImageView(image: iconToday!)
    lazy var iconViewYesterday = UIImageView(image: iconYesterday!)
    lazy var iconViewLastWeek = UIImageView(image: iconLastWeek!)
    lazy var iconViewNow = UIImageView(image: iconNow!)

    
    // labels
    lazy var labelReady: UIButton = {
        let label = UIButton()
        label.setTitle("Готово", for: .normal)
        label.setTitleColor(UIColor(red: 0, green: 0.314, blue: 0.812, alpha: 1), for: .normal)
        label.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    
    lazy var labelCancel: UIButton = {
        let label = UIButton()
        label.setTitle("Отменить", for: .normal)
        label.setTitleColor(UIColor(red: 0, green: 0.314, blue: 0.812, alpha: 1), for: .normal)
        label.titleLabel?.font = .systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    
    lazy var labelToday: UILabel = {
        let label = UILabel()
        label.text = Resources.Days.today
        label.font = .systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    
    lazy var labelYesterday: UILabel = {
        let label = UILabel()
        label.text = Resources.Days.yesterday
        label.font = .systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    
    lazy var labelLastWeek: UILabel = {
        let label = UILabel()
        label.text = Resources.Days.lastWeek
        label.font = .systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    
    lazy var labelNow: UILabel = {
        let label = UILabel()
        label.text = Resources.Days.now
        label.font = .systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    
    
    // labelsShort
    lazy var labelShort: UILabel = {
        let label = UILabel()
        label.text = getDay()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textColor = UIColor(red: 0.486, green: 0.537, blue: 0.639, alpha: 1)
        return label
    }()
    
    lazy var labelShortYes: UILabel = {
        let label = UILabel()
        label.text = getDayPrevious()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textColor = UIColor(red: 0.486, green: 0.537, blue: 0.639, alpha: 1)
        return label
    }()
    
    lazy var labelShortLastWeek: UILabel = {
        let label = UILabel()
        label.text = getDay()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textColor = UIColor(red: 0.486, green: 0.537, blue: 0.639, alpha: 1)
        return label
    }()
    
    
    //MARK: buttons on Sheet
    lazy var buttonToday: UIButton = {
        let button = UIButton()
        button.addSubview(labelToday)
        button.addSubview(labelShort)
        button.addSubview(iconViewToday)

        labelToday.translatesAutoresizingMaskIntoConstraints = false
        labelShort.translatesAutoresizingMaskIntoConstraints = false
        iconViewToday.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            labelToday.leftAnchor.constraint(equalTo: iconViewToday.rightAnchor, constant: screenSize.width/19.73),
            labelToday.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            
            iconViewToday.leftAnchor.constraint(equalTo: button.leftAnchor, constant: screenSize.width/15.625),
            iconViewToday.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            
            labelShort.rightAnchor.constraint(equalTo: button.rightAnchor, constant: -screenSize.width/23.4375),
            labelShort.centerYAnchor.constraint(equalTo: button.centerYAnchor),
        ])
        return button
    }()
    
    lazy var buttonYesterday: UIButton = {
        let button = UIButton()
        button.addSubview(labelYesterday)
        button.addSubview(labelShortYes)
        button.addSubview(iconViewYesterday)
        labelYesterday.translatesAutoresizingMaskIntoConstraints = false
        labelShortYes.translatesAutoresizingMaskIntoConstraints = false
        iconViewYesterday.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([

            labelYesterday.leftAnchor.constraint(equalTo: iconViewYesterday.rightAnchor, constant: screenSize.width/19.73),
            labelYesterday.centerYAnchor.constraint(equalTo: button.centerYAnchor),

            iconViewYesterday.leftAnchor.constraint(equalTo: button.leftAnchor, constant: screenSize.width/15.625),
            iconViewYesterday.centerYAnchor.constraint(equalTo: button.centerYAnchor),

            labelShortYes.rightAnchor.constraint(equalTo: button.rightAnchor, constant: -screenSize.width/23.4375),
            labelShortYes.centerYAnchor.constraint(equalTo: button.centerYAnchor),
        ])
        return button
    }()
    
    lazy var buttonLastWeek: UIButton = {
        let button = UIButton()
        button.addSubview(labelLastWeek)
        button.addSubview(labelShortLastWeek)
        button.addSubview(iconViewLastWeek)
        button.addTarget(nil, action: #selector(HoldDownSec), for: .touchDown)
        button.addTarget(nil, action: #selector(holdReleaseSec), for: .touchUpInside)
        labelLastWeek.translatesAutoresizingMaskIntoConstraints = false
        labelShortLastWeek.translatesAutoresizingMaskIntoConstraints = false
        iconViewLastWeek.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([

            labelLastWeek.leftAnchor.constraint(equalTo: iconViewLastWeek.rightAnchor, constant: screenSize.width/19.73),
            labelLastWeek.centerYAnchor.constraint(equalTo: button.centerYAnchor),

            iconViewLastWeek.leftAnchor.constraint(equalTo: button.leftAnchor, constant: screenSize.width/15.625),
            iconViewLastWeek.centerYAnchor.constraint(equalTo: button.centerYAnchor),

            labelShortLastWeek.rightAnchor.constraint(equalTo: button.rightAnchor, constant: -screenSize.width/23.4375),
            labelShortLastWeek.centerYAnchor.constraint(equalTo: button.centerYAnchor),
        ])
        return button
    }()
    
    lazy var buttonNow: UIButton = {
        let button = UIButton()
        button.addSubview(labelNow)
        button.addSubview(iconViewNow)
        button.addTarget(nil, action: #selector(HoldDownSec), for: .touchDown)
        button.addTarget(nil, action: #selector(holdReleaseSec), for: .touchUpInside)
        labelNow.translatesAutoresizingMaskIntoConstraints = false
        iconViewNow.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            labelNow.leftAnchor.constraint(equalTo: iconViewNow.rightAnchor, constant: screenSize.width/19.73),
            labelNow.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            
            iconViewNow.leftAnchor.constraint(equalTo: button.leftAnchor, constant: screenSize.width/15.625),
            iconViewNow.centerYAnchor.constraint(equalTo: button.centerYAnchor),
        ])
        return button
    }()
    
    
    //MARK: @objc func
    @objc public func HoldDownSec()
        {
            buttonToday.backgroundColor = UIColor(red: 0, green: 0.314, blue: 0.812, alpha: 1)
        }
    @objc public func holdReleaseSec()
        {
            buttonToday.backgroundColor = UIColor(red: 0, green: 0.314, blue: 0.812, alpha: 0.5)
        }
    
    @objc func HoldDownYesterday()
        {
            buttonYesterday.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        }
    @objc func holdReleaseYesterday()
        {
            buttonYesterday.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.5)
        }
    
    @objc func HoldDownLastWeek()
        {
            buttonLastWeek.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        }
    @objc func holdReleaseLastWeek()
        {
            buttonLastWeek.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.5)
        }
    
    @objc func HoldDownNow()
        {
            buttonNow.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        }
    @objc func holdReleaseNow()
        {
            buttonNow.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.5)
        }
    
    

}
