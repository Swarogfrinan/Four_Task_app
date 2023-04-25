import UIKit
import CountableLabel

class FourTaskViewController: UIViewController, ButtonDelegateProtocol {
    func setupTimeString(didChangeTitle timeString: String) {
        <#code#>
    }
    
    func changeColor(didChangeColor color: UIColor) {
        <#code#>
    }
    
    
    //MARK: - IBOutlets
    @IBOutlet var buttonCollection: [UIButton]!
    
    @IBOutlet weak var leftBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var rightBarButtonItem: UIBarButtonItem!
    
    @IBOutlet weak var dayTimeLabel: UILabel!
    @IBOutlet weak var clockLabel: CountableLabel!
    
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var thirdButton: UIButton!
    @IBOutlet weak var fourButton: UIButton!
    
    @IBOutlet weak var ordinalFirstLabel: UILabel!
    @IBOutlet weak var ordinalSecondLabel: UILabel!
    @IBOutlet weak var ordinalThirdLabel: UILabel!
    @IBOutlet weak var ordinalFourLabel: UILabel!
    
    @IBOutlet weak var taskNumberFirstLabel: CountableLabel!
    @IBOutlet weak var taskNumberSecondLabel: CountableLabel!
    @IBOutlet weak var taskNumbersThirdLabel: CountableLabel!
    @IBOutlet weak var taskNumbersFourLabel: CountableLabel!
    
    
    let userDefaults = UserDefaults.standard
    let firstButtonLogic = FirstButton()
    let secondButtonLogic = SecondButton()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegates()
        setupLabel()
        makeCurrentTime()
        loadTimerFromUserDefaults()
    }
    
    //MARK: - IBOutlet methods
    func setupDelegates() {
        firstButtonLogic.buttonDelegate = self
        firstButtonLogic.animationDelegate = self
    }
    
    @IBAction func firstTaskButtonPressed(_ sender: UIButton) {
        sender.tapScale(sender: sender)
        firstButtonLogic.fullLauchTimer()
    }
    
    @IBAction func secondTaskButtonPressed(_ sender: UIButton) {
        sender.tapScale(sender: sender)
        secondButtonLogic.fullLauchTimer()
//        secondTask()
    }
    
    @IBAction func thirdTaskButtonPressed(_ sender: UIButton) {
        sender.tapScale(sender: sender)
        thirdTask()
    }
    
    @IBAction func fourTaskButtonPressed(_ sender: UIButton) {
        sender.tapScale(sender: sender)
        fourTask()
    }
    
    @IBAction func refreshButtonPressed(_ sender: UIButton) {
        sender.tapScale(sender: sender)
        setupRefreshAlert()
    }
}
private extension FourTaskViewController {
    
    func loadTimerFromUserDefaults() {
        firstButtonLogic.firstLoadFromUserDefaults()
        secondButtonLogic.secondLoadFromUserDefaults()
        thirdLoadFromUserDefaults()
        fourLoadFromUserDefaults()
    }
    
//    func secondLoadFromUserDefaults() {
//        startedDateSecond = userDefaults.object(forKey: SecondKeys.start.rawValue) as? Date
//        stoppedDateSecond = userDefaults.object(forKey: SecondKeys.stop.rawValue) as? Date
//        timerStarted.secondTimerStarted = userDefaults.bool(forKey: SecondKeys.counting.rawValue)
//        if timerStarted.secondTimerStarted   {
//            secondRefreshBackgroundTimer()
//            secondButtonStartedAnimation()
//            print("2 бэкграунд таймер включился")
//        } else {
//            print("ERROR : 2 Бэкграунд не сработал ")
//        }
//    }
    func thirdLoadFromUserDefaults() {
        startTimeThird = userDefaults.object(forKey: ThirdKeys.start.rawValue) as? Date
        stopTimeThird = userDefaults.object(forKey: ThirdKeys.stop.rawValue) as? Date
        timerStarted.thirdTimerStarted = userDefaults.bool(forKey: ThirdKeys.counting.rawValue)
        if timerStarted.thirdTimerStarted {
            thirdRefreshBackgroundTimer()
            thirdButtonStartAnimation()
            print("3 бэкграунд таймер включился")
        } else {
            print("ERROR : 3 Бэкграунд не сработал ")
        }
    }
    func fourLoadFromUserDefaults() {
        startTimeFour = userDefaults.object(forKey: FourKeys.start.rawValue) as? Date
        stopTimeFour = userDefaults.object(forKey: FourKeys.stop.rawValue) as? Date
        timerStarted.fourTimerStarted = userDefaults.bool(forKey: FourKeys.counting.rawValue)
        ///Запуск 4 бэкграунд-таймера если он был нажат последним
        if timerStarted.fourTimerStarted  {
            fourRefreshBackgroundTimer()
            fourButtonStartedAnimation()
            print("4 бэкграунд таймер включился")
        } else {
            print("ERROR : 4 Бэкграунд не сработал ")
        }
    }
}


