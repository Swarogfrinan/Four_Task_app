//
//  Timer.swift
//  Four Task
//
//  Created by Ilya Vasilev on 03.08.2022.
//

import Foundation
//MARK: - Let/var
var scheduledTimer: Timer!
var startTime:Date?
var stopTime:Date?
var started : Bool = false
var timerCounting: Bool = false


///Стартовые ключи для запуска кнопок
var timerStarted = (
    firstTimerStarted: false,
    secondTimerStarted: false,
    thirdTimerStarted: false,
    fourTimerStarted: false,
    tomatoTimerStarted: false,
    tomatoRestTimerStarted : false
)

public func secToHourMinutesSeconds(seconds: Int) -> (Int, Int, Int) {
    let hour =  (seconds / 3600)
    let mm = (seconds % 3600) / 60
    let sec = (seconds % 3600) % 60
    return (hour, mm, sec)
    
}
/// Перевод численных значений часы/минуты/секунды в формат String
public func makeTimeString(hours: Int, minutes: Int, seconds: Int) -> String {
    var timeString = ""
    timeString += String(format: "%02d", hours)
    timeString += ":"
    timeString += String(format: "%02d", minutes)
    timeString += ":"
    timeString += String(format: "%02d", seconds)
    return timeString
}
