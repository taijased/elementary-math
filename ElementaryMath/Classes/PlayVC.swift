//
//  PlayVC.swift
//  ElementaryMath
//
//  Created by Maxim Spiridonov on 23/03/2019.
//  Copyright © 2019 Maxim Spiridonov. All rights reserved.
//

import UIKit

class PlayVC: UIViewController {
    var gradientLayer: CAGradientLayer! {
        didSet {
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 0, y: 1)
            let startColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1).cgColor
            let endColor = #colorLiteral(red: 0.1401032209, green: 0.3969643712, blue: 0.5631814599, alpha: 1).cgColor
            gradientLayer.colors = [startColor, endColor]
        }
    }
    @IBOutlet weak var resultLbl: UILabel! {
        didSet {
            resultLbl.layer.masksToBounds = true
            resultLbl.layer.cornerRadius = 8
            resultLbl.backgroundColor = UIColor(white: 1, alpha: 0.8)
            
            resultLbl.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            resultLbl.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
            resultLbl.layer.shadowOpacity = 2.0
            resultLbl.layer.shadowRadius = 2.0
        }
    }
   @IBOutlet weak var leftOperandLbl: UILabel!
   @IBOutlet weak var operatorLbl: UILabel!
   @IBOutlet weak var rightOperandLbl: UILabel!
   @IBOutlet weak var equalsLbl: UILabel!
    
   @IBOutlet weak var resultTextField: UITextField!
   @IBOutlet weak var progressBar: UIProgressView!
   @IBOutlet weak var progressTextLabel: UILabel!
   @IBOutlet weak var safeMainIcon: UIImageView!
   @IBOutlet weak var rewardTextLabel: UILabel!
    
    @IBOutlet
    weak var backBtn: UIButton! {
        didSet {
            backBtn.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        }
    }
    @objc
    func backButtonTapped() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    var minLeft = 10
    var maxLeft = 90
    var minRight = 10
    var maxRight = 90
    var rightAnswer = 0
    var rightAnswersCount = 0
    var targetRightAnswersCount = 20
    var operations: [Int] = []
    var rewardText = "Вы прошли !!!"
    
    @IBOutlet weak var checkBtn: UIButton! {
        didSet {
            checkBtn.addTarget(self, action: #selector(checkButtonDidTap), for: .touchUpInside)
            checkBtn.layer.borderWidth = 1
            checkBtn.layer.cornerRadius = 8
            checkBtn.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            checkBtn.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
            checkBtn.layer.shadowOpacity = 2.0
            checkBtn.layer.shadowRadius = 2.0
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
        loadDefaults()
        resultLbl.isHidden = true
        progressBar.progressViewStyle = .default
        progressBar.progress = 0.0
        newTask()
        
        
        gradientLayer = CAGradientLayer()
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    
    func loadDefaults() {
        guard let pass = UserDefaults.standard.string(forKey: DefaultUserSetting.password), !pass.isEmpty else {
            targetRightAnswersCount = 5
            maxLeft = 90
            maxRight = 90
            operations = [0, 1, 2, 3]
            return
        }
        targetRightAnswersCount = UserDefaults.standard.integer(forKey: DefaultUserSetting.rightAnswersToWin)
        minLeft = UserDefaults.standard.integer(forKey: DefaultUserSetting.minLeft)
        maxLeft = UserDefaults.standard.integer(forKey: DefaultUserSetting.maxLeft)
        minRight = UserDefaults.standard.integer(forKey: DefaultUserSetting.minRight)
        maxRight = UserDefaults.standard.integer(forKey: DefaultUserSetting.maxRight)
        rewardText = UserDefaults.standard.string(forKey: DefaultUserSetting.reward) ?? "Empty reward :("
        if let enabledOperations: [Bool] = UserDefaults.standard.value(forKey: DefaultUserSetting.enabledOperations) as? [Bool] {
            for i in 0..<enabledOperations.count {
                if enabledOperations[i] {
                    operations.append(i)
                }
            }
        }
    }
    
    func newTask() {
        var leftOperand = Int.random(in: minLeft..<maxLeft+1)
        var rightOperand = Int.random(in: minRight..<maxRight+1)
        var valueSign = 0
        if operations.count > 0 {
            let randomS = Int.random(in: 0..<operations.count)
            valueSign = operations[randomS]
        }
        switch valueSign {
        case 0:
            rightAnswer = leftOperand + rightOperand
            operatorLbl.text = "+"
        case 1:
            if !(leftOperand >= rightOperand) {
                let temp = leftOperand
                leftOperand = rightOperand
                rightOperand = temp
            }
            rightAnswer = leftOperand - rightOperand
            operatorLbl.text = "-"
        case 2:
            rightAnswer = leftOperand * rightOperand
            operatorLbl.text = "*"
        case 3:
            if leftOperand == 0 {
                leftOperand = 1
            }
            if rightOperand == 0 {
                rightOperand = 1
            }
            let rValue = leftOperand * rightOperand
            rightAnswer = leftOperand
            leftOperand = rValue
            operatorLbl.text = "÷"
        default:
            break
        }
        leftOperandLbl.text = "\(leftOperand)"
        rightOperandLbl.text = "\(rightOperand)"
    }
    
    @objc func checkButtonDidTap() {
        guard let userStringAnswer = resultTextField.text, !userStringAnswer.isEmpty, let answer = Int(userStringAnswer) else {
            let alert = UIAlertController(title: "Пусто", message: "Напишите корректный ответ", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        resultLbl.isHidden = false
        if answer == rightAnswer {
            rightAnswersCount += 1
            resultLbl.text = "Правильно 😊!"
            resultLbl.textColor = UIColor(red: 96/255, green: 187/255, blue: 167/255, alpha: 1)
        } else {
            rightAnswersCount = rightAnswersCount >= 0 ? rightAnswersCount - 1 : 0
            resultLbl.text = "Не правильно 😒!"
            resultLbl.textColor = UIColor.red
        }
        
        resultTextField.text = ""
        progressBar.progress = Float(rightAnswersCount) / Float(targetRightAnswersCount)
        if rightAnswersCount >= targetRightAnswersCount {
            checkBtn.isEnabled = false
            rewardTextLabel.text = rewardText
            safeMainIcon.image = #imageLiteral(resourceName: "gift")
            self.view.endEditing(true)
        } else {
            newTask()
        }
    }

}
