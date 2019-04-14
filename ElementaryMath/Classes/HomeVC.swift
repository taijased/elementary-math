//
//  HomeVC.swift
//  ElementaryMath
//
//  Created by Maxim Spiridonov on 23/03/2019.
//  Copyright © 2019 Maxim Spiridonov. All rights reserved.
//

import Foundation
import UIKit

class HomeVC: UIViewController {
    var previousPassword = ""
    
    var gradientLayer: CAGradientLayer! {
        didSet {
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 0, y: 1)
            let startColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1).cgColor
            let endColor = #colorLiteral(red: 0.1401032209, green: 0.3969643712, blue: 0.5631814599, alpha: 1).cgColor
            gradientLayer.colors = [startColor, endColor]
        }
    }
    
    @IBOutlet weak var passwordTextField: UITextField! {
        didSet {
            passwordTextField.layer.borderWidth = 1
            passwordTextField.layer.cornerRadius = 8
            passwordTextField.isSecureTextEntry = true
        }
    }

    @IBOutlet weak var settingButton: UIButton! {
        didSet {
            settingButton.layer.borderWidth = 1
            settingButton.layer.cornerRadius = 8
            settingButton.addTarget(self, action: #selector(settingDidTap), for: .touchUpInside)
            
            settingButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            settingButton.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
            settingButton.layer.shadowOpacity = 2.0
            settingButton.layer.shadowRadius = 2.0
        }
    }
    
    @IBOutlet weak var playGameButton: UIButton! {
        didSet {
            playGameButton.layer.borderWidth = 1
            playGameButton.layer.cornerRadius = 8
            playGameButton.addTarget(self, action: #selector(playGame), for: .touchUpInside)
            
            playGameButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            playGameButton.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
            playGameButton.layer.shadowOpacity = 2.0
            playGameButton.layer.shadowRadius = 2.0
        }
    }
    @objc func playGame() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let parrentVC =  storyboard.instantiateViewController(withIdentifier: "PlayVC")
        self.navigationController?.pushViewController(parrentVC, animated: true)
    }
    
   @IBOutlet weak var okBtn: UIButton! {
        didSet {
            okBtn.layer.borderWidth = 1
            okBtn.layer.cornerRadius = 8
            okBtn.addTarget(self, action: #selector(checkPassword), for: .touchUpInside)
            
            okBtn.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            okBtn.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
            okBtn.layer.shadowOpacity = 2.0
            okBtn.layer.shadowRadius = 2.0
        }
    }
    @objc func checkPassword() {
        guard let userInput = passwordTextField.text, !userInput.isEmpty else {
            let alert = UIAlertController(title: "Пустое значение", message: "Вы должны ввести правильный пароль или сбросить настройки", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        if userInput == self.previousPassword {
            passwordTextField.text = nil
            goSettingsScreen()
        } else {

            let alert = UIAlertController(title: "Неверный пароль", message: "Вы должны ввести правильный пароль или сбросить настройки", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
        
        
    }
    
    @IBOutlet weak var resetBtn: UIButton! {
        didSet {
            resetBtn.layer.borderWidth = 1
            resetBtn.layer.cornerRadius = 8
            resetBtn.isEnabled = true
            resetBtn.addTarget(self, action: #selector(resetUserSettings), for: .touchUpInside)
        }
    }
    
    @objc func resetUserSettings() {
        let alert = UIAlertController(title: "Сбросить", message: "Вы уверены, что хотите сбросить все настройки?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Нет", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Да", style: .default, handler: { action in
            if let domain = Bundle.main.bundleIdentifier {
                UserDefaults.standard.removePersistentDomain(forName: domain)
                UserDefaults.standard.synchronize()
            }
            self.goSettingsScreen()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func settingDidTap() {
        if let previousPassword = UserDefaults.standard.string(forKey: DefaultUserSetting.password), !previousPassword.isEmpty {
            passwordTextField.isHidden = false
            okBtn.isHidden = false
            resetBtn.isHidden = false
            self.previousPassword = previousPassword
        } else {
            goSettingsScreen()
        }
    }
    
    func goSettingsScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let settingVC =  storyboard.instantiateViewController(withIdentifier: "SettingVC")
        self.navigationController?.pushViewController(settingVC, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        gradientLayer.frame = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navigationController?.navigationBar.isHidden = true

        passwordTextField.isHidden = true
        resetBtn.isHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(playGame), name: Notification.Name("StartGame"), object: nil)
        
        
    
        gradientLayer = CAGradientLayer()
        view.layer.insertSublayer(gradientLayer, at: 0)
    
    }
    
}
