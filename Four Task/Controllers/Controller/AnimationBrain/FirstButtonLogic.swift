import Foundation

//MARK: - Properties

var stopDateFirst: Date?
var startDateFirst: Date?
var scheduledTimerFirst: Timer!

//MARK: - Extension
extension FourTaskViewController {
    ///Подтягивание 1 таймера из бэкграунда если он был нажат последним.
    func firstRefreshBackgroundTimer() {
        if timerStarted.firstTimerStarted {
            startTimerOne()
        } else {
            stopTimerOne()
            if let start = startDateFirst {
                if let stop = stopDateFirst {
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
            if let stop = stopDateFirst {
                let restartTime = calcRestartTimeOne(start: startDateFirst!, stop: stop)
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
        scheduledTimerFirst = Timer.scheduledTimer(timeInterval: 0.1 , target: self, selector:    #selector(refreshValueOne), userInfo: nil, repeats: true)
        setTimerCountingOne(true)
        firstTaskStart()
    }
    //MARK: - STOP
    fileprivate func stopActionOne() {
        
        if stopDateFirst != nil {
            let restartTime = calcRestartTimeOne(start: startDateFirst!, stop: stopDateFirst!)
            setStopTimeOne(date: nil)
            setStartTimeOne(date: restartTime)
        } else {
            setStartTimeOne(date: Date())
        }
        startTimerOne()
    }
    
    fileprivate func stopTimerOne() {
        if scheduledTimerFirst != nil {
            scheduledTimerFirst.invalidate()
            setTimerCountingOne(false)
        }
    }
    
    fileprivate func calcRestartTimeOne(start: Date, stop: Date) -> Date {
        let diff = start.timeIntervalSince(stop)
        return Date().addingTimeInterval(diff)
    }
    //MARK: - Set userdefaults Keys.
    fileprivate func setStopTimeOne(date: Date?) {
        stopDateFirst = date
        userDefaults.set(stopDateFirst, forKey: FirstKeys.stop.rawValue)
        print("Установлен setStopTimeOne по Stop_keys0 в FirstButtonLogic.")
    }
    fileprivate func setStartTimeOne(date: Date?) {
        startDateFirst = date
        userDefaults.set(startDateFirst, forKey: FirstKeys.start.rawValue)
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
        if let start = startDateFirst {
            let diff = Date().timeIntervalSince(start)
            setTimeLabelOne(Int(diff))
        } else {
            stopTimerOne()
            setTimeLabelOne(0)
        }
    }
}
