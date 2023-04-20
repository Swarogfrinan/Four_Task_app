import Foundation
import UIKit

protocol ButtonDelegateProtocol : AnyObject {
     func setupTimeString(didChangeTitle timeString: String)
     func changeColor(didChangeColor color: UIColor)
}

protocol AnimationProtocol {
    func canButtonHaveAnimatedStart()
    func canButtonHaveAnimatedStop()
    func buttonStartAnimation()
    func buttonPauseAnimation()
}

//MARK: - First Case
extension FourTaskViewController: AnimationProtocol, ButtonDelegateProtocol {
    
    func setupTimeString(didChangeTitle timeString: String) {
        clockLabel.text = timeString
        taskNumberFirstLabel.text = timeString
    }     
    
    func changeColor(didChangeColor color: UIColor) {
        taskNumberFirstLabel.textColor = color
    }
    
    
    func canButtonHaveAnimatedStart() {
        if !timerStarted.firstTimerStarted {
            buttonStartAnimation()
        }
    }
    
    func canButtonHaveAnimatedStop() {
        if timerStarted.firstTimerStarted{
            buttonPauseAnimation()
        }
    }
    
    func buttonStartAnimation() {
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
    
    func buttonPauseAnimation() {
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
