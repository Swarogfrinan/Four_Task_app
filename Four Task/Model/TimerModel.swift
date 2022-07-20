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
//var timerStarted : Bool = false
var startTime:Date?
var stopTime:Date?
var started : Bool = false
var timerCounting: Bool = false
//MARK: - CodingKeys
let userDefaults = UserDefaults.standard
///Стартовые ключи для запуска кнопок
var timerStarted = (
    firstTimerStarted: false,
    secondTimerStarted: false,
    thirdTimerStarted: false,
    fourTimerStarted: false
)
let STARTING_KEYS = [
    "startTimeFirstKey",
    "startimeSecondKey",
    "startimeThirdKey",
    "startimeFourKey"]

///Стоп ключи для запуска кнопок
let STOP_KEYS = [
    "stopTimeFirstKey",
    "stopTimeSecondKey",
    "stopTimeThirdKey",
    "stopTimeFourKey"]
///Ключи каунтинга времени для запуска кнопок
let COUNTING_KEYS = [
    "countingTimeFirstKey",
    "countingTimeSecondKey",
    "countingKeyThirdKey",
    "countingKeyFourKey"
]

//MARK: - Extension
extension ViewController {
    
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

/////Запуск Action Timer
//   func startAction() {
//       if timerStarted.secondTimerStarted {
//    setStopTime(date: Date())
////    setStopTimers(date: Date())
//    stopTimer()
//    }
//   }
//    ///Запуск Stop Action Timer с проверкой есть ли пауза.
//    func stopAction() {
//        if stopTime != nil {
//    let restartTime = calcRestartTime(start: startTime!, stop: stopTime!)
//    setStopTime(date: nil)
//    setStartTime(date: restartTime)
////            setStopTimers(date: nil)
////             setStartTimers(date: restartTime)
//            } else {
//                setStartTime(date: Date())
////                setStartTimers(date: Date())
//            }
//            startTimer()
//    }
//    ///Reset данных и выставление нуля.
//    /// //if hidden false то ресет (Идея)
//    func resetAction() {
//        setStopTime(date: nil)
//        setStartTime(date: nil)
////        setStopTimers(date: nil)
////        setStartTimers(date: nil)
//        clockLabel.text = makeTimeString(hours: 0, minutes: 0, seconds: 0)
//        stopTimer()
//    }
//    //Подсчёт сколько времени прошло с перезапуска.
//    func calcRestartTime(start: Date, stop: Date) -> Date {
//        let diff = start.timeIntervalSince(stop)
//        return Date().addingTimeInterval(diff)
//    }
//    
//    
//    ///Установка стартового времени - по key с сохранением в USERDEFAULTS.
//    func setStartTime(date: Date?) {
//        startTime = date
//        userDefaults.set(startTime, forKey: START_TIME_KEY)
//    }
//    ///Остановка стартового времени - по key с сохранением в USERDEFAULTS.
//    func setStopTime(date: Date?) {
//        stopTime = date
//        userDefaults.set(stopTime, forKey: STOP_TIME_KEY)
//    }
//        //Ведется ли счёт времени - по key с сохранением в USERDEFAULTS.
//    func setTimerCounting(value: Bool) {
//        timerStarted.firstTimerStarted = value
//        userDefaults.set(timerStarted, forKey: COUNTING_KEY)
//    }
//    ///Запуск таймера
//    func startTimer() {
//        scheduledTimer = Timer.scheduledTimer(timeInterval: 0.1 , target: self, selector: #selector(refreshValue), userInfo: nil, repeats: true)
//        setTimerCounting(value: true)
////        setTimerCountingsKeys(value: true)
//    }
//    ///Остановка таймера
//    func stopTimer() {
//        if scheduledTimer != nil {
//            scheduledTimer.invalidate()
//            setTimerCounting(value: false)
////            setTimerCountingsKeys(value: false)
//            
//        }
//    }
//    ///Установка лейбла времени по заданным числам.
//    func setTimeLabel(_ val: Int) {
//        let time = secondToHourMinutesSeconds(seconds: val)
//        let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
//        clockLabel.text = timeString
//    }
//    ///Обновление данных, если что-то не так. Установка лейблу нуля.
//    @objc func refreshValue() {
//        if let start = startTime {
//            let diff = Date().timeIntervalSince(start)
//            setTimeLabel(Int(diff))
//        } else {
//            stopTimer()
//            setTimeLabel(0)
//        }
//    }
//    
//    
//    
//    
//    
//    
/////Перевод секунд в час, минуту, секунду.
//public func secondToHourMinutesSeconds(seconds: Int) -> (Int, Int, Int) {
//    let hour =  (seconds / 3600)
//    let mm = (seconds % 3600) / 60
//    let sec = (seconds % 3600) % 60
//    return (hour, mm, sec)
//   
//}
///// Перевод численных значений часы/минуты/секунды в формат String
//func makeTimeString(hours: Int, minutes: Int, seconds: Int) -> String {
//    var timeString = ""
//    timeString += String(format: "%02d", hours)
//    timeString += ":"
//    timeString += String(format: "%02d", minutes)
//    timeString += ":"
//    timeString += String(format: "%02d", seconds)
//    return timeString
//}
//
//

//}

//public func createTimer() {
//  if optionalTimer == nil {
//    let timer = Timer(timeInterval: 1.0,
//      target: self,
//      selector: #selector(timerCounter),
//      userInfo: nil,
//      repeats: true)
//    RunLoop.current.add(timer, forMode: .common)
//    timer.tolerance = 0.1
//
//    self.optionalTimer = timer
//  }
//}
//
//public func cancelTimer() {
//  optionalTimer?.invalidate()
//  optionalTimer = nil
//}
