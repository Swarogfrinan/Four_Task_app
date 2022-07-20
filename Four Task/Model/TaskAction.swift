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
        ///Функция первой задачи.
        func firstTaskStop() {
            print("Функция была нажата")
            if timerStarted.firstTimerStarted == true {
            print("Сработала проверка по timerStarted")
            startActionOne()
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
        }
            func firstTaskStart() {
            print("StoptimeOne не равен Nil.")
            if timerStarted.firstTimerStarted == false {
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
        }
        ///Функция второй задачи.
        func secondTaskStop() {
            if (timerStarted.secondTimerStarted) == true {
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
            }
        func secondTaskStart() {
            if timerStarted.secondTimerStarted == false {
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
        }

        ///Функция  третьей  задачи.
        func thirdTaskStop() {
            if (timerStarted.thirdTimerStarted) == true {
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
        }
        func thirdTaskStart() {
        if timerStarted.thirdTimerStarted == false {
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
        }
        
        ///Функция четвёртой задачи.
        func fourTaskStop() {
            if (timerStarted.fourTimerStarted) == true {
            timerStarted.fourTimerStarted = false
            timerCounting = false
            UIView.animate(withDuration: 0.3) { [self] in
            firstTaskButton.backgroundColor = .systemYellow
            secondTaskButton.backgroundColor = .systemRed
            thirdTaskButton.backgroundColor = .systemBlue
            firstTaskButton.isEnabled = true
            secondTaskButton.isEnabled = true
            thirdTaskButton.isEnabled = true
            clockLabel.textColor = .systemGray
            }
            }
        }
        func fourTaskStart() {
            if timerStarted.fourTimerStarted == false {
                timerStarted.fourTimerStarted = true
                timerCounting = true
        UIView.animate(withDuration: 0.3) { [self] in
        firstTaskButton.backgroundColor = .systemGray
        secondTaskButton.backgroundColor = .systemGray2
        thirdTaskButton.backgroundColor = .systemGray3
        firstTaskButton.isEnabled = false
        secondTaskButton.isEnabled = false
        thirdTaskButton.isEnabled = false
        clockLabel.textColor = .systemGreen
         }
        }
        }
        
        
    ///MARK : - END
    }
