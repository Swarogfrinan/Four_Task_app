//
//  targetTask.swift
//  Four Task
//
//  Created by Ilya Vasilev on 12.07.2022.
//

import Foundation
import UIKit
//MARK: - Let/var
var scheduledTimer: Timer!
var timerStarted : Bool = false
var startTime:Date?
var stopTime:Date?
//MARK: - CodingKeys
let userDefaults = UserDefaults.standard
let START_TIME_KEY = "startTime"
let STOP_TIME_KEY = "stopTime"
let COUNTING_KEY = "countingKey"
let STARTING_KEYS = ["startTime", "StartimeSecond", "StartimeThird", "StartimeFour"]
//четверг проба пера
let START_TIME_KEY_SECOND = "startTimeSecond"
let START_TIME_KEY_THIRD = "startTimeThird"
let START_TIME_KEY_FOUR = "startTimeFour"
let STOP_TIME_KEY_SECOND = "stopTimeSecond"
let STOP_TIME_KEY_THIRD = "stopTimeThird"
let STOP_TIME_KEY_FOUR = "stopTimeFour"
let COUNTING_KEY_SECOND = "countingKeySecond"
let COUNTING_KEY_THIRD = "countingKeyThird"
let COUNTING_KEY_FOUR = "countingKeyFour"

//MARK: - Extension
extension ViewController {
///Запуск Action Timer
   func startAction() {
//    setStopTime(date: Date())
    setStopTimers(date: Date())
    stopTimer()
    }
    ///Запуск Stop Action Timer с проверкой есть ли пауза.
    func stopAction() {
        if stopTime != nil {
    let restartTime = calcRestartTime(start: startTime!, stop: stopTime!)
//    setStopTime(date: nil)
//    setStartTime(date: restartTime)
            setStopTimers(date: nil)
             setStartTimers(date: restartTime)
            } else {
//                setStartTime(date: Date())
                setStartTimers(date: Date())
            }
            startTimer()
    }
    ///Reset данных и выставление нуля.
    /// //if hidden false то ресет (Идея)
    func resetAction() {
//        setStopTime(date: nil)
//        setStartTime(date: nil)
        setStopTimers(date: nil)
        setStartTimers(date: nil)
        clockLabel.text = makeTimeString(hours: 0, minutes: 0, seconds: 0)
        stopTimer()
    }
    //Подсчёт сколько времени прошло с перезапуска.
    func calcRestartTime(start: Date, stop: Date) -> Date {
        let diff = start.timeIntervalSince(stop)
        return Date().addingTimeInterval(diff)
    }
    
    
    ///Установка стартового времени - по key с сохранением в USERDEFAULTS.
    func setStartTime(date: Date?) {
        startTime = date
        userDefaults.set(startTime, forKey: START_TIME_KEY)
    }
    ///Остановка стартового времени - по key с сохранением в USERDEFAULTS.
    func setStopTime(date: Date?) {
        stopTime = date
        userDefaults.set(stopTime, forKey: STOP_TIME_KEY)
    }
        //Ведется ли счёт времени - по key с сохранением в USERDEFAULTS.
    func setTimerCounting(value: Bool) {
        timerStarted = value
        userDefaults.set(timerStarted, forKey: COUNTING_KEY)
    }
    ///Запуск таймера
    func startTimer() {
        scheduledTimer = Timer.scheduledTimer(timeInterval: 0.1 , target: self, selector: #selector(refreshValue), userInfo: nil, repeats: true)
//        setTimerCounting(value: true)
        setTimerCountingsKeys(value: true)
    }
    ///Остановка таймера
    func stopTimer() {
        if scheduledTimer != nil {
            scheduledTimer.invalidate()
//            setTimerCounting(value: false)
            setTimerCountingsKeys(value: false)
            
        }
    }
    ///Установка лейбла времени по заданным числам.
    func setTimeLabel(_ val: Int) {
        let time = secondToHourMinutesSeconds(seconds: val)
        let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
        clockLabel.text = timeString
    }
    ///Обновление данных, если что-то не так. Установка лейблу нуля.
    @objc func refreshValue() {
        if let start = startTime {
            let diff = Date().timeIntervalSince(start)
            setTimeLabel(Int(diff))
        } else {
            stopTimer()
            setTimeLabel(0)
        }
    }
    
    
    
    
    
    
///Перевод секунд в час, минуту, секунду.
public func secondToHourMinutesSeconds(seconds: Int) -> (Int, Int, Int) {
    let hour =  (seconds / 3600)
    let mm = (seconds % 3600) / 60
    let sec = (seconds % 3600) % 60
    return (hour, mm, sec)
   
}
/// Перевод численных значений часы/минуты/секунды в формат String
func makeTimeString(hours: Int, minutes: Int, seconds: Int) -> String {
    var timeString = ""
    timeString += String(format: "%02d", hours)
    timeString += ":"
    timeString += String(format: "%02d", minutes)
    timeString += ":"
    timeString += String(format: "%02d", seconds)
    return timeString
}

public func createTimer() {
  if optionalTimer == nil {
    let timer = Timer(timeInterval: 1.0,
      target: self,
      selector: #selector(timerCounter),
      userInfo: nil,
      repeats: true)
    RunLoop.current.add(timer, forMode: .common)
    timer.tolerance = 0.1
    
    self.optionalTimer = timer
  }
}

public func cancelTimer() {
  optionalTimer?.invalidate()
  optionalTimer = nil
}

public func makeCurrentTime() {
Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (_) in
    let date = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "hh:MM:ss"
    let currentTime = dateFormatter.string(from: date)
    self.dayTimeLabel.text = currentTime
})
}
}

