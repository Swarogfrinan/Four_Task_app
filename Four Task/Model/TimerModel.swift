//
//  targetTask.swift
//  Four Task
//
//  Created by Ilya Vasilev on 12.07.2022.
//

import Foundation
import UIKit
///Первый ключ
enum firstKeys : String {
    case Start = "startTimeFirstKey"
    case Stop = "stopTimeFirstKey"
    case Counting = "countingTimeFirstKey"
    static let firstKeys = [Start, Stop, Counting]
}
///Второй ключ
enum secondKeys : String {
    case Start = "startTimeSecondKey"
    case Stop = "stopTimeSecondKey"
    case Counting = "countingTimeSecondKey"
    static let secondKeys = [Start, Stop, Counting]
}
///Третий  ключ
enum thirdKeys : String {
    case Start = "startTimeThirdKey"
    case Stop = "stopTimeThirdKey"
    case Counting = "countingTimeThirdKey"
    static let secondKeys = [Start, Stop, Counting]
}
///Четвертый ключ
enum fourKeys : String {
    case Start = "startTimeFourKey"
    case Stop = "stopTimeFourKey"
    case Counting = "countingTimeFourKey"
    static let secondKeys = [Start, Stop, Counting]
}

//MARK: - Let/var
var scheduledTimer: Timer!
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
//let STARTING_KEYS = [
//    "startTimeFirstKey",
//    "startimeSecondKey",
//    "startimeThirdKey",
//    "startimeFourKey"]
//
/////Стоп ключи для запуска кнопок
//let STOP_KEYS = [
//    "stopTimeFirstKey",
//    "stopTimeSecondKey",
//    "stopTimeThirdKey",
//    "stopTimeFourKey"]
/////Ключи каунтинга времени для запуска кнопок
//let COUNTING_KEYS = [
//    "countingTimeFirstKey",
//    "countingTimeSecondKey",
//    "countingKeyThirdKey",
//    "countingKeyFourKey"
//]



