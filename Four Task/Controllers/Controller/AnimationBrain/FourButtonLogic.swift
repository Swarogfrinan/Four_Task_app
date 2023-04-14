import Foundation

//MARK: - Properties

var stopTimeFour: Date?
var startTimeFour: Date?
var scheduledTimerFour: Timer!

extension FourTaskViewController {

    func fourRefreshBackgroundTimer() {
        if timerStarted.fourTimerStarted {
            startTimerFour()
        } else {
            stopTimerFour()
            if let start = startTimeFour {
                if let stop = stopTimeFour {
                    let time = calcRestartTimeFour(start: start, stop: stop)
                    let diff = Date().timeIntervalSince(time)
                    setTimeLabelFour(Int(diff))
                }
            }
        }
    }
    //MARK: - START
    func fourTask(){
        print("Нажатие 4 кнопки")
        if timerCounting == true {
            print("TimerCounting = true в 4 кнопке")
            setStopTimeFour(date: Date())
            fourTaskStop()
            stopTimerFour()
            print("4 таймер остановлен. UI отработал. ")
        } else {
            if let stop = stopTimeFour {
                let restartTime = calcRestartTimeFour(start: startTimeFour!, stop: stop)
                setStopTimeFour(date: nil)
                setStartTimeFour(date: restartTime)
            } else {
                setStartTimeFour(date: Date())
            }
            fourTaskStart()
            startTimerFour()
        }
    }
    ///Запуск Stop Action Timer с проверкой есть ли пауза.
    fileprivate  func startTimerFour() {
        scheduledTimerFour = Timer.scheduledTimer(timeInterval: 0.1 , target: self, selector: #selector(refreshValueFour), userInfo: nil, repeats: true)
        setTimerCountingFour(true)
        fourTaskStart()
    }
    //MARK: - STOP
    func stopActionFour() {
        
        if stopTimeFour != nil {
            let restartTime = calcRestartTimeFour(start: startTimeFour!, stop: stopTimeFour!)
            setStopTimeFour(date: nil)
            setStartTimeFour(date: restartTime)
        } else {
            setStartTimeFour(date: Date())
        }
        startTimerFour()
    }
    
    fileprivate func stopTimerFour() {
        if scheduledTimerFour != nil {
            scheduledTimerFour.invalidate()
            setTimerCountingFour(false)
        }
    }
    
    fileprivate func calcRestartTimeFour(start: Date, stop: Date) -> Date {
        let diff = start.timeIntervalSince(stop)
        return Date().addingTimeInterval(diff)
    }
    //MARK: - SET STOP_START_COUNTING_KEYS
    fileprivate func setStopTimeFour(date: Date?) {
        stopTimeFour = date
        userDefaults.set(stopTimeFour, forKey: FourKeys.stop.rawValue)
    }
    fileprivate func setStartTimeFour(date: Date?) {
        startTimeFour = date
        userDefaults.set(startTimeFour, forKey: FourKeys.start.rawValue)
    }
    fileprivate func setTimerCountingFour(_ value: Bool) {
        timerStarted.fourTimerStarted = value
        userDefaults.set(timerStarted.fourTimerStarted, forKey: FourKeys.counting.rawValue)
    }
    fileprivate func setTimeLabelFour(_ value: Int) {
        let time = secToHourMinutesSeconds(seconds: value)
        let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
        clockLabel.text = timeString
        taskNumbersFourLabel.text = timeString
        taskNumbersFourLabel.textColor = .systemGreen

    }

    //MARK: - ResetAction
    func resetActionFour() {
        setStopTimeFour(date: nil)
        setStartTimeFour(date: nil)
        clockLabel.text = makeTimeString(hours: 0, minutes: 0, seconds: 0)
        taskNumbersFourLabel.text = makeTimeString(hours: 0, minutes: 0, seconds: 0)
        
        stopTimerFour()
        //        animateFourViewStart()
    }
    //MARK: - RefreshValue
    ///Обновление данных, если что-то не так. Установка лейблу нуля.
    @objc private func refreshValueFour() {
        if let start = startTimeFour {
            let diff = Date().timeIntervalSince(start)
            setTimeLabelFour(Int(diff))
        } else {
            stopTimerFour()
            setTimeLabelFour(0)
        }
    }
}
