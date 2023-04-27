import Foundation

//MARK: - Properties

var stopDateFirst: Date?
var startDateFirst: Date?
var scheduledTimerFirst: Timer!

//MARK: - FirstTask
extension FourTaskViewController {
    func refreshFirstBackgroundTimer() {
        if timerStarted.firstTimerStarted {
            startFirstTimer()
        } else {
            pauseFirstTimer()
            if let start = startDateFirst {
                if let stop = stopDateFirst {
                    let time = calculatedFirstRestartDate(start: start, stop: stop)
                    let diff = Date().timeIntervalSince(time)
                    setupFirstDefaultLabel(Int(diff))
                }
            }
        }
    }
    //MARK: - Start
    func fullStartFirstTimer() {
        print("Нажатие 1 кнопки")
        if timerCounting == true {
            print("TimerCounting = true в 1 кнопке")
            setFirstKeyPause(date: Date())
            canFirstButtonAnimatedStopped()
            pauseFirstTimer()
            print("1 таймер остановлен. UI отработал. ")
        } else {
            if let stop = stopDateFirst {
                let restartTime = calculatedFirstRestartDate(start: startDateFirst!, stop: stop)
                setFirstKeyPause(date: nil)
                setFirstKeyStart(date: restartTime)
            } else {
                setFirstKeyStart(date: Date())
            }
            canFirstButtonAnimatedStarted()
            startFirstTimer()
        }
    }
    ///Запуск Stop Action Timer с проверкой есть ли пауза.
    fileprivate func startFirstTimer() {
        scheduledTimerFirst = Timer.scheduledTimer(timeInterval: 0.1 , target: self, selector:    #selector(refreshFirstDefaultValue), userInfo: nil, repeats: true)
        setFirstKeyCounting(true)
        canFirstButtonAnimatedStarted()
    }
    //MARK: - STOP
    fileprivate func  pauseFirstAction() {
        if stopDateFirst != nil {
            let restartTime = calculatedFirstRestartDate(start: startDateFirst!, stop: stopDateFirst!)
            setFirstKeyPause(date: nil)
            setFirstKeyStart(date: restartTime)
        } else {
            setFirstKeyStart(date: Date())
        }
        startFirstTimer()
    }
    
    fileprivate func pauseFirstTimer() {
        if scheduledTimerFirst != nil {
            scheduledTimerFirst.invalidate()
            setFirstKeyCounting(false)
        }
    }
    
    fileprivate func calculatedFirstRestartDate(start: Date, stop: Date) -> Date {
        let diff = start.timeIntervalSince(stop)
        return Date().addingTimeInterval(diff)
    }
    //MARK: - Setyp UserDefaults Keys.
    fileprivate func setFirstKeyPause(date: Date?) {
        stopDateFirst = date
        userDefaults.set(stopDateFirst, forKey: FirstKeys.stop.rawValue)
        print("Установлен setStopTimeOne по Stop_keys0 в FirstButtonLogic.")
    }
    fileprivate func setFirstKeyStart(date: Date?) {
        startDateFirst = date
        userDefaults.set(startDateFirst, forKey: FirstKeys.start.rawValue)
        print("Установлен setStartTimeOne по Start_keys0 в FirstButtonLogic.")
    }
    fileprivate func setFirstKeyCounting(_ value: Bool) {
        timerStarted.firstTimerStarted = value
        userDefaults.set(timerStarted.firstTimerStarted, forKey: FirstKeys.counting.rawValue)
        print("Установлен setTimerCountingOne по Counting_keys0 в FirstButtonLogic.")
    }
    ///Установить лейблы и цвета по отформатированному времени.
    fileprivate func setupFirstDefaultLabel(_ value: Int) {
        let time = secToHourMinutesSeconds(seconds: value)
        let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
        clockLabel.text = timeString
        firstCountableLabel.text = timeString
        firstCountableLabel.textColor = .systemYellow
    }
  
    //MARK: - Reset Default Action
    ///Сбросить Date  и выставить лейблы на 0
    func resetFirstActionToDefault() {
        setFirstKeyPause(date: nil)
        setFirstKeyStart(date: nil)
        clockLabel.text = makeTimeString(hours: 0, minutes: 0, seconds: 0)
        firstCountableLabel.text = makeTimeString(hours: 0, minutes: 0, seconds: 0)
        pauseFirstTimer()
        //    animateFirstViewStop()
    }
    //MARK: - RefreshValue
    ///Обновление данных, если что-то не так. Установка лейблу нуля.
    @objc private func refreshFirstDefaultValue() {
        if let start = startDateFirst {
            let diff = Date().timeIntervalSince(start)
            setupFirstDefaultLabel(Int(diff))
        } else {
            pauseFirstTimer()
            setupFirstDefaultLabel(0)
        }
    }
}
