//
//  ViewController.swift
//  Four Task
//
//  Created by Ilya Vasilev on 12.07.2022.
//

import UIKit
import Foundation
import CountableLabel
//MARK: - ViewController
class ViewController: UIViewController {
//MARK: - IBOutlet
    ///Navigation bar buttons
    @IBOutlet weak var leftBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var rightBarButtonItem: UIBarButtonItem!
    ///IBOutlet Top View
    @IBOutlet weak var dayTimeLabel: UILabel!
    @IBOutlet weak var clockLabel: CountableLabel!
    @IBOutlet weak var firstTaskButton: UIButton!
    @IBOutlet weak var secondTaskButton: UIButton!
    @IBOutlet weak var thirdTaskButton: UIButton!
    @IBOutlet weak var fourTaskButton: UIButton!
    
    ///IBOutlet Leading View
    ///Неизменяемые лейблы нумерации
    @IBOutlet weak var ordinalFirstLabel: UILabel!
    @IBOutlet weak var ordinalSecondLabel: UILabel!
    @IBOutlet weak var ordinalThirdLabel: UILabel!
    @IBOutlet weak var fourOrdinalLabel: UILabel!
    ///Изменяемые лейблы таймера. (Анимированные) 
    @IBOutlet weak var taskNumberFirstLabel: CountableLabel!
    @IBOutlet weak var taskNumberSecondLabel: CountableLabel!
    @IBOutlet weak var taskNumbersThirdLabel: CountableLabel!
    @IBOutlet weak var taskNumbersFourLabel: CountableLabel!
    //MARK: - Let/var

    var optionalTimer: Timer?
    let format = DateFormatter()
    let now = NSDate()
    var count : Int = 0
 

    //MARK: - Lifecycle.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        clockLabel.text = "Lets work"
        ///Установка верхнего лейбла - времени текущего дня. (12 Часовая)
        makeCurrentTime()
        //MARK: - Save keys to UserDefaults.
        ///FIRST KEYS
        startTimeOne = userDefaults.object(forKey: STARTING_KEYS[0]) as? Date
        stopTimeOne = userDefaults.object(forKey: STOP_KEYS[0]) as? Date
        timerStarted.firstTimerStarted = userDefaults.bool(forKey: COUNTING_KEYS[0])
        ///SECOND KEYS
        startTimeSecond = userDefaults.object(forKey: STARTING_KEYS[1]) as? Date
        stopTimeSecond = userDefaults.object(forKey: STOP_KEYS[1]) as? Date
        timerStarted.secondTimerStarted = userDefaults.bool(forKey: COUNTING_KEYS[1])
        ///THIRD KEYS
        startTimeThird = userDefaults.object(forKey: STARTING_KEYS[2]) as? Date
        stopTimeThird = userDefaults.object(forKey: STOP_KEYS[2]) as? Date
        timerStarted.thirdTimerStarted = userDefaults.bool(forKey: COUNTING_KEYS[2])
        ///FOUR KEYS
        startTimeFour = userDefaults.object(forKey: STARTING_KEYS[3]) as? Date
        stopTimeFour = userDefaults.object(forKey: STOP_KEYS[3]) as? Date
        timerStarted.fourTimerStarted = userDefaults.bool(forKey: COUNTING_KEYS[3])
        
