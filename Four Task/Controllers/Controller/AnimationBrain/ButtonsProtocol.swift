import Foundation

protocol PropertyProtocol {
    var stopDate : Date? { get set }
    var startDate: Date? { get set }
    var scheduledTimer: Timer! { get set }
}

 protocol SetupKeysProtocol {
    func setKeyPause(date: Date?)
    func setKeyStart(date: Date?)
    func setKeyCounting(_ value: Bool)
}

protocol SetupLabelProtocol {
func setupDefaultLabel(_ value: Int)
}


protocol CalculatedTimeProtocol {
    func calculatedRestartDate(start: Date, stop: Date) -> Date
}

protocol ResetProtocol {
func resetActionToDefault()
}

@objc protocol RefreshDefaultValue {
    func refreshDefaultValue()
}

protocol ButtonLogicProtocol : PropertyProtocol, SetupLabelProtocol, SetupKeysProtocol, CalculatedTimeProtocol, ResetProtocol, RefreshDefaultValue {
    
   func refreshBackgroundTimer()
    func fullLauchTimer()
    func pauseAction()
    func pauseTimer()
}
