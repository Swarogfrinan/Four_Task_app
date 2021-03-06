//
//  ThirdButtonLogic.swift
//  Third Task logic model
//
//  Created by Ilya Vasilev on 20.07.2022.
//

import Foundation
var stopTimeThird: Date?
var startTimeThird: Date?
var scheduledTimerThird: Timer!

//MARK: - Extension
extension ViewController {
    func thirdRefreshBackgroundTimer() {
    if timerStarted.thirdTimerStarted {
        startTimerThird()
    } else {
        stopTimerThird()
        if let start = startTimeThird {
            if let stop = stopTimeThird {
                let time = calcRestartTimeThird(start: start, stop: stop)
                let diff = Date().timeIntervalSince(time)
                setTimeLabelThird(Int(diff))
            }
            }
            }
            }
    //MARK: - START
  func thirdTask(){
        print("Нажатие 3 кнопки")
        if timerCounting == true {
            print("TimerCounting = true в 3 кнопке")
            setStopTimeThird(date: Date())
            thirdTaskStop()
            stopTimerThird()
            print("3 таймер остановлен. UI отработал. ")
        } else {
            if let stop = stopTimeThird {
                let restartTime = calcRestartTimeThird(start: startTimeThird!, stop: stop)
                setStopTimeThird(date: nil)
                setStartTimeThird(date: restartTime)
            } else {
                setStartTimeThird(date: Date())
            }
            
            thirdTaskStart()
            startTimerThird()
        }
    }
///Запуск Stop Action Timer с проверкой есть ли пауза.
    fileprivate  func startTimerThird() {
scheduledTimerThird = Timer.scheduledTimer(timeInterval: 0.1 , target: self, selector: #selector(refreshValueThird), userInfo: nil, repeats: true)
setTimerCountingThird(true)
//        clockLabel.textColor = .systemBlue
        thirdTaskStart()
}
//MARK: - STOP
    func stopActionThird() {
    if stopTimeThird != nil {
        let restartTime = calcRestartTimeThird(start: startTimeThird!, stop: stopTimeThird!)
setStopTimeThird(date: nil)
setStartTimeThird(date: restartTime)
    } else {
        setStartTimeThird(date: Date())
        }
        startTimerThird()
}

    fileprivate func stopTimerThird() {
    if scheduledTimerThird != nil {
        scheduledTimerThird.invalidate()
        setTimerCountingThird(false)
    }
}

    fileprivate func calcRestartTimeThird(start: Date, stop: Date) -> Date {
    let diff = start.timeIntervalSince(stop)
    return Date().addingTimeInterval(diff)
}
//MARK: - SET STOP_START_COUNTING_KEYS
    fileprivate func setStopTimeThird(date: Date?) {
    stopTimeThird = date
    userDefaults.set(stopTimeThird, forKey: STOP_KEYS[2])
    print("Установлено значение setStopTimeThird по Stop_keys2 в ThirdButtonLogic.")
}
    fileprivate func setStartTimeThird(date: Date?) {
    startTimeThird = date
    userDefaults.set(startTimeThird, forKey: STARTING_KEYS[2])
    print("Установлено значение setStartTimeThird по ключуStart_keys02 в ThirdButtonLogic.")
}
    fileprivate func setTimerCountingThird(_ value: Bool) {
    timerStarted.thirdTimerStarted = value
    userDefaults.set(timerStarted.thirdTimerStarted, forKey: COUNTING_KEYS[2])
    print("Установлено значение setTimerCountingThird по Counting_keys2 в ThirdButtonLogic.")
}
    fileprivate func setTimeLabelThird(_ value: Int) {
    let time = secToHourMinutesSecondsThird(seconds: value)
    let timeString = makeTimeStringThird(hours: time.0, minutes: time.1, seconds: time.2)
    clockLabel.text = timeString
    taskNumbersThirdLabel.text = timeString
    taskNumbersThirdLabel.textColor = .systemBlue
///    print("Установлен LABEl СLOCK с переводом цифрового значения в строку в ButtonsModel.")
}
    ///Перевод секунд в час, минуту, секунду.
    fileprivate func secToHourMinutesSecondsThird(seconds: Int) -> (Int, Int, Int) {
        let hour =  (seconds / 3600)
        let mm = (seconds % 3600) / 60
        let sec = (seconds % 3600) % 60
        return (hour, mm, sec)
       
    }
    /// Перевод численных значений часы/минуты/секунды в формат String
  fileprivate  func makeTimeStringThird(hours: Int, minutes: Int, seconds: Int) -> String {
        var timeString = ""
        timeString += String(format: "%02d", hours)
        timeString += ":"
        timeString += String(format: "%02d", minutes)
        timeString += ":"
        timeString += String(format: "%02d", seconds)
        return timeString
    }
    //MARK: - ResetAction
    func resetActionThird() {
            setStopTimeThird(date: nil)
            setStartTimeThird(date: nil)
            clockLabel.text = makeTimeStringThird(hours: 0, minutes: 0, seconds: 0)
        taskNumbersThirdLabel.text = makeTimeStringThird(hours: 0, minutes: 0, seconds: 0)
            stopTimerThird()
//            animateThirdViewStart()
        }
//MARK: - RefreshValue
///Обновление данных, если что-то не так. Установка лейблу нуля.
@objc private func refreshValueThird() {
    if let start = startTimeThird {
        let diff = Date().timeIntervalSince(start)
        setTimeLabelThird(Int(diff))
    } else {
        stopTimerThird()
        setTimeLabelThird(0)
    }
}
}
