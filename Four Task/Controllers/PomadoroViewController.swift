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
///Кейсы анимаций кнопки "Старт"
enum SetupAnimate {
    case stop
    case start
    case relax
}
var focusCount = 0
var relaxCount = 0
//MARK: - PomadoroViewController
class PomadoroViewController: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var pomadoroLabel: CountableLabel!
    @IBOutlet weak var pomadoroSettingsButton: UIButton!
    @IBOutlet weak var noticeLabel: UILabel!
    @IBOutlet weak var pomadoroImage: UIImageView!
    
    //MARK: - let/var
    let endOfTomatoSound: SystemSoundID = 1328
    let concetrationTime = 1500
    let relaxTime = 300
    
    var audioPlayer = AVAudioPlayer()
    var tomatoTimer = Timer()
    var defaultTime = 1500
    //Notification after timers work.
    var notificationManager = NotificationManager()
    
    //MARK: - lifecycle viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        notificationManager.checkAuthorizationNotification()
    }
    //MARK: - lifecycle ViewDidDisappear
    override func viewDidDisappear(_ animated: Bool) {
        stopTimer()
        print("Pomadoro timer уничтожен так как VC закрылся.")
    }
    //MARK: - lifecycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGreetingsLabel()
    }
    //MARK: - IBA Methods
    ///Нажатие кнопки старта
    @IBAction func actionButtonPressed(_ sender: UIButton) {
        ///Старт таймера
        if  !timerStarted.tomatoTimerStarted  {
            setupUi(for: .stop)
            startTimer()
            ///Стоп таймера
        } else if timerStarted.tomatoTimerStarted {
            setupUi(for: .start)
            stopTimer()
        }
    }
    ///Нажатие картинки Помидора после чего появляется half-screen с настройками.
    @IBAction func pomadoroButtonPressed(_ sender: UIButton) {
        let controller = PomadoroSettingsViewController()
        controller.modalPresentationStyle = .overCurrentContext
        self.present(controller, animated: false)
        
    }
    //MARK: - Methods
    ///Функция запуска таймера
    private func startTimer() {
        tomatoTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        timerStarted.tomatoTimerStarted = true
    }
    ///Функция стоп-таймера
    private func stopTimer() {
        tomatoTimer.invalidate()
        timerStarted.tomatoTimerStarted = false
    }
    ///Приветственный лейбл-заглушка
    private func setupGreetingsLabel() {
        pomadoroLabel.text = "Lets go studing"
    }
    ///Форматирование времени
    public func formatTime() -> String {
        let minutes = Int(defaultTime) / 60 % 60
        let seconds = Int(defaultTime) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
    ///Проигрывание звука Alarm и вибрации после завершения 25 минутного периода.
    func playAlarmSound() {
        AudioServicesPlaySystemSound(endOfTomatoSound)
        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
    }

    ///Установка UI кнопки "Старт".
    func setupUi(for animate: SetupAnimate) {
        switch animate {
            ///Надписи красные, время паузы.
        case .stop:
            UIView.animate(withDuration: 0.3) { [self] in
                startButton.setImage(UIImage(systemName: "stop.fill"), for: .normal)
                startButton.setTitle("Стоп", for: .normal)
                noticeLabel.text = "тик-так-так-тик"
                startButton.tintColor = .systemRed
                noticeLabel.textColor = .systemRed
            }
            ///Надписи синие, время фокуса.
        case .start:
            UIView.animate(withDuration: 0.3) { [self] in
                startButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
                startButton.setTitle("Старт", for: .normal)
                noticeLabel.text = "Усерден твой путь!"
                startButton.tintColor = .systemBlue
                noticeLabel.textColor = .systemBlue
            }
        ///Надписи зеленые, время отдыха.
        case .relax:
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
        if defaultTime > 0 {
            defaultTime -= 1
            pomadoroLabel.text = formatTime()
        }  else if defaultTime == 0 && !timerStarted.tomatoRestTimerStarted  {
            focusCount += 1
            playAlarmSound()
            print("Таймер отдыха сработал")
            setupUi(for: .relax)
            defaultTime = relaxTime
            timerStarted.tomatoRestTimerStarted = true
            pomadoroLabel.text = "5:00"
            noticeLabel.text = "Повод сделать зарядку!"
            
            stopTimer()
        } else if defaultTime == 0 && timerStarted.tomatoRestTimerStarted  {
            relaxCount += 1
            timerStarted.tomatoRestTimerStarted = false
            stopTimer()
            print("Таймер концентрации после таймера отдыха")
            setupUi(for: .start)
            defaultTime = concetrationTime
            pomadoroLabel.text = "25:00"
        }
    }
    ///end
}

