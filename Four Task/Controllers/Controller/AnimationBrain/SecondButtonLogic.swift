import Foundation

// MARK: - Properties

var stoppedDateSecond: Date?
var startedDateSecond: Date?
var scheduledTimerSecond: Timer!

extension FourTaskViewController {
    ///Подтягивание 2 таймера из бэкграунда если он был нажат последним.
    func secondRefreshBackgroundTimer() {
        if timerStarted.secondTimerStarted {
            startTimerSecond()
        } else {
            stopTimerSecond()
            if let start = startedDateSecond {
                if let stop = stoppedDateSecond {
                    let time = calcRestartTimeSecond (start: start, stop: stop)
                    let diff = Date().timeIntervalSince(time)
                    setTimeLabelSecond(Int(diff))
                }
            }
        }
    }
    //MARK: - Start
    func secondTask(){
        print("Нажатие 2 кнопки")
        if timerCounting == true {
            print("TimerCounting = true во 2 кнопке")
            setStopTimeSecond(date: Date())
            secondTaskStop()
            stopTimerSecond()
            print("2 таймер остановлен. UI отработал. ")
        } else {
            if let stop = stoppedDateSecond {
                let restartTime = calcRestartTimeSecond(start: startedDateSecond!, stop: stop)
                setStopTimeSecond(date: nil)
                setStartTimeSecond(date: restartTime)
            } else {
                setStartTimeSecond(date: Date())
            }
            secondTaskStart()
            startTimerSecond()
        }
    }
    ///Запуск Stop Action Timer с проверкой есть ли пауза.
    fileprivate  func startTimerSecond() {
        scheduledTimerSecond = Timer.scheduledTimer(timeInterval: 0.1 , target: self, selector: #selector(refreshValueSecond), userInfo: nil, repeats: true)
        setTimerCountingSecond(true)
        secondTaskStart()
    }
    //MARK: - STOP
    func stopActionSecond() {
        
        if stoppedDateSecond != nil {
            let restartTime = calcRestartTimeSecond(start: startedDateSecond!, stop: stoppedDateSecond!)
            setStopTimeSecond(date: nil)
            setStartTimeSecond(date: restartTime)
        } else {
            setStartTimeSecond(date: Date())
        }
        startTimerSecond()
    }
    
    fileprivate func stopTimerSecond() {
        if scheduledTimerSecond != nil {
            scheduledTimerSecond.invalidate()
            setTimerCountingSecond(false)
        }
    }
    
    fileprivate func calcRestartTimeSecond(start: Date, stop: Date) -> Date {
        let diff = start.timeIntervalSince(stop)
        return Date().addingTimeInterval(diff)
    }
    //MARK: - SET STOP_START_COUNTING_KEYS
    fileprivate func setStopTimeSecond(date: Date?) {
        stoppedDateSecond = date
        userDefaults.set(stoppedDateSecond, forKey: SecondKeys.stop.rawValue)
        print("Установлено значение setStopTimeSecond по Stop_keys1 в SecondButtonLogic.")
    }
    fileprivate func setStartTimeSecond(date: Date?) {
        startedDateSecond = date
        userDefaults.set(startedDateSecond, forKey: SecondKeys.start.rawValue)
        print("Установлено значение setStartTimeSecond по ключуStart_keys01 в SecondButtonLogic.")
    }
    fileprivate func setTimerCountingSecond(_ value: Bool) {
        timerStarted.secondTimerStarted = value
        userDefaults.set(timerStarted.secondTimerStarted, forKey: SecondKeys.counting.rawValue)
        print("Установлено значение setTimerCountingSecond по Counting_keys1 в SecondButtonLogic.")
    }
    fileprivate func setTimeLabelSecond(_ value: Int) {
        let time = secToHourMinutesSeconds(seconds: value)
        let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
        clockLabel.text = timeString
        taskNumberSecondLabel.text = timeString
        taskNumberSecondLabel.textColor = .systemRed
    }

    //MARK: - ResetAction
    func resetActionSecond() {
        setStopTimeSecond(date: nil)
        setStartTimeSecond(date: nil)
        clockLabel.text = makeTimeString(hours: 0, minutes: 0, seconds: 0)
        taskNumberSecondLabel.text = makeTimeString(hours: 0, minutes: 0, seconds: 0)
        stopTimerSecond()
        //        animateSecondViewStop()
    }
    //MARK: - RefreshValue
    ///Обновление данных, если что-то не так. Установка лейблу нуля.
    @objc private func refreshValueSecond() {
        if let start = startedDateSecond {
            let diff = Date().timeIntervalSince(start)
            setTimeLabelSecond(Int(diff))
        } else {
            stopTimerSecond()
            setTimeLabelSecond(0)
        }
    }
}
