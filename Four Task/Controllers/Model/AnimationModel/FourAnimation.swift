import Foundation
import UIKit

extension FourTaskViewController {
    
    func canFourButtonAnimatedStarted() {
        if !timerStarted.fourTimerStarted {
            fourButtonStartedAnimation()
        }
    }
    
    func canFourButtonAnimatedStopped() {
        if timerStarted.fourTimerStarted {
            fourButtonPauseAnimation()
        }
    }
    
    func fourButtonStartedAnimation() {
        UIView.animate(withDuration: 0.3) { [self] in
            let buttonColors: [UIColor] = [.systemGray, .systemGray2, .systemGray3]
            let buttons = [firstButton, secondButton, thirdButton]
            for (button, color) in zip(buttons, buttonColors) {
                button?.backgroundColor = color
                button?.isEnabled = true
            }
            clockLabel.textColor = .systemGreen
            timerCounting = true
        }
    }
    
    func fourButtonPauseAnimation() {
        UIView.animate(withDuration: 0.3) {
            [self] in
            let buttonColors: [UIColor] = [.systemYellow, .systemRed, .systemBlue]
            let buttons = [firstButton, secondButton, thirdButton]
            for (button, color) in zip(buttons, buttonColors) {
                button?.backgroundColor = color
                button?.isEnabled = true
            }
            clockLabel.textColor = .systemGray
            timerCounting = false
        }
    }
}
