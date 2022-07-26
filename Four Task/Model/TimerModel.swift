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
    fourTimerStarted: false,
    tomatoTimerStarted: false,
    tomatoRestTimerStarted : false
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
