import Foundation
import UIKit

extension FourTaskViewController {
    
    func canFirstButtonAnimatedStarted() {
        if !timerStarted.firstTimerStarted {
            firstButtonStartAnimation()
        }
    }
    
    func canFirstButtonAnimatedStopped() {
        if timerStarted.firstTimerStarted{
            firstButtonPauseAnimation()
        }
    }
    
    func firstButtonStartAnimation() {
        UIView.animate(withDuration: 0.3) { [self] in
            let buttonColors: [UIColor] = [.systemGray, .systemGray2, .systemGray3]
            let buttons = [secondButton, thirdButton, fourButton]
            for (button, color) in zip(buttons, buttonColors) {
                button?.backgroundColor = color
                button?.isEnabled = false
            }
            clockLabel.textColor = .systemYellow
            timerCounting = true
        }
    }
    
    func firstButtonPauseAnimation() {
        
        UIView.animate(withDuration: 0.3) { [self] in
            let buttonColors: [UIColor] = [.systemRed, .systemBlue, .systemGreen]
            let buttons = [secondButton, thirdButton, fourButton]
            for (button, color) in zip(buttons, buttonColors) {
                button?.backgroundColor = color
                button?.isEnabled = true
            }
            clockLabel.textColor = .systemGray
            timerCounting = false
        }
    }
}
