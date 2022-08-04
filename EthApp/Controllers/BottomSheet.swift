//
//  BottomSheet.swift
//  EthApp
//
//  Created by Данила on 30.07.2022.
//
//import UIKit
//
//class Sheet: UIViewController {
//    override func viewDidLoad() {
//        view.backgroundColor = .green
//        super.viewDidLoad()
//    }
//}

import UIKit

class Sheet: UIViewController {

    //MARK: variables
    lazy var buttons = FieldsStyle()
    lazy var buttonsDT = FieldsDateTime()
    let labelDate = DateAndTime()
    
    let screenSize = UIScreen.main.bounds
    
    let picker: UIDatePicker = UIDatePicker()
    let pickerTime: UIDatePicker = UIDatePicker()
    
    let maxDimmedAlpha: CGFloat = 0.6
    var defaultHeight: CGFloat = UIScreen.main.bounds.height/2.35
    var currentContainerHeight: CGFloat = 324
    
    var containerViewHeightConstraint: NSLayoutConstraint?
    var containerViewBottomConstraint: NSLayoutConstraint?
    var buttonConstraint: NSLayoutConstraint?
    var buttonDateWidth: NSLayoutConstraint?
    var buttonTimeWidth: NSLayoutConstraint?

    
    // MARK: override func
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        buttonsAddTarget()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateShowDimmedView()
        animatePresentContainer()
        buttonsDT.buttonDate.addTarget(nil, action: #selector(buttonDate), for: .touchUpInside)
        buttonsDT.buttonTime.addTarget(nil, action: #selector(buttonTime), for: .touchUpInside)
    }
    
    
    // MARK: lazy var
    // buttons
    lazy var labelReady: UIButton = {
        let label = UIButton()
        label.setTitle("Готово", for: .normal)
        label.setTitleColor(UIColor(red: 0, green: 0.314, blue: 0.812, alpha: 1), for: .normal)
        label.setTitleColor(UIColor(red: 0, green: 0.314, blue: 0.812, alpha: 0.6), for: .highlighted)
        label.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    
    lazy var labelCancel: UIButton = {
        let label = UIButton()
        label.setTitle("Отменить", for: .normal)
        label.setTitleColor(UIColor(red: 0, green: 0.314, blue: 0.812, alpha: 1), for: .normal)
        label.setTitleColor(UIColor(red: 0, green: 0.314, blue: 0.812, alpha: 0.6), for: .highlighted)
        label.titleLabel?.font = .systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    
    lazy var labelDelete: UIButton = {
        let label = UIButton()
        label.setTitle("Удалить", for: .normal)
        label.setTitleColor(UIColor(red: 0.902, green: 0.275, blue: 0.275, alpha: 1), for: .normal)
        label.setTitleColor(UIColor(red: 0.902, green: 0.275, blue: 0.275, alpha: 1), for: .highlighted)
        label.isHidden = true
        label.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    
    lazy var buttonSelect: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0, green: 0.314, blue: 0.812, alpha: 1)
        button.setTitle(Resources.Labels.select, for: .normal)
        button.addTarget(nil, action: #selector(HoldDown), for: .touchDown)
        button.addTarget(nil, action: #selector(holdRelease), for: .touchUpInside)
        
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //labels
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.text = Resources.Labels.timeAndDate
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    
    //stackViews
    lazy var contentStackView: UIStackView = {
        let spacer = UIView()
        let stackView = UIStackView(arrangedSubviews: [labelCancel, spacer,  labelReady, labelDelete])
        stackView.axis = .horizontal
        return stackView
    }()
    
    lazy var contentStackButtons: UIStackView = {
        let spacer = UIView()
        let stackView = UIStackView(arrangedSubviews: [spacer, buttons.buttonToday, buttons.buttonYesterday, buttons.buttonLastWeek, buttons.buttonNow, spacer])
        stackView.axis = .vertical
        stackView.spacing = 12
        return stackView
    }()
    
    //UIViews
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()
    
    lazy var dimmedView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = maxDimmedAlpha
        return view
    }()
    
    
    // MARK: Helpers func
    func datePlusTime() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM yyyy, E HH:mm"
        let dateTitle = dateFormatter.string(from: date) // системная дата сейчас
        let dateNow = dateFormatter.date(from:dateTitle)!
        let str = buttonsDT.buttonDate.titleLabel!.text! + " " + buttonsDT.buttonTime.titleLabel!.text!
        guard let dateSelect = dateFormatter.date(from: str) else { return "Сейчас" }
        let dateS = Int(dateSelect.timeIntervalSince1970)
        let dateN = Int(dateNow.timeIntervalSince1970)
        let week = 604800
        if dateN - dateS > week {
            return dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(dateN - week)))
        }
        if dateNow < dateSelect {
            return "Сейчас"
        }
        if dateTitle == str {
            return "Сейчас"
        }
        return buttonsDT.buttonDate.titleLabel!.text! + " " + buttonsDT.buttonTime.titleLabel!.text!
    }
    
    private func buttonsAddTarget() {
        labelReady.addTarget(nil, action: #selector(handleCloseAction), for: .touchUpInside)
        labelCancel.addTarget(nil, action: #selector(handleCloseAction), for: .touchUpInside)
        labelDelete.addTarget(nil, action: #selector(buttonDelete), for: .touchUpInside)
        picker.addTarget(nil, action: #selector(pickerSelectedDate), for: .valueChanged)
        buttonSelect.addTarget(nil, action: #selector(buttonSelectPressed), for: .touchUpInside)
        buttons.buttonToday.addTarget(nil, action: #selector(buttonTodayTap), for: .touchUpInside)
        buttons.buttonNow.addTarget(nil, action: #selector(buttonNowTap), for: .touchUpInside)
        buttons.buttonYesterday.addTarget(nil, action: #selector(buttonYesterdayTap), for: .touchUpInside)
        buttons.buttonLastWeek.addTarget(nil, action: #selector(buttonLastWeekTap), for: .touchUpInside)
    }
    
    @objc func HoldDown() {
            buttonSelect.backgroundColor = UIColor(red: 0, green: 0.314, blue: 0.812, alpha: 0.5)
        }
    @objc func holdRelease() {
        buttonSelect.backgroundColor = UIColor(red: 0, green: 0.314, blue: 0.812, alpha: 1)
        }
    
    
    // MARK: @objc func
    @objc func handleCloseAction() {
        picker.removeFromSuperview()
        pickerTime.removeFromSuperview()
        animateDismissView()
    }
    
    //buttonsTop
    @objc func buttonDelete() {
        animateSheetBack()
        buttonsDT.buttonDate.setTitle(Resources.Labels.setDate, for: .normal)
        buttonsDT.buttonDate.setTitleColor(UIColor(red: 0.486, green: 0.537, blue: 0.639, alpha: 1), for: .normal)
        buttonsDT.buttonTime.setTitle(Resources.Labels.setTime, for: .normal)
        buttonsDT.buttonTime.setTitleColor(UIColor(red: 0.486, green: 0.537, blue: 0.639, alpha: 1), for: .normal)
        buttonDateWidth?.constant = screenSize.width/2.3
        buttonTimeWidth?.constant = screenSize.width/2.3
        buttons.labelShortYes.text! = "\(getDayPrevious())"
        buttons.labelShort.text! = "\(getDay())"
        buttons.labelShortLastWeek.text! = "\(getDay())"
        view.layoutIfNeeded()
    }
    
    //buttonsOnSheet
    @objc func buttonTodayTap() {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM yyyy, E"
        let dateTitle = dateFormatter.string(from: date)
        buttonsDT.buttonDate.setTitle(dateTitle, for: .normal)
        buttonsDT.buttonDate.setTitleColor(UIColor(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
    }
    
    @objc func buttonNowTap() {
        labelDate.setDTString(dateTime: "Сейчас")
        animateDateAndTime()
        let date = Date()
        let dateFormatter = DateFormatter()
        let timeFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM yyyy, E"
        timeFormatter.dateFormat = "HH:mm"
        let dateTitle = dateFormatter.string(from: date)
        let timeTitle = timeFormatter.string(from: date)
        buttonsDT.buttonDate.setTitle(dateTitle, for: .normal)
        buttonsDT.buttonDate.setTitleColor(UIColor(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        buttonsDT.buttonTime.setTitle(timeTitle, for: .normal)
        buttonsDT.buttonTime.setTitleColor(UIColor(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        buttons.labelShortYes.text! = "\(getDayPrevious()), \(timeTitle)"
        buttons.labelShort.text! = "\(getDay()), \(timeTitle)"
        buttons.labelShortLastWeek.text! = "\(getDay()), \(timeTitle)"
    }
    
    @objc func buttonYesterdayTap() {
        var date = Date()
        date = date.dayBefore
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM yyyy, E"
        let dateTitle = dateFormatter.string(from: date)
        buttonsDT.buttonDate.setTitle(dateTitle, for: .normal)
        buttonsDT.buttonDate.setTitleColor(UIColor(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
    }
    
    @objc func buttonLastWeekTap() {
        var date = Date()
        date = date.lastWeek
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM yyyy, E"
        let dateTitle = dateFormatter.string(from: date)
        buttonsDT.buttonDate.setTitle(dateTitle, for: .normal)
        buttonsDT.buttonDate.setTitleColor(UIColor(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
    }
    
    
    // pickers
    @objc func buttonDate() {
        picker.preferredDatePickerStyle = .inline
        picker.backgroundColor = .white
        picker.datePickerMode = .date
//        picker.frame.size.width = containerView.frame.size.width
        picker.center = containerView.center
        containerView.addSubview(picker)
//        picker.setDate(Date(), animated: true)
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        picker.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        picker.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        picker.timeZone = .autoupdatingCurrent
        picker.accessibilityNavigationStyle = .separate
        picker.topAnchor.constraint(equalTo: containerView.topAnchor, constant: screenSize.height/15.53).isActive = true
        picker.minimumDate = Date().lastWeek
        picker.maximumDate = Date()
        animateSheet()
    }
    
    @objc func buttonTime() {
        pickerTime.preferredDatePickerStyle = .wheels
        pickerTime.backgroundColor = .white
        pickerTime.datePickerMode = .time
        pickerTime.locale = Locale(identifier: "en_UK")
        pickerTime.frame.size.width = containerView.frame.size.width
        pickerTime.center = containerView.center
        pickerTime.setDate(Date(), animated: true)
        containerView.addSubview(pickerTime)
        pickerTime.translatesAutoresizingMaskIntoConstraints = false
        pickerTime.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -screenSize.height/8.12).isActive = true
        pickerTime.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        pickerTime.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        pickerTime.timeZone = .autoupdatingCurrent
        pickerTime.accessibilityNavigationStyle = .separate
        pickerTime.topAnchor.constraint(equalTo: containerView.topAnchor, constant: screenSize.height/15.53).isActive = true
        animateSheet()
    }
    
    @objc func pickerSelectedDate() {
        let date = picker.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM yyyy, E"
        let dateTitle = dateFormatter.string(from: date)
        buttonsDT.buttonDate.setTitle(dateTitle, for: .normal)
        buttonsDT.buttonDate.setTitleColor(UIColor(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        animateSheetBack()
    }
    
    @objc func buttonSelectPressed() {
        let date = pickerTime.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let dateTitle = dateFormatter.string(from: date)
        buttonsDT.buttonTime.setTitle(dateTitle, for: .normal)
        buttonsDT.buttonTime.setTitleColor(UIColor(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        buttonDateWidth?.constant = screenSize.width/1.38
        buttonTimeWidth?.constant = screenSize.width/5.6875
        view.layoutIfNeeded()
        buttons.labelShortYes.text! = "\(getDayPrevious()), \(dateTitle)"
        buttons.labelShort.text! = "\(getDay()), \(dateTitle)"
        buttons.labelShortLastWeek.text! = "\(getDay()), \(dateTitle)"
        animateSheetBack()
    }
    

    // MARK: SetUp Views
    func setupView() {
        view.backgroundColor = .clear
    }
    
    func setupConstraints() {
        view.addSubview(dimmedView)
        view.addSubview(containerView)
        dimmedView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        contentStackButtons.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(contentStackView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(buttonsDT.buttonDate)
        containerView.addSubview(buttonsDT.buttonTime)
        containerView.addSubview(contentStackButtons)
        containerView.addSubview(buttonSelect)
        
        NSLayoutConstraint.activate([
            dimmedView.topAnchor.constraint(equalTo: view.topAnchor),
            dimmedView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            dimmedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dimmedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 9),
            contentStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            contentStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 15),
            titleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            contentStackButtons.topAnchor.constraint(equalTo: containerView.topAnchor, constant: screenSize.height/6.94),
            contentStackButtons.widthAnchor.constraint(equalTo: view.widthAnchor),
            contentStackButtons.heightAnchor.constraint(equalToConstant: screenSize.height/3.65),
            
            buttonsDT.buttonDate.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: screenSize.width/30),
            buttonsDT.buttonDate.topAnchor.constraint(equalTo: containerView.topAnchor, constant: screenSize.height/13.3),
            buttonsDT.buttonDate.heightAnchor.constraint(equalToConstant: screenSize.height/20.3),
            
            buttonsDT.buttonTime.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -screenSize.width/30),
            buttonsDT.buttonTime.topAnchor.constraint(equalTo: containerView.topAnchor, constant: screenSize.height/13.3),
            buttonsDT.buttonTime.heightAnchor.constraint(equalToConstant: screenSize.height/20.3),
            
            buttonSelect.heightAnchor.constraint(equalToConstant: screenSize.height/18.45),
            buttonSelect.widthAnchor.constraint(equalToConstant: screenSize.width/1.07),
            buttonSelect.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
        ])

        containerViewHeightConstraint = containerView.heightAnchor.constraint(equalToConstant: defaultHeight)
        containerViewBottomConstraint = containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: defaultHeight)

        buttonConstraint = buttonSelect.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: screenSize.height/1.624)
        
        buttonDateWidth = buttonsDT.buttonDate.widthAnchor.constraint(equalToConstant: screenSize.width/2.23)
        buttonTimeWidth = buttonsDT.buttonTime.widthAnchor.constraint(equalToConstant: screenSize.width/2.23)
        
        buttonConstraint?.isActive = true
        buttonDateWidth?.isActive = true
        buttonTimeWidth?.isActive = true
        containerViewHeightConstraint?.isActive = true
        containerViewBottomConstraint?.isActive = true
    }
    

    // MARK: Present and dismiss animation
    func animatePresentContainer() {
        UIView.animate(withDuration: 0.3) {
            self.containerViewBottomConstraint?.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    
    func animateShowDimmedView() {
        dimmedView.alpha = 0
        UIView.animate(withDuration: 0.4) {
            self.dimmedView.alpha = self.maxDimmedAlpha
        }
    }
    
    func animateDateAndTime() {
        UIView.animate(withDuration: 0.4) {
            self.buttonDateWidth?.constant = self.screenSize.width/1.38
            self.buttonTimeWidth?.constant = self.screenSize.width/5.6875
            self.view.layoutIfNeeded()
        }
    }
    
    
    
    func animateSheet() {
        UIView.animate(withDuration: 0.4) {
            self.containerViewHeightConstraint?.constant = self.screenSize.height/2.03
            self.labelReady.isHidden = true
            self.labelDelete.isHidden = false
            if (self.buttonsDT.buttonDate.titleLabel!.text == Resources.Labels.setDate && self.buttonsDT.buttonTime.titleLabel!.text == Resources.Labels.setTime) {
                self.labelDelete.setTitleColor(UIColor(red: 0.902, green: 0.275, blue: 0.275, alpha: 0.4), for: .normal)
                self.labelDelete.isEnabled = false
            }
            else {
                self.labelDelete.setTitleColor(UIColor(red: 0.902, green: 0.275, blue: 0.275, alpha: 1), for: .normal)
                self.labelDelete.isEnabled = true
            }
            self.buttonConstraint?.constant = -46
            self.view.layoutIfNeeded()
        }
    }
    
    func animateSheetBack() {
        UIView.animate(withDuration: 0.4) {
            self.containerViewHeightConstraint?.constant = self.defaultHeight
            self.labelReady.isHidden = false
            self.labelDelete.isHidden = true
            self.picker.removeFromSuperview()
            self.pickerTime.removeFromSuperview()
            self.buttonConstraint?.constant = self.screenSize.height/1.624
            self.view.layoutIfNeeded()
        }
    }
    
    func animateDismissView() {
        dimmedView.alpha = maxDimmedAlpha
        UIView.animate(withDuration: 0.4) {
            self.dimmedView.alpha = 0
        } completion: { _ in
            self.dismiss(animated: false)
        }
        UIView.animate(withDuration: 0.4) {
            self.containerViewBottomConstraint?.constant = self.defaultHeight
            self.containerViewHeightConstraint?.constant = self.defaultHeight
            self.buttonConstraint?.constant = 46
            // call this to trigger refresh constraint
            self.view.layoutIfNeeded()
        }
    }
}
