//
//  Action Model.swift
//  Four Task
//
//  Created by Ilya Vasilev on 14.07.2022.
//

import Foundation
import UIKit


//MARK: - Extension + Methods
extension FourTaskViewController {
   
    ///СТАРТ ФУНКЦИЯ 1 задачи.
    func firstTaskStart() {
        if !timerStarted.firstTimerStarted {
            print("StoptimeOne не равен Nil.")
            animateFirstViewStart()
        }
    }
    ///СТАРТ АНИМАЦИЯ 1 задачи.
    func animateFirstViewStart() {
        UIView.animate(withDuration: 0.3) { [self] in
            print("Выполнение анимации первого сценария, второй кейс (старт)")
            secondButton.backgroundColor = .systemGray
            thirdButton.backgroundColor = .systemGray2
            fourButton.backgroundColor = .systemGray3
            secondButton.isEnabled = false
            thirdButton.isEnabled = false
            fourButton.isEnabled = false
            clockLabel.textColor = .systemYellow
            timerCounting = true
        }
    }
    ///СТОП ФУНКЦИЯ 1 задачи.
    func firstTaskStop() {
        if timerStarted.firstTimerStarted{
            animateFirstViewStop()
        }
    }
    ///СТОП АНИМАЦИЯ 1 задачи.
    func animateFirstViewStop() {
        print("Сработала проверка по timerStarted")
        print("Старт акшен ван. Таймер-стартед переведен в TRUE")
        UIView.animate(withDuration: 0.3) { [self] in
            print("Пошло выполнение анимации первого сценария, первый кейс (стоп)")
            secondButton.backgroundColor = .systemRed
            thirdButton.backgroundColor = .systemBlue
            fourButton.backgroundColor = .systemGreen
            secondButton.isEnabled = true
            thirdButton.isEnabled = true
            fourButton.isEnabled = true
            clockLabel.textColor = .systemGray
            timerCounting = false
            print("Все кнопки включены. Текст перекрашен в серый.")
        }
    }
    /// СТОП второй задачи с проверкой.
    func secondTaskStop() {
        if timerStarted.secondTimerStarted {
            animateSecondViewStop()
        }
    }
    ///СТАРТ второй задачи с проверкой.
    func secondTaskStart() {
        if !timerStarted.secondTimerStarted {
            animateSecondViewStart()
        }
    }
    ///Анимация стопа второй кнопки.
    func animateSecondViewStop() {
        UIView.animate(withDuration: 0.3) { [self] in
            firstButton.backgroundColor = .systemYellow
            thirdButton.backgroundColor = .systemBlue
            fourButton.backgroundColor = .systemGreen
            firstButton.isEnabled = true
            thirdButton.isEnabled = true
            fourButton.isEnabled = true
            clockLabel.textColor = .systemGray
            timerCounting = false
        }
    }
    ///Анимация старта второй кнопки.
    func animateSecondViewStart() {
        UIView.animate(withDuration: 0.3) { [self] in
            firstButton.backgroundColor = .systemGray
            thirdButton.backgroundColor = .systemGray2
            fourButton.backgroundColor = .systemGray3
            firstButton.isEnabled = false
            thirdButton.isEnabled = false
            fourButton.isEnabled = false
            clockLabel.textColor = .systemRed
            timerCounting = true
        }
    }
    
    ///Функция  третьей  задачи СТОП.
    func thirdTaskStop() {
        if timerStarted.thirdTimerStarted {
            animateThirdViewStop()
        }
    }
    ///СТОП анимация третьей кнопки.
    func animateThirdViewStop() {
        UIView.animate(withDuration: 0.3) { [self] in
            secondButton.backgroundColor = .systemRed
            firstButton.backgroundColor = .systemYellow
            fourButton.backgroundColor = .systemGreen
            firstButton.isEnabled = true
            secondButton.isEnabled = true
            fourButton.isEnabled = true
            clockLabel.textColor = .systemGray
            timerCounting = false
        }
    }
    
    ///Функция третьей задачи СТАРТ.
    func thirdTaskStart() {
        if !timerStarted.thirdTimerStarted {
            animateThirdViewStart()
        }
    }
    ///СТАРТ  анимация третьей кнопки.
    func animateThirdViewStart() {
        UIView.animate(withDuration: 0.3) { [self] in
            firstButton.backgroundColor = .systemGray
            secondButton.backgroundColor = .systemGray2
            fourButton.backgroundColor = .systemGray3
            firstButton.isEnabled = false
            secondButton.isEnabled = false
            fourButton.isEnabled = false
            clockLabel.textColor = .systemBlue
            timerCounting = true
        }
    }
    ///СТОП Функция четвёртой задачи.
    func fourTaskStop() {
        if timerStarted.fourTimerStarted {
            animateFourViewStop()
        }
    }
    ///СТАРТ  анимация четвёртой кнопки.
    func animateFourViewStop() {
        UIView.animate(withDuration: 0.3) { [self] in
            firstButton.backgroundColor = .systemYellow
            secondButton.backgroundColor = .systemRed
            thirdButton.backgroundColor = .systemBlue
            firstButton.isEnabled = true
            secondButton.isEnabled = true
            thirdButton.isEnabled = true
            clockLabel.textColor = .systemGray
            timerCounting = false
        }
    }
    
    ///СТАРТ  функция четвёртой задачи.
    func fourTaskStart() {
        if !timerStarted.fourTimerStarted {
            animateFourViewStart()
        }
    }
    ///СТАРТ  анимация четвёртой кнопки.
    func animateFourViewStart() {
        UIView.animate(withDuration: 0.3) { [self] in
            firstButton.backgroundColor = .systemGray
            secondButton.backgroundColor = .systemGray2
            thirdButton.backgroundColor = .systemGray3
            firstButton.isEnabled = false
            secondButton.isEnabled = false
            thirdButton.isEnabled = false
            clockLabel.textColor = .systemGreen
            timerCounting = true
        }
    }
    ///MARK : - END
}