//MARK: - Extension + FourTaskViewController
extension FourTaskViewController {
    public func makeCurrentTime() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (_) in
            let date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "hh:MM:ss"
            let currentTime = dateFormatter.string(from: date)
            self.dayTimeLabel.text = currentTime
        })
    }
    func animateAllButtons() {
        UIView.animate(withDuration: 0.3) { [self] in
            firstButton.backgroundColor = .systemYellow
            secondButton.backgroundColor = .systemRed
            thirdButton.backgroundColor = .systemBlue
            fourButton.backgroundColor = .systemGreen
            firstButton.isEnabled = true
            secondButton.isEnabled = true
            thirdButton.isEnabled = true
            fourButton.isEnabled = true
            clockLabel.textColor = .black
            
            (timerStarted.firstTimerStarted, timerStarted.secondTimerStarted, timerStarted.thirdTimerStarted, timerStarted.fourTimerStarted) = (false, false, false, false)
            timerCounting = false
        }
    }
    func setupLabel() {
        clockLabel.text = Constants.greetings
    }
    
    func setupDefaultLabel(timeString : String) {
        if timeString != "" {
            clockLabel.text = timeString
            taskNumberFirstLabel.text = timeString
            taskNumberFirstLabel.textColor = .systemYellow
        }
    }
    func setupRefreshAlert() {
        let alert = UIAlertController(title: Constants.Alert.cancelTitle, message: Constants.Alert.alertMessage, preferredStyle: UIAlertController.Style.alert)
        if timerStarted.firstTimerStarted {
            alert.addAction(UIAlertAction(title: Constants.Alert.firstTask, style: UIAlertAction.Style.default, handler: { action in
                self.firstButtonLogic.resetActionToDefault()
//                self.buttonPauseAnimation()
                self.firstButtonLogic.animationDelegate?.buttonPauseAnimation()
            }))
        } else {
            if timerStarted.secondTimerStarted   {
                alert.addAction(UIAlertAction(title: Constants.Alert.secondTask , style: UIAlertAction.Style.default, handler:  { action in
                    self.secondButtonLogic.resetActionToDefault()
                    self.secondButtonLogic.animationDelegate?.buttonPauseAnimation()
//                    self.secondButtonPauseAnimation()
                }))
            } else {
                if timerStarted.thirdTimerStarted {
                    alert.addAction(UIAlertAction(title:Constants.Alert.thirdTask , style: UIAlertAction.Style.default, handler: { action in
                        self.resetActionThird()
                        self.thirdButtonPauseAnimation()
                    }))
                } else {
                    if timerStarted.fourTimerStarted  {
                        alert.addAction(UIAlertAction(title: Constants.Alert.fourTask, style: UIAlertAction.Style.default, handler: { action in
                            self.resetActionFour()
                            self.fourButtonPauseAnimation()
                        }))
                    }
                }
            }
        }
        alert.addAction(UIAlertAction(title: Constants.Alert.cancelTitle, style: UIAlertAction.Style.cancel, handler: nil))
        alert.addAction(UIAlertAction(title: Constants.Alert.resetAllDay, style: UIAlertAction.Style.destructive, handler: { action in
            self.firstButtonLogic.resetActionToDefault()
            self.secondButtonLogic.resetActionToDefault()
//            self.resetActionSecond()
            self.resetActionThird()
            self.resetActionFour()
            self.animateAllButtons()
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
//MARK: - Constants
private extension Constants {
    static let greetings = "Lets work!"
    struct Alert {
        static let cancelTitle = "Отмена"
        static let resetAllDay = "Весь день"
        static let alertReset = "Сброс задачи"
        static let alertMessage = "Какую задачу вы хотите сбросить?"
        static let firstTask = "Первую задачу"
        static let secondTask = "Вторую задачу"
        static let thirdTask = "Третью задачу"
        static let fourTask = "Четвертую задачу"
        
    }
}




