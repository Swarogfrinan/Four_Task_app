import UIKit

extension FourTaskViewController {
    func canSecondButtonAnimatedStarted() {
        if !timerStarted.secondTimerStarted {
            secondButtonStartedAnimation()
        }
    }
    func canSecondButtonAnimatedStopped() {
        if timerStarted.secondTimerStarted {
            secondButtonPauseAnimation()
        }
    }
    
    func secondButtonStartedAnimation() {
        UIView.animate(withDuration: 0.3) { [self] in
            let buttonColors: [UIColor] = [.systemGray, .systemGray2, .systemGray3]
            let buttons = [firstButton, thirdButton, fourButton]
            for (button, color) in zip(buttons, buttonColors) {
                button?.backgroundColor = color
                button?.isEnabled = false
            }
            clockLabel.textColor = .systemRed
            timerCounting = true
        }
    }
    
    func secondButtonPauseAnimation() {
        UIView.animate(withDuration: 0.3) { [self] in
            let buttonColors: [UIColor] = [.systemYellow, .systemBlue, .systemGreen]
            let buttons = [firstButton, thirdButton, fourButton]
            for (button, color) in zip(buttons, buttonColors) {
                button?.backgroundColor = color
                button?.isEnabled = true
            }
            clockLabel.textColor = .systemGray
            timerCounting = false
        }
    }
}
