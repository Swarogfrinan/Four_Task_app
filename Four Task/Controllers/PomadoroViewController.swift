//
//  PomadoroViewController.swift
//  
//
//  Created by Ilya Vasilev on 25.07.2022.
//

import UIKit
import AVFoundation
import CountableLabel

//MARK: - Enums
enum SetupAnimate {
    case stop
    case start
    case recycle
}

//MARK: - ResetAction
class PomadoroViewController: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var pomadoroLabel: CountableLabel!
    @IBOutlet weak var noticeLabel: UILabel!
    //MARK: - let/var
    var audioPlayer = AVAudioPlayer()
    let endOfTomatoSound: SystemSoundID = 1328
    var tomatoTimer = Timer()
    var time = 100
    //MARK: - lifecycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGreetingsLabel()
    }
    //MARK: - IBA Methods
    ///Нажатие кнопки
    @IBAction func actionButtonPressed(_ sender: UIButton) {
        ///Старт таймера
        if  timerStarted.tomatoTimerStarted == false {
            setupUi(for: .stop)
            startTimer()
            ///Стоп таймера
        } else if timerStarted.tomatoTimerStarted == true {
            setupUi(for: .start)
            stopTimer()
        }
    }
    //MARK: - Methods
    ///Функция запуска таймера
    private func startTimer() {
        tomatoTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        timerStarted.tomatoTimerStarted = true
    }
    ///Функция стоп-таймера
    private func stopTimer() {
        tomatoTimer.invalidate()
        timerStarted.tomatoTimerStarted = false
    }
    private func setupGreetingsLabel() {
        pomadoroLabel.text = "Lets go studing"
    }
    
    func formatTime() -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
    func playAlarmSound() {
        AudioServicesPlaySystemSound(endOfTomatoSound)
        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
    }
    
    func setupUi(for animate: SetupAnimate) {
        switch animate {
        case .stop:
            UIView.animate(withDuration: 0.3) { [self] in
                startButton.setImage(UIImage(systemName: "stop.fill"), for: .normal)
                startButton.setTitle("Стоп", for: .normal)
                noticeLabel.text = "тик-так-так-тик"
                startButton.tintColor = .systemRed
                noticeLabel.textColor = .systemRed
            }
            
        case .start:
            UIView.animate(withDuration: 0.3) { [self] in
                startButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
                startButton.setTitle("Старт", for: .normal)
                noticeLabel.text = "Усерден твой путь!"
                startButton.tintColor = .systemBlue
                noticeLabel.textColor = .systemBlue
            }
        case .recycle:
            UIView.animate(withDuration: 0.3) { [self] in
                startButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
                startButton.setTitle("Отдых!", for: .normal)
                
                startButton.tintColor = .systemGreen
                noticeLabel.textColor = .systemGreen
            }
        }
    }
    ///Ежесекундный счётчик Update Таймера.
    @objc func updateTimer() {
        if time > 0 {
            time -= 1
            pomadoroLabel.text = formatTime()
        }  else if time == 0 && timerStarted.tomatoRestTimerStarted == false {
            playAlarmSound()
            print("Таймер отдыха")
            setupUi(for: .recycle)
            time = 30
            timerStarted.tomatoRestTimerStarted = true
            pomadoroLabel.text = "5:00"
            noticeLabel.text = "Повод сделать зарядку!"
            stopTimer()
        } else if time == 0 && timerStarted.tomatoRestTimerStarted == true {
            timerStarted.tomatoRestTimerStarted = false
            stopTimer()
            print("Таймер старта после таймера отдыха")
            setupUi(for: .start)
            time = 200
            pomadoroLabel.text = "25:00"
        }
    }
    ///end
}

