//
//  ButtonsModel.swift
//  Four Task
//
//  Created by Ilya Vasilev on 19.07.2022.
//
//MARK: - First Logic Model
import Foundation
//MARK: - Let/var
var stopTimeOne: Date?
var startTimeOne: Date?
var scheduledTimerOne: Timer!
//MARK: - Extension
extension ViewController {
    ///Подтягивание 1 таймера из бэкграунда если он был нажат последним.
    func firstRefreshBackgroundTimer() {
        if timerStarted.firstTimerStarted {
            startTimerOne()
        } else {
            stopTimerOne()
            if let start = startTimeOne {
                if let stop = stopTimeOne {
                    let time = calcRestartTimeOne(start: start, stop: stop)
                    let diff = Date().timeIntervalSince(time)
                    setTimeLabelOne(Int(diff))
                }
            }
        }
    }
    //MARK: - Start
    func firstTask() {
        print("Нажатие 1 кнопки")
        if timerCounting == true {
            print("TimerCounting = true в 1 кнопке")
            setStopTimeOne(date: Date())
            firstTaskStop()
            stopTimerOne()
            print("1 таймер остановлен. UI отработал. ")
        } else {
            if let stop = stopTimeOne {
                let restartTime = calcRestartTimeOne(start: startTimeOne!, stop: stop)
                setStopTimeOne(date: nil)
                setStartTimeOne(date: restartTime)
            } else {
                setStartTimeOne(date: Date())
            }
            firstTaskStart()
            startTimerOne()
        }
    }
    ///Запуск Stop Action Timer с проверкой есть ли пауза.
    fileprivate func startTimerOne() {
        scheduledTimerOne = Timer.scheduledTimer(timeInterval: 0.1 , target: self, selector:    #selector(refreshValueOne), userInfo: nil, repeats: true)
        setTimerCountingOne(true)
        firstTaskStart()
    }
    //MARK: - STOP
    fileprivate func stopActionOne() {
        
        if stopTimeOne != nil {
            let restartTime = calcRestartTimeOne(start: startTimeOne!, stop: stopTimeOne!)
            setStopTimeOne(date: nil)
            setStartTimeOne(date: restartTime)
        } else {
            setStartTimeOne(date: Date())
        }
        startTimerOne()
    }
    
    fileprivate func stopTimerOne() {
        if scheduledTimerOne != nil {
            scheduledTimerOne.invalidate()
            setTimerCountingOne(false)
        }
    }
    
    fileprivate func calcRestartTimeOne(start: Date, stop: Date) -> Date {
        let diff = start.timeIntervalSince(stop)
        return Date().addingTimeInterval(diff)
    }
    //MARK: - Set userdefaults Keys.
    fileprivate func setStopTimeOne(date: Date?) {
        stopTimeOne = date
        userDefaults.set(stopTimeOne, forKey: FirstKeys.stop.rawValue)
        print("Установлен setStopTimeOne по Stop_keys0 в FirstButtonLogic.")
    }
    fileprivate func setStartTimeOne(date: Date?) {
        startTimeOne = date
        userDefaults.set(startTimeOne, forKey: FirstKeys.start.rawValue)
        print("Установлен setStartTimeOne по Start_keys0 в FirstButtonLogic.")
    }
    fileprivate func setTimerCountingOne(_ value: Bool) {
        timerStarted.firstTimerStarted = value
        userDefaults.set(timerStarted.firstTimerStarted, forKey: FirstKeys.counting.rawValue)
        print("Установлен setTimerCountingOne по Counting_keys0 в FirstButtonLogic.")
    }
    ///Установить лейблы и цвета по отформатированному времени.
    fileprivate func setTimeLabelOne(_ value: Int) {
        let time = secToHourMinutesSeconds(seconds: value)
        let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
        clockLabel.text = timeString
        taskNumberFirstLabel.text = timeString
        taskNumberFirstLabel.textColor = .systemYellow
    }
  
    //MARK: - ResetAction
    ///Сбросить Date  и выставить лейблы на 0
    func resetActionOne() {
        setStopTimeOne(date: nil)
        setStartTimeOne(date: nil)
        clockLabel.text = makeTimeString(hours: 0, minutes: 0, seconds: 0)
        taskNumberFirstLabel.text = makeTimeString(hours: 0, minutes: 0, seconds: 0)
        stopTimerOne()
        //    animateFirstViewStop()
    }
    //MARK: - RefreshValue
    ///Обновление данных, если что-то не так. Установка лейблу нуля.
    @objc private func refreshValueOne() {
        if let start = startTimeOne {
            let diff = Date().timeIntervalSince(start)
            setTimeLabelOne(Int(diff))
        } else {
            stopTimerOne()
            setTimeLabelOne(0)
        }
    }
}
