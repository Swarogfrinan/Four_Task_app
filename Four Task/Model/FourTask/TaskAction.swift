import Foundation
import UIKit


//MARK: - First Case
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
//MARK: - Second Case
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

//MARK: - Third Case
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

//MARK: - Four Case
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

