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
    
    @IBOutlet var buttonCollections: [UIButton]!
    
    @IBOutlet weak var dayTimeLabel: UILabel!
    @IBOutlet weak var firstExtraLabel: UILabel!
    @IBOutlet weak var secondExtraLabel: UILabel!
    @IBOutlet weak var thirdExtraLabel: UILabel!
    @IBOutlet weak var fourExtraLabel: UILabel!
    
    //MARK: - Let/var
    var timer = Timer()
    var optionalTimer: Timer?
    var firstTimer = Timer()
    var secondTimer = Timer()
    var thirdTimer = Timer()
    var fourTimer = Timer()
    
    let format = DateFormatter()
    let now = NSDate()
    var count : Int = 0

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        clockLabel.text = "Lets work"
        ///Установка верхнего лейбла - времени текущего дня. (12 Часовая)
        makeCurrentTime()
        
        
        startTime = userDefaults.object(forKey: START_TIME_KEY) as? Date
        stopTime = userDefaults.object(forKey: STOP_TIME_KEY) as? Date
        timerStarted = userDefaults.bool(forKey: COUNTING_KEY)
        if timerStarted {
            startTimer()
        } else {
            stopTimer()
            if let start = startTime {
                if let stop = stopTime {
                    let time = calcRestartTime(start: start, stop: stop)
                    let diff = Date().timeIntervalSince(time)
                    setTimeLabel(Int(diff))
                }
            }
        }
        
    }

    
    //MARK: - IBOutlet methods
    ///Первая жёлтая кнопка
    @IBAction func firstTaskButtonPressed(_ sender: UIButton) {
       firstTask()
    }
    ///Вторая красная кнопка
    @IBAction func secondTakeButtonPressed(_ sender: UIButton) {
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
    
    //MARK: - Methods
    ///Счётчик таймера (Старая версия)
    @objc func timerCounter() -> Void {
        count = count + 1
        let time = secondToHourMinutesSeconds(seconds: count)
        let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
        clockLabel.text = timeString
    }
}






//MARK: - Extension + Methods
    extension ViewController {
        ///Функция первой задачи.
        func firstTask() {
        if (timerStarted) {
            startAction()
            UIView.animate(withDuration: 0.3) { [self] in
            secondTaskButton.backgroundColor = .systemRed
            thirdTaskButton.backgroundColor = .systemBlue
            fourTaskButton.backgroundColor = .systemGreen
            secondTaskButton.isEnabled = true
            thirdTaskButton.isEnabled = true
            fourTaskButton.isEnabled = true
            clockLabel.textColor = .systemGray
            }
            } else {
        if stopTime != nil {
    stopAction()
        UIView.animate(withDuration: 0.3) { [self] in
        secondTaskButton.backgroundColor = .systemGray
        thirdTaskButton.backgroundColor = .systemGray2
        fourTaskButton.backgroundColor = .systemGray3
            secondTaskButton.isEnabled = false
            thirdTaskButton.isEnabled = false
            fourTaskButton.isEnabled = false
            clockLabel.textColor = .systemYellow
         }
        }
            }
        }
            
        
        ///Функция второй задачи.
        func secondTask() {
            if (timerStarted) {
                startAction()
            UIView.animate(withDuration: 0.3) { [self] in
            firstTaskButton.backgroundColor = .systemYellow
            thirdTaskButton.backgroundColor = .systemBlue
            fourTaskButton.backgroundColor = .systemGreen
            firstTaskButton.isEnabled = true
            thirdTaskButton.isEnabled = true
            fourTaskButton.isEnabled = true
            clockLabel.textColor = .systemGray
            }
        } else {
            if stopTime != nil {
        stopAction()
            clockLabel.text = secondTimer.description
        UIView.animate(withDuration: 0.3) { [self] in
        firstTaskButton.backgroundColor = .systemGray
        thirdTaskButton.backgroundColor = .systemGray2
        fourTaskButton.backgroundColor = .systemGray3
        firstTaskButton.isEnabled = false
        thirdTaskButton.isEnabled = false
        fourTaskButton.isEnabled = false
        clockLabel.textColor = .systemRed
        }
        }
        }
        }
        ///Функция  третьей  задачи.
        func thirdTask() {
        if (timerStarted) {
            timerStarted = false
            timer.invalidate()
            UIView.animate(withDuration: 0.3) { [self] in
            secondTaskButton.backgroundColor = .systemRed
            firstTaskButton.backgroundColor = .systemYellow
            fourTaskButton.backgroundColor = .systemGreen
            firstTaskButton.isEnabled = true
            secondTaskButton.isEnabled = true
            fourTaskButton.isEnabled = true
            clockLabel.textColor = .systemGray
            }
        } else {
        timerStarted = true
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
               UIView.animate(withDuration: 0.3) { [self] in
        firstTaskButton.backgroundColor = .systemGray
        secondTaskButton.backgroundColor = .systemGray2
        fourTaskButton.backgroundColor = .systemGray3
        firstTaskButton.isEnabled = false
        secondTaskButton.isEnabled = false
        fourTaskButton.isEnabled = false
        clockLabel.textColor = .systemBlue
         }
        }
        }
        ///Функция четвёртой задачи.
        func fourTask() {
        if (timerStarted) {
            timerStarted = false
            timer.invalidate()
            UIView.animate(withDuration: 0.3) { [self] in
            firstTaskButton.backgroundColor = .systemYellow
            secondTaskButton.backgroundColor = .systemRed
            thirdTaskButton.backgroundColor = .systemBlue
            firstTaskButton.isEnabled = true
            secondTaskButton.isEnabled = true
            thirdTaskButton.isEnabled = true
            clockLabel.textColor = .systemGray
            }
            
        } else {
        timerStarted = true
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
               UIView.animate(withDuration: 0.3) { [self] in
        firstTaskButton.backgroundColor = .systemGray
        secondTaskButton.backgroundColor = .systemGray2
        thirdTaskButton.backgroundColor = .systemGray3
        firstTaskButton.isEnabled = false
        secondTaskButton.isEnabled = false
        thirdTaskButton.isEnabled = false
        clockLabel.textColor = .systemGreen
         }
        }
        }
        
    }
