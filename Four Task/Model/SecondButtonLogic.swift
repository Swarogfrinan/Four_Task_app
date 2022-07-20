//
//  SecondButtonLogic.swift
//  Four Task
//
//  Created by Ilya Vasilev on 19.07.2022.
//

import Foundation
var stopTimeSecond: Date?
var startTimeSecond: Date?
var scheduledTimerSecond: Timer!
var timerCounting: Bool = false
//MARK: - START
extension ViewController {
  func secondTask(){
        print("Нажатие второй кнопки")
        if timerCounting == true {
            print("TimerCounting = true во второй кнопке")
            setStopTimeSecond(date: Date())
            secondTaskStop()
            stopTimerSecond()
            print("Второй таймер остановлен. UI отработал. ")
        } else {
            if let stop = stopTimeSecond {
                let restartTime = calcRestartTimeSecond(start: startTimeSecond!, stop: stop)
                setStopTimeSecond(date: nil)
                setStartTimeSecond(date: restartTime)
            } else {
                setStartTimeSecond(date: Date())
            }
            
            secondTaskStart()
            startTimerSecond()
        }
    }
///Запуск Stop Action Timer с проверкой есть ли пауза.
    fileprivate  func startTimerSecond() {
scheduledTimerSecond = Timer.scheduledTimer(timeInterval: 0.1 , target: self, selector: #selector(refreshValueSecond), userInfo: nil, repeats: true)
setTimerCountingSecond(true)
}
//MARK: - STOP
    func stopActionSecond() {
    if stopTimeSecond != nil {
        
let restartTime = calcRestartTimeSecond(start: startTimeSecond!, stop: stopTimeSecond!)
setStopTimeSecond(date: nil)
setStartTimeSecond(date: restartTime)
    } else {
        setStartTimeSecond(date: Date())
        }
        startTimerSecond()
}

    fileprivate func stopTimerSecond() {
    if scheduledTimerSecond != nil {
        scheduledTimerSecond.invalidate()
        setTimerCountingSecond(false)
    }
}

    fileprivate func calcRestartTimeSecond(start: Date, stop: Date) -> Date {
    let diff = start.timeIntervalSince(stop)
    return Date().addingTimeInterval(diff)
}
//MARK: - SET STOP_START_COUNTING_KEYS
    fileprivate func setStopTimeSecond(date: Date?) {
    stopTimeSecond = date
    userDefaults.set(stopTimeSecond, forKey: STOP_KEYS[1])
    print("Установлено значение setStopTimeSecond по Stop_keys1 в ButtonsModel.")
}
    fileprivate func setStartTimeSecond(date: Date?) {
    startTimeSecond = date
    userDefaults.set(startTimeSecond, forKey: STARTING_KEYS[1])
    print("Установлено значение setStartTimeSecond по ключуStart_keys01 в ButtonsModel.")
}
    fileprivate func setTimerCountingSecond(_ value: Bool) {
    timerStarted.firstTimerStarted = value
    userDefaults.set(timerStarted.secondTimerStarted, forKey: COUNTING_KEYS[1])
    print("Установлено значение setTimerCountingSecond по Counting_keys1 в ButtonsModel.")
}
    fileprivate func setTimeLabelSecond(_ value: Int) {
    let time = secToHourMinutesSecondsSecond(seconds: value)
    let timeString = makeTimeStringSecond(hours: time.0, minutes: time.1, seconds: time.2)
    clockLabel.text = timeString
///    print("Установлен LABEl СLOCK с переводом цифрового значения в строку в ButtonsModel.")
}
    ///Перевод секунд в час, минуту, секунду.
    fileprivate func secToHourMinutesSecondsSecond(seconds: Int) -> (Int, Int, Int) {
        let hour =  (seconds / 3600)
        let mm = (seconds % 3600) / 60
        let sec = (seconds % 3600) % 60
        return (hour, mm, sec)
       
    }
    /// Перевод численных значений часы/минуты/секунды в формат String
  fileprivate  func makeTimeStringSecond(hours: Int, minutes: Int, seconds: Int) -> String {
        var timeString = ""
        timeString += String(format: "%02d", hours)
        timeString += ":"
        timeString += String(format: "%02d", minutes)
        timeString += ":"
        timeString += String(format: "%02d", seconds)
        return timeString
    }
//MARK: - RefreshValue
///Обновление данных, если что-то не так. Установка лейблу нуля.
@objc private func refreshValueSecond() {
    if let start = startTimeSecond {
        let diff = Date().timeIntervalSince(start)
        setTimeLabelSecond(Int(diff))
    } else {
        stopTimerSecond()
        setTimeLabelSecond(0)
    }
}
}
