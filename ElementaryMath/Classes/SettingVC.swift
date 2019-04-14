//
//  SettingVC.swift
//  ElementaryMath
//
//  Created by Maxim Spiridonov on 23/03/2019.
//  Copyright © 2019 Maxim Spiridonov. All rights reserved.
//

import UIKit

class SettingVC: UIViewController {
    
    var gradientLayer: CAGradientLayer! {
        didSet {
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 0, y: 1)
            let startColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1).cgColor
            let endColor = #colorLiteral(red: 0.1401032209, green: 0.3969643712, blue: 0.5631814599, alpha: 1).cgColor
            gradientLayer.colors = [startColor, endColor]
        }
    }
    
    var enabledOperations: [Bool] = [false, false, false, false]
    
    @IBOutlet weak var sliderLeft: SettingRangeSeekSlider!
    @IBOutlet weak var sliderRight: SettingRangeSeekSlider!
    @IBOutlet weak var firstMinLbl: UILabel!
    @IBOutlet weak var firstMaxLbl: UILabel!
    @IBOutlet weak var secondMinLbl: UILabel!
    @IBOutlet weak var secondMaxLbl: UILabel!

    @IBOutlet weak var exampleLbl: UILabel!


    var currentFirstArgMin = 0
    var currentFirstArgMax = 0

    var currentSecondArgMin = 0
    var currentSecondArgMax = 0

    @IBOutlet weak var plusBtn: UIButton! {
        didSet {
            plusBtn.layer.masksToBounds = true
            plusBtn.layer.cornerRadius = 8
            plusBtn.layer.borderWidth = 1
            plusBtn.layer.borderColor = UIColor.clear.cgColor
            plusBtn.addTarget(self, action: #selector(plusBtnTap), for: .touchUpInside)
        }
    }
    @objc func plusBtnTap() {
        if enabledOperations[0] {
            plusBtn.backgroundColor = .clear
            plusBtn.layer.borderColor = UIColor.clear.cgColor
        } else {
            plusBtn.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        }
        enabledOperations[0] = !enabledOperations[0]
    }

    @IBOutlet weak var minusBtn: UIButton! {
        didSet {
            minusBtn.layer.masksToBounds = true
            minusBtn.layer.cornerRadius = 8
            minusBtn.layer.borderWidth = 1
            minusBtn.layer.borderColor = UIColor.clear.cgColor
            minusBtn.addTarget(self, action: #selector(minusBtnTap), for: .touchUpInside)
        }
    }
    @objc func minusBtnTap() {
        if enabledOperations[1] {
            minusBtn.backgroundColor = .clear
            minusBtn.layer.borderColor = UIColor.clear.cgColor
        } else {
            minusBtn.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        }
        enabledOperations[1] = !enabledOperations[1]
    }
    @IBOutlet weak var multiplyBtn: UIButton! {
        didSet {
            multiplyBtn.layer.masksToBounds = true
            multiplyBtn.layer.cornerRadius = 8
            multiplyBtn.layer.borderWidth = 1
            multiplyBtn.layer.borderColor = UIColor.clear.cgColor
            multiplyBtn.addTarget(self, action: #selector(multiplyBtnTap), for: .touchUpInside)
        }
    }
    @objc func multiplyBtnTap() {
        if enabledOperations[2] {
            multiplyBtn.backgroundColor = .clear
            multiplyBtn.layer.borderColor = UIColor.clear.cgColor
        } else {
            multiplyBtn.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        }
        enabledOperations[2] = !enabledOperations[2]
    }
    @IBOutlet weak var divisionBtn: UIButton! {
        didSet {
            divisionBtn.layer.masksToBounds = true
            divisionBtn.layer.cornerRadius = 8
            divisionBtn.layer.borderWidth = 1
            divisionBtn.layer.borderColor = UIColor.clear.cgColor
            divisionBtn.addTarget(self, action: #selector(divisionBtnTap), for: .touchUpInside)
        }
    }
    @objc func divisionBtnTap() {
        if enabledOperations[3] {
            divisionBtn.backgroundColor = .clear
            divisionBtn.layer.borderColor = UIColor.clear.cgColor
        } else {
            
            
        }
        enabledOperations[3] = !enabledOperations[3]
    }

    @IBOutlet weak var rewardTextField: UITextField!
    @IBOutlet weak var rightAnswersTextField: UITextField!


    @IBOutlet weak var startAndSaveBtn: UIButton! {
        didSet {
            startAndSaveBtn.layer.cornerRadius = 21
            startAndSaveBtn.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            
            startAndSaveBtn.layer.borderWidth = 1
    
            startAndSaveBtn.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            startAndSaveBtn.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
            startAndSaveBtn.layer.shadowOpacity = 2.0
            startAndSaveBtn.layer.shadowRadius = 2.0
            startAndSaveBtn.addTarget(self, action: #selector(startAndSaveBtnTapped), for: .touchUpInside)
        }
    }
    @objc func startAndSaveBtnTapped() {
        var password = UserDefaults.standard.string(forKey: DefaultUserSetting.password)
        if let newPass = passwordGameTextField.text, !newPass.isEmpty {
            password = newPass
        }
        guard let currentPassword = password, !currentPassword.isEmpty else {
            let alert = UIAlertController(title: "Неверный пароль", message: "Вы должны ввести правильный пароль или сбросить настройки", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))

            self.present(alert, animated: true, completion: nil)
            return
        }
        UserDefaults.standard.set(currentPassword, forKey: DefaultUserSetting.password)
        UserDefaults.standard.set(currentFirstArgMin, forKey: DefaultUserSetting.minLeft)
        UserDefaults.standard.set(currentFirstArgMax, forKey: DefaultUserSetting.maxLeft)
        UserDefaults.standard.set(currentSecondArgMin, forKey: DefaultUserSetting.minRight)
        UserDefaults.standard.set(currentSecondArgMax, forKey: DefaultUserSetting.maxRight)
        UserDefaults.standard.set(enabledOperations, forKey: DefaultUserSetting.enabledOperations)
        if let reward = rewardTextField.text, !reward.isEmpty {
            UserDefaults.standard.set(reward, forKey: DefaultUserSetting.reward)
        } else {
            UserDefaults.standard.set("No reward :(", forKey: DefaultUserSetting.reward)
        }
        if let rightAnswersToWin = rightAnswersTextField.text, !rightAnswersToWin.isEmpty {
            UserDefaults.standard.set(Int(rightAnswersToWin), forKey: DefaultUserSetting.rightAnswersToWin)
        } else {
            UserDefaults.standard.set(5, forKey: DefaultUserSetting.rightAnswersToWin)
        }
        UserDefaults.standard.synchronize()
        NotificationCenter.default.post(name: Notification.Name("StartGame"), object: nil)
        //self.navigationController?.popToRootViewController(animated: true)
    }


   @IBOutlet weak var passwordGameTextField: UITextField! {
        didSet {
            passwordGameTextField.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            passwordGameTextField.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
            passwordGameTextField.layer.shadowOpacity = 2.0
            passwordGameTextField.layer.shadowRadius = 2.0
        }
    }

    @IBOutlet weak var viewBack: UIView! {
        didSet {
            viewBack.layer.cornerRadius = 8
            viewBack.backgroundColor = UIColor(white: 1, alpha: 0.8)

            viewBack.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            viewBack.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
            viewBack.layer.shadowOpacity = 2.0
            viewBack.layer.shadowRadius = 2.0
        }
    }
    override func viewDidLayoutSubviews() {
        gradientLayer.frame = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
//        setupSliderRange()
        
        gradientLayer = CAGradientLayer()
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func setupUI() {
        currentFirstArgMin = 10
        currentFirstArgMax = 90
        
        currentSecondArgMin = 10
        currentSecondArgMax = 90
        plusBtnTap()
    }
//
    func setupSliderRange() {
//        NSLog("Stack trace : %@",[Thread, callStackSymbols]);
        print(sliderLeft)
        print(sliderLeft.minValue)
        
        sliderLeft.minValue = CGFloat(0)
        sliderLeft.maxValue = CGFloat(100)
        sliderLeft.tintColor = .black
        sliderLeft.handleBorderWidth = 1
        sliderLeft.handleBorderColor = UIColor.white
        sliderLeft.hideLabels = true
        sliderLeft.delegate = self

        sliderLeft.handleColor = UIColor(red: 0/255, green: 181/255, blue: 138/255, alpha: 1.0)
        sliderLeft.colorBetweenHandles = .black

        sliderLeft.backgroundColor = .clear
        sliderLeft.selectedMinValue = CGFloat(currentFirstArgMin)
        sliderLeft.selectedMaxValue = CGFloat(currentFirstArgMax)

        sliderLeft.tag = 111

        firstMinLbl.text = "min: \(currentFirstArgMin)"
        firstMaxLbl.text = "max: \(currentFirstArgMax)"

        sliderRight.minValue = CGFloat(0)
        sliderRight.maxValue = CGFloat(100)
        sliderRight.tintColor = .black
        sliderRight.handleBorderWidth = 1
        sliderRight.handleBorderColor = UIColor.white
        sliderRight.hideLabels = true
        sliderRight.delegate = self

        sliderRight.handleColor = UIColor(red: 0/255, green: 181/255, blue: 138/255, alpha: 1.0)
        sliderRight.colorBetweenHandles = .black

        sliderRight.backgroundColor = .clear
        sliderRight.selectedMinValue = CGFloat(currentSecondArgMin)
        sliderRight.selectedMaxValue = CGFloat(currentSecondArgMax)
//
        secondMinLbl.text = "min: \(currentSecondArgMin)"
        secondMaxLbl.text = "max: \(currentSecondArgMax)"

        sliderRight.minDistance = 1
        sliderLeft.minDistance = 1
        
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}


extension SettingVC : SettingRangeSeekSliderDelegate {


    func rangeSeekSlider(_ slider: SettingRangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {

        if  slider.tag == 111 {
            firstMinLbl.text = "min: \(Int(minValue))"
            firstMaxLbl.text = "max: \(Int(maxValue))"

            currentFirstArgMin = Int(minValue)
            currentFirstArgMax = Int(maxValue)

        } else {
            secondMinLbl.text = "min: \(Int(minValue))"
            secondMaxLbl.text = "max: \(Int(maxValue))"

            currentSecondArgMin = Int(minValue)
            currentSecondArgMax = Int(maxValue)
        }
    }

    func didEndTouches(in slider: SettingRangeSeekSlider) {
        let leftInt =  Int.random(in: currentFirstArgMin..<currentFirstArgMax)
        let rightInt = Int.random(in: currentSecondArgMin..<currentSecondArgMax)

        exampleLbl.text = "\(leftInt) + \(rightInt) = \(leftInt + rightInt)"
    }


}
