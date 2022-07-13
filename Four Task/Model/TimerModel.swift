//
//  targetTask.swift
//  Four Task
//
//  Created by Ilya Vasilev on 12.07.2022.
//

import Foundation
import UIKit

var scheduledTimer: Timer!
var timerStarted : Bool = false
var startTime:Date?
var stopTime:Date?

let userDefaults = UserDefaults.standard
let START_TIME_KEY = "startTime"
let STOP_TIME_KEY = "stopTime"
let COUNTING_KEY = "countingKey"

extension ViewController {
    
   func startAction() {
//    if timerStarted {
    setStoptTime(date: Date())
    stopTimer()
//    }
    }
    
    func stopAction() {
        if stopTime != nil {
    let restartTime = calcRestartTime(start: startTime!, stop: stopTime!)
    setStoptTime(date: nil)
    setStartTime(date: restartTime)
            } else {
                setStartTime(date: Date())
            }
            startTimer()
    }
    func resetAction() {
        setStoptTime(date: nil)
        setStartTime(date: nil)
        clockLabel.text = makeTimeString(hours: 0, minutes: 0, seconds: 0)
        stopTimer()
    }
    
    func calcRestartTime(start: Date, stop: Date) -> Date {
        let diff = start.timeIntervalSince(stop)
        return Date().addingTimeInterval(diff)
    }
    
    

    func setStartTime(date: Date?) {
        startTime = date
        userDefaults.set(startTime, forKey: START_TIME_KEY)
    }
    func setStoptTime(date: Date?) {
        stopTime = date
        userDefaults.set(stopTime, forKey: STOP_TIME_KEY)
    }
    func setTimerCounting(value: Bool) {
        timerStarted = value
        userDefaults.set(timerStarted, forKey: COUNTING_KEY)
    }
    
    
    
    func startTimer() {
        scheduledTimer = Timer.scheduledTimer(timeInterval: 0.1 , target: self, selector: #selector(refreshValue), userInfo: nil, repeats: true)
        setTimerCounting(value: true)
    }
    func stopTimer() {
        if scheduledTimer != nil {
            scheduledTimer.invalidate()
            setTimerCounting(value: false)
            
        }
    }
    func setTimeLabel(_ val: Int) {
        let time = secondToHourMinutesSeconds(seconds: val)
        let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
        clockLabel.text = timeString
    }
    
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
/// Перевод численных значений в формат String
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

