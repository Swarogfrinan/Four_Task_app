//
//  ViewController.swift
//  Four Task
//
//  Created by Ilya Vasilev on 12.07.2022.
//

import UIKit
import Foundation



class ViewController: UIViewController {
//MARK: - IBOutlet
    ///Navigation bar
    @IBOutlet weak var leftBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var rightBarButtonItem: UIBarButtonItem!
    ///IBOutlet View
    @IBOutlet weak var clockLabel: UILabel!
    @IBOutlet weak var firstTaskButton: UIButton!
    @IBOutlet weak var secondTaskButton: UIButton!
    @IBOutlet weak var thirdTaskButton: UIButton!
    @IBOutlet weak var fourTaskButton: UIButton!
    
    @IBOutlet var buttonCollections: [UIButton]!
    
    @IBOutlet weak var dayTimeLabel: UILabel!
    @IBOutlet weak var firstExtraLabel: UILabel!
    @IBOutlet weak var secondExtraLabel: UILabel!
    @IBOutlet weak var thirdExtraLabel: UILabel!
    @IBOutlet weak var fourExtraLabel: UILabel!
    
    //MARK: - Let/var
    var timer = Timer()
    var optionalTimer:  Timer?
    let format = DateFormatter()
    let now = NSDate()
    var count : Int = 0
    var timerCounting : Bool = false

    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        clockLabel.text = "Lets work"
        dayTimeLabel.text = now.description
    }

    
    //MARK: - IBOutlet methods
    @IBAction func firstTaskButtonPressed(_ sender: UIButton) {
       firstTask()
    }
    
    @IBAction func secondTakeButtonPressed(_ sender: UIButton) {
        secondTask()
    }
    
    @IBAction func thirdTaskButtonPressed(_ sender: UIButton) {
        thirdTask()
    }
    
    @IBAction func fourTaskButtonPressed(_ sender: UIButton) {
        fourTask()
    }
    
    //MARK: - Methods
    ///Счётчик таймера
    @objc func timerCounter() -> Void {
        count = count + 1
        let time = secondToHourMinutesSeconds(seconds: count)
        let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
        clockLabel.text = timeString
    }
    ///Перевод секунд в час, минуту, секунду.
    func secondToHourMinutesSeconds(seconds: Int) -> (Int, Int, Int) {
        return ((seconds / 3600), (seconds % 3600) / 60, ((seconds % 3600) % 60))
    }
    /// Перевод численных значений в формат String
    func makeTimeString(hours: Int, minutes: Int, seconds: Int) -> String {
        var timeString = ""
        timeString += String(format: "%02d", hours)
        timeString += ":"
        timeString += String(format: "%02d", minutes)
        timeString += ":"
        timeString += String(format: "%02d", seconds)
        return timeString
    }
    
    func createTimer() {
      if optionalTimer == nil {
        let timer = Timer(timeInterval: 1.0,
          target: self,
          selector: #selector(timerCounter),
          userInfo: nil,
          repeats: true)
        RunLoop.current.add(timer, forMode: .common)
        timer.tolerance = 0.1
        
        self.optionalTimer = timer
      }
    }
    
    func cancelTimer() {
      optionalTimer?.invalidate()
      optionalTimer = nil
    }
    }









    extension ViewController {
        func firstTask() {
        if (timerCounting) {
            timerCounting = false
            cancelTimer()
                UIView.animate(withDuration: 0.3) { [self] in
            secondTaskButton.backgroundColor = .systemRed
            thirdTaskButton.backgroundColor = .systemBlue
            fourTaskButton.backgroundColor = .systemGreen
            secondTaskButton.isEnabled = true
            thirdTaskButton.isEnabled = true
            fourTaskButton.isEnabled = true
            
            }
            } else {
        timerCounting = true
//        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(createTimer), userInfo: nil, repeats: true)
                createTimer()
        UIView.animate(withDuration: 0.3) { [self] in
        secondTaskButton.backgroundColor = .systemGray
        thirdTaskButton.backgroundColor = .systemGray2
        fourTaskButton.backgroundColor = .systemGray3
            secondTaskButton.isEnabled = false
            thirdTaskButton.isEnabled = false
            fourTaskButton.isEnabled = false
        
         }
        }
        }
        
        func secondTask() {
        if (timerCounting) {
            timerCounting = false
            timer.invalidate()
            UIView.animate(withDuration: 0.3) { [self] in
            firstTaskButton.backgroundColor = .systemYellow
            thirdTaskButton.backgroundColor = .systemBlue
            fourTaskButton.backgroundColor = .systemGreen
                firstTaskButton.isEnabled = true
                thirdTaskButton.isEnabled = true
                fourTaskButton.isEnabled = true
            
            }
        } else {
        timerCounting = true
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
               UIView.animate(withDuration: 0.3) { [self] in
        firstTaskButton.backgroundColor = .systemGray
        thirdTaskButton.backgroundColor = .systemGray2
        fourTaskButton.backgroundColor = .systemGray3
                   firstTaskButton.isEnabled = false
                   thirdTaskButton.isEnabled = false
                   fourTaskButton.isEnabled = false
         
         }
        }
        }
        func thirdTask() {
        if (timerCounting) {
            timerCounting = false
            timer.invalidate()
            UIView.animate(withDuration: 0.3) { [self] in
            secondTaskButton.backgroundColor = .systemRed
            firstTaskButton.backgroundColor = .systemYellow
            fourTaskButton.backgroundColor = .systemGreen
                firstTaskButton.isEnabled = true
                secondTaskButton.isEnabled = true
                fourTaskButton.isEnabled = true
           
            }
        } else {
        timerCounting = true
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
               UIView.animate(withDuration: 0.3) { [self] in
        firstTaskButton.backgroundColor = .systemGray
        secondTaskButton.backgroundColor = .systemGray2
        fourTaskButton.backgroundColor = .systemGray3
                   firstTaskButton.isEnabled = false
                   secondTaskButton.isEnabled = false
                   fourTaskButton.isEnabled = false
         
         }
        }
        }
        func fourTask() {
        if (timerCounting) {
            timerCounting = false
            timer.invalidate()
            UIView.animate(withDuration: 0.3) { [self] in
            firstTaskButton.backgroundColor = .systemYellow
            secondTaskButton.backgroundColor = .systemRed
            thirdTaskButton.backgroundColor = .systemBlue
            firstTaskButton.isEnabled = true
            secondTaskButton.isEnabled = true
            thirdTaskButton.isEnabled = true
            
            }
            
        } else {
        timerCounting = true
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
               UIView.animate(withDuration: 0.3) { [self] in
        firstTaskButton.backgroundColor = .systemGray
        secondTaskButton.backgroundColor = .systemGray2
        thirdTaskButton.backgroundColor = .systemGray3
        firstTaskButton.isEnabled = false
        secondTaskButton.isEnabled = false
        thirdTaskButton.isEnabled = false
    
         }
        }
        }
        
    }
    
    
//
//    switch targetTask {
//
//case .firstCase:
//
//case .secondCase:
//
//case .thirdCase:
//
//case .fourCase:
//
//default:
//    break
//}
//
//}
//
