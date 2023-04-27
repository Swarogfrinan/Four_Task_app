import UIKit

extension FourTaskViewController {
    
    func canThirdAnimatedStart() {
        if !timerStarted.thirdTimerStarted {
            thirdButtonStartAnimation()
        }
    }
    
    func canThirdAnimatedStopped() {
        if timerStarted.thirdTimerStarted {
            thirdButtonPauseAnimation()
        }
    }
    
    func thirdButtonStartAnimation() {
        UIView.animate(withDuration: 0.3) { [self] in
            let buttonColors: [UIColor] = [.systemGray, .systemGray2, .systemGray3]
            let buttons = [firstButton, secondButton, fourButton]
            for (button, color) in zip(buttons, buttonColors) {
                button?.backgroundColor = color
                button?.isEnabled = true
            }
            clockLabel.textColor = .systemBlue
            timerCounting = true
        }
    }
    
    func thirdButtonPauseAnimation() {
        UIView.animate(withDuration: 0.3) { [self] in
            let buttonColors: [UIColor] = [.systemYellow, .systemRed, .systemGreen]
            let buttons = [firstButton, secondButton, fourButton]
            for (button, color) in zip(buttons, buttonColors) {
                button?.backgroundColor = color
                button?.isEnabled = true
            }
            clockLabel.textColor = .systemGray
            timerCounting = false
        }
    }
}
