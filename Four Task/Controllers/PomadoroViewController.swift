import UIKit
import AVFoundation
import CountableLabel

class PomadoroViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var pomadoroLabel: CountableLabel!
    @IBOutlet weak var pomadoroSettingsButton: UIButton!
    @IBOutlet weak var noticeLabel: UILabel!
    @IBOutlet weak var pomadoroImage: UIImageView!
    
    //MARK: - Properties
    private var audioPlayer = AVAudioPlayer()
    private var tomatoTimer = Timer()
    private  let count = Count()
    private var notificationManager = NotificationManager()
    
    private let endOfTomatoSound = SystemSoundID(Constants.Pomadoro.tomatoSoundID)
    private  var defaultTime = Constants.Pomadoro.defaultDuration
    private  let relaxTime = Constants.Pomadoro.durationRelax

    //MARK: - ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        notificationManager.checkAuthorizationNotification()
    }
    
    //MARK: - ViewDidDisappear
    override func viewDidDisappear(_ animated: Bool) {
        stopTimer()
        print(Constants.Pomadoro.dissappearMessage)
    }
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDefaultGreetingsLabel()
    }
    
    //MARK: - IBAction Methods
    @IBAction func actionButtonPressed(_ sender: UIButton) {
        if  !timerStarted.tomatoTimerStarted  {
            setupUi(for: .stop)
            startTimer()
        } else if timerStarted.tomatoTimerStarted {
            setupUi(for: .start)
            stopTimer()
        }
    }
    
    @IBAction func pomadoroButtonPressed(_ sender: UIButton) {
        let controller = PomadoroSettingsViewController()
        controller.modalPresentationStyle = .overCurrentContext
        self.present(controller, animated: false)
    }
}

private extension PomadoroViewController {
    //MARK: - Private methods
     func startTimer() {
         tomatoTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        timerStarted.tomatoTimerStarted = true
    }
    
    func stopTimer() {
        tomatoTimer.invalidate()
        timerStarted.tomatoTimerStarted = false
    }
    
    private func formatTime() -> String {
        let minutes = Int(defaultTime) / .minute % .minute
        let seconds = Int(defaultTime) % .minute
        return String(format:"%02i:%02i", minutes, seconds)
    }
    
   func setupDefaultGreetingsLabel() {
        pomadoroLabel.text = Constants.Pomadoro.defaultTitle
    }
   
     func playAlarmSound() {
        AudioServicesPlaySystemSound(endOfTomatoSound)
        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
    }
    func setupUi(for animate: startedKeys) {
        switch animate {
        case .stop:
            UIView.animate(withDuration: 0.3) { [self] in
                startButton.setImage(UIImage(systemName: "stop.fill"), for: .normal)
                startButton.setTitle(Constants.Titles.ButtonTitles.stopLabel, for: .normal)
                noticeLabel.text = Constants.Titles.countingLabel
                startButton.tintColor = .systemRed
                noticeLabel.textColor = .systemRed
            }
        case .start:
            UIView.animate(withDuration: 0.3) { [self] in
                startButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
                startButton.setTitle(Constants.Titles.ButtonTitles.startLabel, for: .normal)
                noticeLabel.text = Constants.Titles.motivationLabel
                startButton.tintColor = .systemBlue
                noticeLabel.textColor = .systemBlue
            }
        case .relax:
            UIView.animate(withDuration: 0.3) { [self] in
                startButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
                startButton.setTitle(Constants.Titles.relaxLabel, for: .normal)
                
                startButton.tintColor = .systemGreen
                noticeLabel.textColor = .systemGreen
            }
        }
    }
    @objc func updateTimer() {
        if defaultTime > .zero {
            defaultTime -= .sec
            pomadoroLabel.text = formatTime()
        }  else if defaultTime == .zero && !timerStarted.tomatoRestTimerStarted  {
            count.focusCount += .sec
            playAlarmSound()
            print("Таймер отдыха сработал")
            setupUi(for: .relax)
            defaultTime = relaxTime
            timerStarted.tomatoRestTimerStarted = true
            pomadoroLabel.text = Constants.Titles.defaultRelaxLabel
            noticeLabel.text = Constants.Titles.callToRelaxLabel
            
            stopTimer()
        } else if defaultTime == .zero && timerStarted.tomatoRestTimerStarted  {
            count.relaxCount += .sec
            timerStarted.tomatoRestTimerStarted = false
            stopTimer()
            print("Таймер концентрации после таймера отдыха")
            setupUi(for: .start)
            defaultTime = Constants.Pomadoro.defaultDuration
            pomadoroLabel.text = Constants.Titles.defaultConcetrationLabel
        }
    }
}


private extension Constants {
    struct Pomadoro {
        static let tomatoSoundID = 1328
        static let defaultDuration = 1500
        static let durationRelax = 300
        static let dissappearMessage = "Pomodoro timer disappear"
        static let defaultTitle = "Lets go studing"
    }
    
    struct Titles {
        static let callToRelaxLabel = "Повод сделать зарядку!"
        static let defaultRelaxLabel = "5:00"
        static let defaultConcetrationLabel = "25:00"
        static let relaxLabel = "Отдых!"
        static let motivationLabel = "Усерден твой путь!"
        static let countingLabel = "тик-так-так-тик"
        
        struct ButtonTitles {
            static let stopLabel = "Стоп!"
            static let startLabel = "Старт!"
        }
    }
}