       ///Запуск 1 бэкграунд-таймера если он был нажат последним
        if timerStarted.firstTimerStarted {
            firstRefreshBackgroundTimer()
            animateFirstViewStart()
            print("1 бэкграунд таймер включился")
        } else {
            ///Запуск 2 бэкграунд-таймера если он был нажат последним
            if timerStarted.secondTimerStarted   {
                secondRefreshBackgroundTimer()
                animateSecondViewStart()
                print("2 бэкграунд таймер включился")
        } else {
            ///Запуск 3 бэкграунд-таймера если он был нажат последним
            if timerStarted.thirdTimerStarted {
                thirdRefreshBackgroundTimer()
                animateThirdViewStart()
                print("3 бэкграунд таймер включился")
        } else {
            ///Запуск 4 бэкграунд-таймера если он был нажат последним
            if timerStarted.fourTimerStarted  {
                fourRefreshBackgroundTimer()
                animateFourViewStart()
                print("4 бэкграунд таймер включился")
        }
            print("ERROR : Бэкграунд не сработал ")
            return
            
        }
        }
        }
    }
    
    //MARK: - IBOutlet methods
    ///Первая жёлтая кнопка
    @IBAction func firstTaskButtonPressed(_ sender: Any) {
        firstTask()
    }
    ///Вторая красная кнопка
    @IBAction func secondTaskButtonPressed(_ sender: Any) {
        secondTask()
    }
    ///Третья синяя кнопка
    @IBAction func thirdTaskButtonPressed(_ sender: UIButton) {
        thirdTask()
    }
    ///Четвёртая зеленая кнопка
    @IBAction func fourTaskButtonPressed(_ sender: UIButton) {
        fourTask()
    }
    
    @IBAction func refreshButtonPressed(_ sender: UIButton) {

let alert = UIAlertController(title: "Нотайс", message: "Как насчет обнуления?", preferredStyle: UIAlertController.Style.alert)

        // add the actions (buttons)
        ///Запуск 1 алерта с предложением обнулить 1 задачу.
         if timerStarted.firstTimerStarted {
             alert.addAction(UIAlertAction(title: "Обнулить первую задачу", style: UIAlertAction.Style.default, handler: { action in
                 self.resetActionOne()
                 self.animateFirstViewStop()

             }))
         } else {
             ///Запуск 2 алерта с предложением обнулить 2 задачу.
             if timerStarted.secondTimerStarted   {
                 alert.addAction(UIAlertAction(title: "Обнулить вторую задачу", style: UIAlertAction.Style.default, handler:  { action in
                     self.resetActionSecond()
                     self.animateSecondViewStop()
                 }))
         } else {
             //Запуск 3 алерта с предложением обнулить 3 задачу.
             if timerStarted.thirdTimerStarted {
                 alert.addAction(UIAlertAction(title: "Обнулить третью задачу", style: UIAlertAction.Style.default, handler: { action in
                     self.resetActionThird()
                     self.animateThirdViewStop()
                 }))
         } else {
             //Запуск 4 алерта с предложением обнулить 4 задачу.
             if timerStarted.fourTimerStarted  {
                 alert.addAction(UIAlertAction(title: "Обнулить четвертую задачу", style: UIAlertAction.Style.default, handler: { action in
                     self.resetActionFour()
                     self.animateFourViewStop()
         }))
             }
         }
         }
         }
    
         
         ///close alert
            alert.addAction(UIAlertAction(title: "Закрыть", style: UIAlertAction.Style.cancel, handler: nil))
    ///RESET ALL timers alert-action.
            alert.addAction(UIAlertAction(title: "Обнулить весь день", style: UIAlertAction.Style.destructive, handler: { action in
                self.resetActionOne()
                self.resetActionSecond()
                self.resetActionThird()
                self.resetActionFour()
                self.animateAll()
                 }))
    // show the alert
    self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Methods
    ///Animate ON ALL Buttons
           func animateAll() {
               UIView.animate(withDuration: 0.3) { [self] in
                firstTaskButton.backgroundColor = .systemYellow
               secondTaskButton.backgroundColor = .systemRed
                thirdTaskButton.backgroundColor = .systemBlue
               fourTaskButton.backgroundColor = .systemGreen
               firstTaskButton.isEnabled = true
               secondTaskButton.isEnabled = true
                thirdTaskButton.isEnabled = true
               fourTaskButton.isEnabled = true
               clockLabel.textColor = .black
                   (timerStarted.firstTimerStarted, timerStarted.secondTimerStarted, timerStarted.thirdTimerStarted, timerStarted.fourTimerStarted) = (false, false, false, false)
               timerCounting = false
            }
           }
}
///END
 

    
    

