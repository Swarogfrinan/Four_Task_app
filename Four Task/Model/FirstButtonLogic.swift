//
//  ButtonsModel.swift
//  Four Task
//
//  Created by Ilya Vasilev on 19.07.2022.
//

import Foundation
var stopTimeOne: Date?
var startTimeOne: Date?
var scheduledTimerOne: Timer!
//MARK: - START
extension ViewController {
    
    
func startActionOne() {
    if timerStarted.firstTimerStarted == false {
    setStopTimeOne(date: Date())
 stopTimerOne()
 }
}
///Запуск Stop Action Timer с проверкой есть ли пауза.
 func startTimerOne() {
scheduledTimerOne = Timer.scheduledTimer(timeInterval: 0.1 , target: self, selector: #selector(refreshValueOne), userInfo: nil, repeats: true)
setTimerCountingOne(true)
}
//MARK: - STOP
func stopActionOne() {
    if stopTimeOne != nil {
       let restartTime = calcRestartTimeOne(start: startTimeOne!, stop: stopTimeOne!)
        
setStopTimeOne(date: nil)
setStartTimeOne(date: restartTime)
    } else {
        setStartTimeOne(date: Date())
        }
        startTimerOne()
}

func stopTimerOne() {
    if scheduledTimerOne != nil {
        scheduledTimerOne.invalidate()
        setTimerCountingOne(false)
    }
}

func calcRestartTimeOne(start: Date, stop: Date) -> Date {
    let diff = start.timeIntervalSince(stop)
    return Date().addingTimeInterval(diff)
}
//MARK: - SET STOP_START_COUNTING_KEYS
func setStopTimeOne(date: Date?) {
    stopTimeOne = date
    userDefaults.set(stopTimeOne, forKey: STOP_KEYS[0])
    print("Установлен setStopTimeOne по Stop_keys0 в FirstButtonLogic.")
}
func setStartTimeOne(date: Date?) {
    startTimeOne = date
    userDefaults.set(startTimeOne, forKey: STARTING_KEYS[0])
    print("Установлен setStartTimeOne по Start_keys0 в FirstButtonLogic.")
}
func setTimerCountingOne(_ value: Bool) {
    timerStarted.firstTimerStarted = value
    userDefaults.set(timerStarted.firstTimerStarted, forKey: COUNTING_KEYS[0])
    print("Установлен setTimerCountingOne по Counting_keys0 в FirstButtonLogic.")
}
func setTimeLabelOne(_ value: Int) {
    let time = secToHourMinutesSecondsOne(seconds: value)
    let timeString = makeTimeStringOne(hours: time.0, minutes: time.1, seconds: time.2)
    clockLabel.text = timeString
///    print("Установлен LABEl СLOCK с переводом цифрового значения в строку в ButtonsModel.")
}
    ///Перевод секунд в час, минуту, секунду.
    public func secToHourMinutesSecondsOne(seconds: Int) -> (Int, Int, Int) {
        let hour =  (seconds / 3600)
        let mm = (seconds % 3600) / 60
        let sec = (seconds % 3600) % 60
        return (hour, mm, sec)
       
    }
    /// Перевод численных значений часы/минуты/секунды в формат String
    func makeTimeStringOne(hours: Int, minutes: Int, seconds: Int) -> String {
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
@objc func refreshValueOne() {
    if let start = startTimeOne {
        let diff = Date().timeIntervalSince(start)
        setTimeLabelOne(Int(diff))
    } else {
        stopTimerOne()
        setTimeLabelOne(0)
    }
}
}
