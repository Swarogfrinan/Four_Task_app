//
//  Action Model.swift
//  Four Task
//
//  Created by Ilya Vasilev on 14.07.2022.
//

import Foundation
import UIKit


//MARK: - Extension + Methods
extension ViewController {
    ///СТАРТ ФУНКЦИЯ 1 задачи.
    func firstTaskStart() {
        if (timerStarted.firstTimerStarted) == false {
            print("StoptimeOne не равен Nil.")
            animateFirstViewStart()
        }
    }
    ///СТАРТ АНИМАЦИЯ 1 задачи.
    func animateFirstViewStart() {
        UIView.animate(withDuration: 0.3) { [self] in
            print("Выполнение анимации первого сценария, второй кейс (старт)")
            secondTaskButton.backgroundColor = .systemGray
            thirdTaskButton.backgroundColor = .systemGray2
            fourTaskButton.backgroundColor = .systemGray3
            secondTaskButton.isEnabled = false
            thirdTaskButton.isEnabled = false
            fourTaskButton.isEnabled = false
            clockLabel.textColor = .systemYellow
            timerStarted.firstTimerStarted = true
            timerCounting = true
        }
    }
    ///СТОП ФУНКЦИЯ 1 задачи.
    func firstTaskStop() {
        if (timerStarted.firstTimerStarted) == true {
            animateFirstViewStop()
        }
    }
    ///СТОП АНИМАЦИЯ 1 задачи.
    func animateFirstViewStop() {
        print("Сработала проверка по timerStarted")
        print("Старт акшен ван. Таймер-стартед переведен в TRUE")
        UIView.animate(withDuration: 0.3) { [self] in
            print("Пошло выполнение анимации первого сценария, первый кейс (стоп)")
            secondTaskButton.backgroundColor = .systemRed
            thirdTaskButton.backgroundColor = .systemBlue
            fourTaskButton.backgroundColor = .systemGreen
            secondTaskButton.isEnabled = true
            thirdTaskButton.isEnabled = true
            fourTaskButton.isEnabled = true
            clockLabel.textColor = .systemGray
            timerStarted.firstTimerStarted = false
            timerCounting = false
            print("Все кнопки включены. Текст перекрашен в серый.")
        }
    }
    /// СТОП второй задачи с проверкой.
    func secondTaskStop() {
        if (timerStarted.secondTimerStarted) == true {
            animateSecondViewStop()
        }
    }
    ///СТАРТ второй задачи с проверкой.
    func secondTaskStart() {
        if (timerStarted.secondTimerStarted) == false {
            animateSecondViewStart()
        }
    }
    ///Анимация стопа второй кнопки.
    func animateSecondViewStop() {
        UIView.animate(withDuration: 0.3) { [self] in
            firstTaskButton.backgroundColor = .systemYellow
            thirdTaskButton.backgroundColor = .systemBlue
            fourTaskButton.backgroundColor = .systemGreen
            firstTaskButton.isEnabled = true
            thirdTaskButton.isEnabled = true
            fourTaskButton.isEnabled = true
            clockLabel.textColor = .systemGray
            timerStarted.secondTimerStarted = false
            timerCounting = false
        }
    }
    ///Анимация старта второй кнопки.
    func animateSecondViewStart() {
        UIView.animate(withDuration: 0.3) { [self] in
            firstTaskButton.backgroundColor = .systemGray
            thirdTaskButton.backgroundColor = .systemGray2
            fourTaskButton.backgroundColor = .systemGray3
            firstTaskButton.isEnabled = false
            thirdTaskButton.isEnabled = false
            fourTaskButton.isEnabled = false
            clockLabel.textColor = .systemRed
            timerStarted.secondTimerStarted = true
            timerCounting = true
        }
    }
    
    ///Функция  третьей  задачи СТОП.
    func thirdTaskStop() {
        if (timerStarted.thirdTimerStarted) == true {
            animateThirdViewStop()
        }
    }
    ///СТОП анимация третьей кнопки.
    func animateThirdViewStop() {
        UIView.animate(withDuration: 0.3) { [self] in
            secondTaskButton.backgroundColor = .systemRed
            firstTaskButton.backgroundColor = .systemYellow
            fourTaskButton.backgroundColor = .systemGreen
            firstTaskButton.isEnabled = true
            secondTaskButton.isEnabled = true
            fourTaskButton.isEnabled = true
            clockLabel.textColor = .systemGray
            timerStarted.thirdTimerStarted = false
            timerCounting = false
        }
    }
    
    ///Функция третьей задачи СТАРТ.
    func thirdTaskStart() {
        if (timerStarted.thirdTimerStarted) == false {
            animateThirdViewStart()
        }
    }
    ///СТАРТ  анимация третьей кнопки.
    func animateThirdViewStart() {
        UIView.animate(withDuration: 0.3) { [self] in
            firstTaskButton.backgroundColor = .systemGray
            secondTaskButton.backgroundColor = .systemGray2
            fourTaskButton.backgroundColor = .systemGray3
            firstTaskButton.isEnabled = false
            secondTaskButton.isEnabled = false
            fourTaskButton.isEnabled = false
            clockLabel.textColor = .systemBlue
            timerStarted.thirdTimerStarted = true
            timerCounting = true
        }
    }
    ///СТОП Функция четвёртой задачи.
    func fourTaskStop() {
        if (timerStarted.fourTimerStarted) == true {
            animateFourViewStop()
        }
    }
    ///СТАРТ  анимация четвёртой кнопки.
    func animateFourViewStop() {
        UIView.animate(withDuration: 0.3) { [self] in
            firstTaskButton.backgroundColor = .systemYellow
            secondTaskButton.backgroundColor = .systemRed
            thirdTaskButton.backgroundColor = .systemBlue
            firstTaskButton.isEnabled = true
            secondTaskButton.isEnabled = true
            thirdTaskButton.isEnabled = true
            clockLabel.textColor = .systemGray
            timerStarted.fourTimerStarted = false
            timerCounting = false
        }
    }
    
    ///СТАРТ  функция четвёртой задачи.
    func fourTaskStart() {
        if (timerStarted.fourTimerStarted) == false {
            animateFourViewStart()
        }
    }
    ///СТАРТ  анимация четвёртой кнопки.
    func animateFourViewStart() {
        UIView.animate(withDuration: 0.3) { [self] in
            firstTaskButton.backgroundColor = .systemGray
            secondTaskButton.backgroundColor = .systemGray2
            thirdTaskButton.backgroundColor = .systemGray3
            firstTaskButton.isEnabled = false
            secondTaskButton.isEnabled = false
            thirdTaskButton.isEnabled = false
            clockLabel.textColor = .systemGreen
            timerStarted.fourTimerStarted = true
            timerCounting = true
        }
    }
    ///MARK : - END
}
