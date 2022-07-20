//
//  ViewController.swift
//  Four Task
//
//  Created by Ilya Vasilev on 12.07.2022.
//

import UIKit
import Foundation



class ViewController: UIViewController {
//MARK: - IBOutlet
    ///Navigation bar
    @IBOutlet weak var leftBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var rightBarButtonItem: UIBarButtonItem!
    ///IBOutlet View
    @IBOutlet weak var clockLabel: UILabel!
    @IBOutlet weak var firstTaskButton: UIButton!
    @IBOutlet weak var secondTaskButton: UIButton!
    @IBOutlet weak var thirdTaskButton: UIButton!
    @IBOutlet weak var fourTaskButton: UIButton!
    
    
    @IBOutlet weak var dayTimeLabel: UILabel!
    @IBOutlet weak var firstExtraLabel: UILabel!
    @IBOutlet weak var secondExtraLabel: UILabel!
    @IBOutlet weak var thirdExtraLabel: UILabel!
    @IBOutlet weak var fourExtraLabel: UILabel!
    
    //MARK: - Let/var

    var optionalTimer: Timer?
  
    let format = DateFormatter()
    let now = NSDate()
    var count : Int = 0
 

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        clockLabel.text = "Lets work"
        ///Установка верхнего лейбла - времени текущего дня. (12 Часовая)
        makeCurrentTime()
        
///first
        startTimeOne = userDefaults.object(forKey: START_TIME_KEY) as? Date
        stopTimeOne = userDefaults.object(forKey: STOP_TIME_KEY) as? Date
        ///second
        startTimeSecond = userDefaults.object(forKey: START_TIME_KEY_SECOND) as? Date
        stopTimeSecond = userDefaults.object(forKey: STOP_TIME_KEY_SECOND) as? Date
        
        
        timerStarted.firstTimerStarted = userDefaults.bool(forKey: COUNTING_KEY)
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

    
    //MARK: - IBOutlet methods
    ///Первая жёлтая кнопка
    @IBAction func firstTaskButtonPressed(_ sender: Any) {
            print("Нажатие первой кнопки")
            if timerCounting == true {
                print("TimerCounting = true в первой кнопке")
                setStopTimeOne(date: Date())
                firstTaskStop()
                stopTimerOne()
                print("первый таймер остановлен. UI отработал. ")
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
    
    ///Вторая красная кнопка
    @IBAction func secondTaskButtonPressed(_ sender: Any) {
        secondTask()
    }
    ///Третья синяя кнопка
    @IBAction func thirdTaskButtonPressed(_ sender: UIButton) {
        thirdTask()
    }
    ///Четвёртая зеленая кнопка
    @IBAction func fourTaskButtonPressed(_ sender: UIButton) {
        fourTask()
    }
    @IBAction func refreshButtonPressed(_ sender: UIButton) {
        refreshValue()
    }
    
    //MARK: - Methods
 
    ///Четверг проба функций
//    func setStartTimers(date: Date?) {
//        if firstTaskButton.isEnabled == true {
//        startTime = date
//            userDefaults.set(startTime, forKey: STARTING_KEYS[0])
//            print("Установка Старт Время - первый кейс сработал")
//        } else {
//            if secondTaskButton.isEnabled == true {
//                startTime = date
//                userDefaults.set(startTime, forKey: START_TIME_KEY_SECOND)
//                print("Установка Старт Время - второй кейс сработал")
//            } else {
//                if thirdTaskButton.isEnabled == true {
//                    startTime = date
//                    userDefaults.set(startTime, forKey: START_TIME_KEY_THIRD)
//                    print("Установка Старт Время - третий кейс сработал")
//                } else {
//                    if fourTaskButton.isEnabled == true {
//                        startTime = date
//                        userDefaults.set(startTime, forKey: START_TIME_KEY_FOUR)
//                        print("Установка Старт Время - четвертый кейс сработал")
//                }
//    }
//    }
//}
//    }
//    func setStopTimers(date: Date?) {
//        if firstTaskButton.isEnabled == false {
//        userDefaults.set(stopTime, forKey: STOP_TIME_KEY)
//            stopTime = date
//            print("Установка СТОП Время - первый кейс сработал")
//        } else {
//            if secondTaskButton.isEnabled == false {
//                stopTime = date
//                userDefaults.set(stopTime, forKey: STOP_TIME_KEY_SECOND)
//                print("Установка СТОП Время - второй кейс сработал")
//            } else {
//                if thirdTaskButton.isEnabled == false {
//                    stopTime = date
//                    userDefaults.set(stopTime, forKey: STOP_TIME_KEY_THIRD)
//                    print("Установка СТОП Время - третий кейс сработал")
//                } else {
//                    if fourTaskButton.isEnabled == false {
//                        stopTime = date
//                        userDefaults.set(stopTime, forKey: STOP_TIME_KEY_FOUR)
//                        print("Установка СТОП Время - четвертый кейс сработал")
//                }
//    }
//    }
//}
//    }
//    func setTimerCountingsKeys(value: Bool) {
////        if clockLabel.textColor == .systemYellow || clockLabel.textColor == .systemGray {
//            timerStarted = value
//            userDefaults.set(timerStarted, forKey: COUNTING_KEY)
//            print("Установка СЧËТЧИК COUNTING Время - первый кейс сработал")
//        } else {
//            if clockLabel.textColor == .systemRed {
//                timerStarted = value
//                userDefaults.set(timerStarted, forKey: COUNTING_KEY_SECOND)
//                print("Установка СЧËТЧИК COUNTING Время - второй кейс сработал")
//            } else {
//                if clockLabel.textColor == .systemBlue {
//                    timerStarted = value
//                    userDefaults.set(timerStarted, forKey: COUNTING_KEY_THIRD)
//                    print("Установка СЧËТЧИК COUNTING Время - Третий кейс сработал")
//                } else {
//                    if clockLabel.textColor == .systemGreen {
//                        timerStarted = value
//                        userDefaults.set(timerStarted, forKey: COUNTING_KEY_FOUR)
//                        print("Установка СЧËТЧИК COUNTING Время - Четвертый кейс сработал")
//    }
//                }
//            }
//        }
//    }
    
    
        //Четверг проба пера
//конец
    
    
    
   
    
    
}
///Счётчик таймера (Старая версия)
//    @objc func timerCounter() -> Void {
//        count = count + 1
//        let time = secondToHourMinutesSeconds(seconds: count)
//        let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
//        clockLabel.text = timeString
//    }
