//
//  ViewController.swift
//  EthApp
//
//  Created by Данила on 29.07.2022.
//

import UIKit

class ViewController: UIViewController {
    
    
    // MARK: variables
    let eth = Request()
    let vc = Sheet()
    let labelDate = DateAndTime()
    
    let screenSize = UIScreen.main.bounds
    
    let gradient = CAGradientLayer()
    let layer0 = CAGradientLayer()
    var timer = Timer()
    var labelWidth: NSLayoutConstraint?
    var viewWidth: NSLayoutConstraint?
    
    var flagToRequest: Bool = true
    var labelEthM: String = ""
    var b: String = "Load..."
    var ethereum: String = String()
    
    let imageDone = UIImage(systemName: "checkmark.circle.fill")
    lazy var iconDone = UIImageView(image: imageDone!)
    
    
    // MARK: override func
    override func viewDidLoad() {
        view.backgroundColor = .white
        super.viewDidLoad()
        if buttonNow.titleLabel!.text! != "Сейчас" {
            flagToRequest = false
        }
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateEth), userInfo: nil, repeats: true)
        addSubViews()
        vc.labelReady.addTarget(nil, action: #selector(buttonReadyPressed), for: .touchUpInside)
        vc.labelReady.addTarget(nil, action: #selector(viewD), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addSubViews()
        updateButton()
    }
    
    
    // MARK: lazy var
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = Resources.Labels.testTask
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var labelLive: UILabel = {
        let label = UILabel()
        label.text = Resources.Labels.live
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .white
        label.frame = CGRect(x: 0, y: 0, width: 43, height: 20)
        label.textAlignment = .center
        return label
    }()
    
    lazy var viewLive: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 43, height: 20)
        view.backgroundColor = .white
        layer0.colors = [
          UIColor(red: 0.988, green: 0.118, blue: 0.482, alpha: 1).cgColor,
          UIColor(red: 0.98, green: 0.2, blue: 0.286, alpha: 1).cgColor
        ]
        layer0.locations = [0, 1]
        layer0.startPoint = CGPoint(x: 0.25, y: 0.5)
        layer0.endPoint = CGPoint(x: 0.75, y: 0.5)
        layer0.bounds = CGRect(x: 0, y: 0, width: 43, height: 20)
        layer0.position = view.center
        layer0.cornerRadius = 4
        view.layer.addSublayer(layer0)
        view.addSubview(labelLive)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var labelCopy: UILabel = {
        let label = UILabel()
        label.text = Resources.Labels.copy
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = .black
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var copyView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 360, height: 56)
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        view.layer.shadowRadius = 7.0
        view.layer.shadowOpacity = 0.25
        view.layer.masksToBounds = false
        view.translatesAutoresizingMaskIntoConstraints = false
        iconDone.tintColor = .systemGreen
        view.addSubview(labelCopy)
        view.addSubview(iconDone)
        iconDone.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            iconDone.widthAnchor.constraint(equalToConstant: 24),
            iconDone.heightAnchor.constraint(equalToConstant: 24),
            iconDone.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12),
            iconDone.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            labelCopy.leftAnchor.constraint(equalTo: iconDone.rightAnchor, constant: 12),
            labelCopy.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        view.alpha = 0
        return view
    }()
    
    lazy var buttonNow: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.layer.backgroundColor = UIColor(red: 0.949, green: 0.953, blue: 0.961, alpha: 1).cgColor
        button.setTitle(labelDate.getDTString(), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        button.addTarget(nil, action: #selector(buttonNowPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var buttonDate: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        setUpGradient()
        button.layer.addSublayer(gradient)
        button.setTitle(Resources.Labels.date, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
//        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .regular)
        button.addTarget(nil, action: #selector(buttonDatePressed(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var labelEth: UILabel = {
        let label = UILabel()
        label.text = "1     = Load.."
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.textAlignment = .center
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var ethImg: UIImageView = {
        let img = UIImage(named: "ethereum")
        let image = UIImageView(image: img!)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    
    // MARK: setUpViews
    private func setUpView() {
        NSLayoutConstraint.activate([
            viewLive.widthAnchor.constraint(equalToConstant: 43),
            viewLive.heightAnchor.constraint(equalToConstant: 20),
            viewLive.bottomAnchor.constraint(equalTo: labelEth.topAnchor, constant: 10),
            viewLive.leftAnchor.constraint(equalTo: labelEth.rightAnchor, constant: 10),
        ])
    }
    
    private func setUpCopyView() {
        NSLayoutConstraint.activate([
            copyView.widthAnchor.constraint(equalToConstant: 360),
            copyView.heightAnchor.constraint(equalToConstant: 56),
            copyView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -45),
            copyView.centerXAnchor.constraint(equalTo: view.centerXAnchor),])
    }
    
    private func setUpLabelTask() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: screenSize.height/14),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    private func setUpLabelEth() {
        NSLayoutConstraint.activate([
            labelEth.topAnchor.constraint(equalTo: buttonDate.bottomAnchor, constant: screenSize.height/17.6),
            labelEth.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    private func setUpButtonDate() {
        NSLayoutConstraint.activate ([
            buttonDate.topAnchor.constraint(equalTo: buttonNow.bottomAnchor, constant: screenSize.height/40.6),
            buttonDate.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonDate.widthAnchor.constraint(equalToConstant: screenSize.width - 2*screenSize.width/23.4),
            buttonDate.heightAnchor.constraint(equalToConstant: screenSize.height/18.45),
        ])
    }
    
    private func setUpButtonNow() {
        NSLayoutConstraint.activate ([
            buttonNow.topAnchor.constraint(equalTo: label.bottomAnchor, constant: screenSize.height/29.5),
            buttonNow.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonNow.widthAnchor.constraint(equalToConstant: screenSize.width - 2*screenSize.width/23.4),
            buttonNow.heightAnchor.constraint(equalToConstant: screenSize.height/18.45),
        ])
    }
    
    private func setUpGradient() {
        gradient.frame = CGRect(x: 0, y: 0, width: screenSize.width - 2*screenSize.width/23.4, height: screenSize.height/18.45)
        gradient.type = .axial
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
        gradient.cornerRadius = 10
        gradient.colors = [UIColor.blue.cgColor, UIColor.purple.cgColor, UIColor.orange.cgColor]
    }
    
    private func setUpImg() {
        
        NSLayoutConstraint.activate ([
            ethImg.widthAnchor.constraint(equalToConstant: 18),
            ethImg.heightAnchor.constraint(equalToConstant: 26),
            ethImg.centerYAnchor.constraint(equalTo: labelEth.centerYAnchor),
            ethImg.leftAnchor.constraint(equalTo: labelEth.leftAnchor, constant: 15),
        ])
    }

    
    func updateButton() {
        buttonNow.setTitle(labelDate.getDTString(), for: .normal)
    }
    
    
    //MARK: animate func
    func animateViewCopy() {
        UIView.animate(withDuration: 0.7, animations: {
            self.copyView.alpha = 1
         }, completion: { (value: Bool) in
             UIView.animate(withDuration: 0.7, delay: 2, animations: {
                 self.copyView.alpha = 0
             })
         })
    }
    
    
    // MARK: @objc func
    @objc func buttonDatePressed(_ sender: UIButton) {
//        flagToRequest = false
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }
    
    @objc func updateEth() {
        if flagToRequest {
            labelLive.isHidden = false
            viewLive.isHidden = false
            self.b = self.eth.getEth()
            labelEth.text = "1     = \(b) $"
        }
        else {
            labelLive.isHidden = true
            viewLive.isHidden = true
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "d MMM yyyy, E HH:mm"
            let str = buttonNow.titleLabel!.text!
            let dateSelect = dateFormatter.date(from:str)!
            var date1970 = dateSelect.timeIntervalSince1970
            let dateNow = Date().timeIntervalSince1970
            if Int(dateNow) - Int(date1970) > 604800 {
                date1970 = dateNow - 604800
                buttonNow.setTitle(dateFormatter.string(from: Date(timeIntervalSince1970: date1970)), for: .normal)
            }
            self.b = self.eth.getEthDate(time: date1970 + 60)
            labelEth.text = "1     = \(b) $"
        }
    }
    
    @objc func viewD() {
        self.viewWillAppear(true)
    }
    
    @objc func buttonNowPressed() {
        UIPasteboard.general.string = buttonNow.titleLabel!.text
        animateViewCopy()
        
    }
    
    @objc func buttonReadyPressed() {
        let date: String = vc.datePlusTime()
        labelDate.setDTString(dateTime: date)
        if labelDate.getDTString() == "Сейчас" {
            flagToRequest = true
        }
        else {
            flagToRequest = false
        }
    }
    
    
    // MARK: addSubViews
    private func addSubViews() {
        view.addSubview(label)
        view.addSubview(buttonNow)
        view.addSubview(buttonDate)
        view.addSubview(labelEth)
        view.addSubview(viewLive)
        view.addSubview(ethImg)
        view.addSubview(copyView)
        setUpLabelTask()
        setUpLabelEth()
        setUpButtonNow()
        setUpButtonDate()
        setUpCopyView()
        setUpView()
        setUpImg()
    }

}

