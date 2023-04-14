import Foundation
import UIKit


//MARK: - First Case
extension FourTaskViewController {
    
    func canFirstButtonAnimatedStarted() {
        if !timerStarted.firstTimerStarted {
            print("StoptimeOne не равен Nil.")
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
            print("Выполнение анимации первого сценария, второй кейс (старт)")
            secondButton.backgroundColor = .systemGray
            thirdButton.backgroundColor = .systemGray2
            fourButton.backgroundColor = .systemGray3
            
            for button in [secondButton, thirdButton, fourButton] {
                button?.isEnabled = false
            }
            clockLabel.textColor = .systemYellow
            timerCounting = true
        }
    }
    
    func firstButtonPauseAnimation() {
        print("Сработала проверка по timerStarted")
        print("Старт акшен ван. Таймер-стартед переведен в TRUE")
        UIView.animate(withDuration: 0.3) { [self] in
            print("Пошло выполнение анимации первого сценария, первый кейс (стоп)")
            secondButton.backgroundColor = .systemRed
            thirdButton.backgroundColor = .systemBlue
            fourButton.backgroundColor = .systemGreen
            
            for button in [secondButton, thirdButton, fourButton] {
                button?.isEnabled = true
            }
            clockLabel.textColor = .systemGray
            timerCounting = false
            print("Все кнопки включены. Текст перекрашен в серый.")
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
            firstButton.backgroundColor = .systemGray
            thirdButton.backgroundColor = .systemGray2
            fourButton.backgroundColor = .systemGray3
            
            for button in [firstButton, thirdButton, fourButton] {
                button?.isEnabled = false
            }
            clockLabel.textColor = .systemRed
            timerCounting = true
        }
    }
    
    func secondButtonPauseAnimation() {
        UIView.animate(withDuration: 0.3) { [self] in
            firstButton.backgroundColor = .systemYellow
            thirdButton.backgroundColor = .systemBlue
            fourButton.backgroundColor = .systemGreen
            
            for button in [firstButton, thirdButton, fourButton] {
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
            firstButton.backgroundColor = .systemGray
            secondButton.backgroundColor = .systemGray2
            fourButton.backgroundColor = .systemGray3
            
            for button in [firstButton, secondButton, fourButton] {
                button?.isEnabled = false
            }
            clockLabel.textColor = .systemBlue
            timerCounting = true
        }
    }
    
    func thirdButtonPauseAnimation() {
        UIView.animate(withDuration: 0.3) { [self] in
            secondButton.backgroundColor = .systemRed
            firstButton.backgroundColor = .systemYellow
            fourButton.backgroundColor = .systemGreen
            
            for button in [firstButton, secondButton, fourButton] {
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
            firstButton.backgroundColor = .systemGray
            secondButton.backgroundColor = .systemGray2
            thirdButton.backgroundColor = .systemGray3
            
            for button in [firstButton, secondButton, thirdButton] {
                button?.isEnabled = false
            }
            clockLabel.textColor = .systemGreen
            timerCounting = true
        }
    }
    
    func fourButtonPauseAnimation() {
        UIView.animate(withDuration: 0.3) { [self] in
            firstButton.backgroundColor = .systemYellow
            secondButton.backgroundColor = .systemRed
            thirdButton.backgroundColor = .systemBlue
            
            for button in [firstButton, secondButton, thirdButton] {
                button?.isEnabled = true
            }
            clockLabel.textColor = .systemGray
            timerCounting = false
        }
        
    }
}

