import UIKit

final class FirstButton: ButtonLogicProtocol {
    
    //MARK: - Properties
    
var scheduledTimer: Timer!
var stopDate: Date?
var startDate: Date?
    var userDefaults = UserDefaults.standard
    var animationDelegate : AnimationProtocol?
    weak var buttonDelegate : ButtonDelegateProtocol?
    
    //MARK: - LoadFromUserDefaults
    
    func firstLoadFromUserDefaults() {
        startDate = userDefaults.object(forKey: FirstKeys.start.rawValue) as? Date
        stopDate = userDefaults.object(forKey: FirstKeys.stop.rawValue) as? Date
        timerStarted.firstTimerStarted = userDefaults.bool(forKey: FirstKeys.counting.rawValue)
        if timerStarted.firstTimerStarted {
            refreshBackgroundTimer()
                animationDelegate?.buttonStartAnimation()
        } else {
        }
    }
    
    //MARK: - Start Method
    func fullLauchTimer() {
        if timerCounting == true {
            setKeyPause(date: Date())
            animationDelegate?.buttonPauseAnimation()
            pauseTimer()
        } else {
            if let stop = stopDate {
                if let start = startDate {
                    let restartTime = calculatedRestartDate(start: start, stop: stop)
                    setKeyPause(date: nil)
                    setKeyStart(date: restartTime)
                }
            } else {
                setKeyStart(date: Date())
            }
            animationDelegate?.canButtonHaveAnimatedStart()
            startTimer()
        }
    }
    func startTimer() {
        scheduledTimer = Timer.scheduledTimer(timeInterval: 0.1 , target: self, selector:    #selector(refreshDefaultValue), userInfo: nil, repeats: true)
        setKeyCounting(true)
            animationDelegate?.canButtonHaveAnimatedStart()
    }
    //MARK: - Pause Method
    func pauseAction() {
        if stopDate != nil {
            let restartTime = calculatedRestartDate(start: startDate!, stop: stopDate!)
            setKeyPause(date: nil)
            setKeyStart(date: restartTime)
        } else {
            setKeyStart(date: Date())
        }
        startTimer()
    }
    
    func pauseTimer() {
        if scheduledTimer != nil {
            scheduledTimer.invalidate()
            setKeyCounting(false)
        }
    }
    func calculatedRestartDate(start: Date, stop: Date) -> Date {
        let diff = start.timeIntervalSince(stop)
        return Date().addingTimeInterval(diff)
    }
    
    func setupDefaultLabel(_ value: Int) {
        let time = secToHourMinutesSeconds(seconds: value)
        let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
        buttonDelegate?.setupTimeString(didChangeTitle: timeString)
        buttonDelegate?.changeColor(didChangeColor: .systemYellow)
    }
    
    func setKeyPause(date: Date?) {
        stopDate = date
        userDefaults.set(stopDate, forKey: FirstKeys.stop.rawValue)
    }
    func setKeyStart(date: Date?) {
        startDate = date
        userDefaults.set(startDate, forKey: FirstKeys.start.rawValue)
    }
    
    func setKeyCounting(_ value: Bool) {
        timerStarted.firstTimerStarted = value
        userDefaults.set(timerStarted.firstTimerStarted, forKey: FirstKeys.counting.rawValue)
    }
    
    @objc func refreshDefaultValue() {
         if let start = startDate {
             let diff = Date().timeIntervalSince(start)
             setupDefaultLabel(Int(diff))
         } else {    
             pauseTimer()
             setupDefaultLabel(0)
         }
     }
     
     func refreshBackgroundTimer() {
         if timerStarted.firstTimerStarted {
             startTimer()
         } else {
             pauseTimer()
             if let start = startDate {
                 if let stop = stopDate {
                     let calculatedTime = calculatedRestartDate(start: start, stop: stop)
                     let diff = Date().timeIntervalSince(calculatedTime)
                     setupDefaultLabel(Int(diff))
                 }
             }
         }
     }
    func resetActionToDefault() {
      setKeyPause(date: nil)
        setKeyStart(date: nil)
        buttonDelegate?.setupTimeString(didChangeTitle: makeTimeString(hours: 0, minutes: 0, seconds: 0))
        pauseTimer()
        animationDelegate?.buttonPauseAnimation()
        
    }
}

