//
//  FourButtonLogic.swift
//  Four Task
//
//  Created by Ilya Vasilev on 20.07.2022.
//


import Foundation
//MARK: - Let/Var
var stopTimeFour: Date?
var startTimeFour: Date?
var scheduledTimerFour: Timer!
//MARK: - Extension
extension ViewController {
    ///Подтягивание 4 таймера из бэкграунда если он был нажат последним.
    func fourRefreshBackgroundTimer() {
        if timerStarted.fourTimerStarted {
            startTimerFour()
        } else {
            stopTimerFour()
            if let start = startTimeFour {
                if let stop = stopTimeFour {
                    let time = calcRestartTimeFour(start: start, stop: stop)
                    let diff = Date().timeIntervalSince(time)
                    setTimeLabelFour(Int(diff))
                }
            }
        }
    }
    //MARK: - START
    func fourTask(){
        print("Нажатие 4 кнопки")
        if timerCounting == true {
            print("TimerCounting = true в 4 кнопке")
            setStopTimeFour(date: Date())
            fourTaskStop()
            stopTimerFour()
            print("4 таймер остановлен. UI отработал. ")
        } else {
            if let stop = stopTimeFour {
                let restartTime = calcRestartTimeFour(start: startTimeFour!, stop: stop)
                setStopTimeFour(date: nil)
                setStartTimeFour(date: restartTime)
            } else {
                setStartTimeFour(date: Date())
            }
            fourTaskStart()
            startTimerFour()
        }
    }
    ///Запуск Stop Action Timer с проверкой есть ли пауза.
    fileprivate  func startTimerFour() {
        scheduledTimerFour = Timer.scheduledTimer(timeInterval: 0.1 , target: self, selector: #selector(refreshValueFour), userInfo: nil, repeats: true)
        setTimerCountingFour(true)
        fourTaskStart()
    }
    //MARK: - STOP
    func stopActionFour() {
        
        if stopTimeFour != nil {
            let restartTime = calcRestartTimeFour(start: startTimeFour!, stop: stopTimeFour!)
            setStopTimeFour(date: nil)
            setStartTimeFour(date: restartTime)
        } else {
            setStartTimeFour(date: Date())
        }
        startTimerFour()
    }
    
    fileprivate func stopTimerFour() {
        if scheduledTimerFour != nil {
            scheduledTimerFour.invalidate()
            setTimerCountingFour(false)
        }
    }
    
    fileprivate func calcRestartTimeFour(start: Date, stop: Date) -> Date {
        let diff = start.timeIntervalSince(stop)
        return Date().addingTimeInterval(diff)
    }
    //MARK: - SET STOP_START_COUNTING_KEYS
    fileprivate func setStopTimeFour(date: Date?) {
        stopTimeFour = date
        userDefaults.set(stopTimeFour, forKey: fourKeys.Stop.rawValue)
        print("Установлено значение setStopTimeSecond по Stop_keys1 в ButtonsModel.")
    }
    fileprivate func setStartTimeFour(date: Date?) {
        startTimeFour = date
        userDefaults.set(startTimeFour, forKey: fourKeys.Start.rawValue)
        print("Установлено значение setStartTimeSecond по ключуStart_keys01 в ButtonsModel.")
    }
    fileprivate func setTimerCountingFour(_ value: Bool) {
        timerStarted.fourTimerStarted = value
        userDefaults.set(timerStarted.fourTimerStarted, forKey: fourKeys.Counting.rawValue)
        print("Установлено значение setTimerCountingSecond по Counting_keys1 в ButtonsModel.")
    }
    fileprivate func setTimeLabelFour(_ value: Int) {
        let time = secToHourMinutesSecondsFour(seconds: value)
        let timeString = makeTimeStringFour(hours: time.0, minutes: time.1, seconds: time.2)
        clockLabel.text = timeString
        taskNumbersFourLabel.text = timeString
        taskNumbersFourLabel.textColor = .systemGreen
        ///    print("Установлен LABEl СLOCK с переводом цифрового значения в строку в ButtonsModel.")
    }
    ///Перевод секунд в час, минуту, секунду.
    fileprivate func secToHourMinutesSecondsFour(seconds: Int) -> (Int, Int, Int) {
        let hour =  (seconds / 3600)
        let mm = (seconds % 3600) / 60
        let sec = (seconds % 3600) % 60
        return (hour, mm, sec)
        
    }
    /// Перевод численных значений часы/минуты/секунды в формат String
    fileprivate  func makeTimeStringFour(hours: Int, minutes: Int, seconds: Int) -> String {
        var timeString = ""
        timeString += String(format: "%02d", hours)
        timeString += ":"
        timeString += String(format: "%02d", minutes)
        timeString += ":"
        timeString += String(format: "%02d", seconds)
        return timeString
    }
    //MARK: - ResetAction
    func resetActionFour() {
        setStopTimeFour(date: nil)
        setStartTimeFour(date: nil)
        clockLabel.text = makeTimeStringFour(hours: 0, minutes: 0, seconds: 0)
        taskNumbersFourLabel.text = makeTimeStringFour(hours: 0, minutes: 0, seconds: 0)
        
        stopTimerFour()
        //        animateFourViewStart()
    }
    //MARK: - RefreshValue
    ///Обновление данных, если что-то не так. Установка лейблу нуля.
    @objc private func refreshValueFour() {
        if let start = startTimeFour {
            let diff = Date().timeIntervalSince(start)
            setTimeLabelFour(Int(diff))
        } else {
            stopTimerFour()
            setTimeLabelFour(0)
        }
    }
}
