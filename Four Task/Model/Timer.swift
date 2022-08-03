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

