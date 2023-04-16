import Foundation
protocol AnimationProtocol {
    func canButtonHaveAnimatedStart()
    func canButtonHaveAnimatedStop()
    func buttonStartedAnimation()
    func buttonPauseAnimation()
}

 protocol SetupKeysProtocol {
    func setKeyPause()
    func setKeyStart()
    func setKeyCounting()
}

protocol SetupLabelProtocol {
func setupDefaultLabel()
    
}

 protocol ResetProtocol {
func resetActionToDefault()
}

protocol PropertyProtocol {
    var stopDate : Date? { get set }
    var startDate: Date? { get set }
    var scheduletTimer: Timer! { get set }
}

protocol ButtonLogicProtocol : PropertyProtocol,AnimationProtocol, SetupLabelProtocol, SetupKeysProtocol, ResetProtocol {
   func refreshBackgroundTimer()
    func fullLauchTimer()
    func startTimer()
    func pauseAction()
    func pauseTimer()
}
