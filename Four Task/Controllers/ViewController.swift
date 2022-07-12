//
//  ViewController.swift
//  Four Task
//
//  Created by Ilya Vasilev on 12.07.2022.
//

import UIKit
import Foundation

public enum targetTask {
    case firstCase
    case secondCase
    case thirdCase
    case fourCase
}

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
    
    //MARK: - Let/var
    var timer = Timer()
    let format = DateFormatter()
    let now = NSDate()
    var count : Int = 0
    var timerCounting : Bool = false

    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        clockLabel.text = "00:00"
    
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
    
    @objc func timerCounter() -> Void {
        count = count + 1
    }
//    func secondToHourMinutesSeconds(seconds: Int) -> (Int, Int, Int) {
//      return ((seconds / 3600), (seconds % 3600) / 60, (seconds % 3600) % 60))
//    }
    
    @objc func updateTimer() {
        if (count > 0) {
            let minutes = String(count / 60)
            let seconds = String(count % 60)
            clockLabel.text = minutes + ":" + seconds
            
        }
    }
}








    extension ViewController {
        func firstTask() {
        if (timerCounting) {
            timerCounting = false
            timer.invalidate()
                UIView.animate(withDuration: 0.3) { [self] in
            secondTaskButton.backgroundColor = .systemRed
            thirdTaskButton.backgroundColor = .systemBlue
            fourTaskButton.backgroundColor = .systemGreen
            secondTaskButton.isEnabled = true
            thirdTaskButton.isEnabled = true
            fourTaskButton.isEnabled = true
            clockLabel.text = "Stop"
            }
            } else {
        timerCounting = true
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        UIView.animate(withDuration: 0.3) { [self] in
        secondTaskButton.backgroundColor = .systemGray
        thirdTaskButton.backgroundColor = .systemGray2
        fourTaskButton.backgroundColor = .systemGray3
            secondTaskButton.isEnabled = false
            thirdTaskButton.isEnabled = false
            fourTaskButton.isEnabled = false
            clockLabel.text = "Start"
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
            clockLabel.text = "Stop"
            }
        } else {
        timerCounting = true
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
               UIView.animate(withDuration: 0.3) { [self] in
        firstTaskButton.backgroundColor = .systemGray
        thirdTaskButton.backgroundColor = .systemGray2
        fourTaskButton.backgroundColor = .systemGray3
                   firstTaskButton.isEnabled = false
                   thirdTaskButton.isEnabled = false
                   fourTaskButton.isEnabled = false
             clockLabel.text = "Start"
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
            clockLabel.text = "Stop"
            }
        } else {
        timerCounting = true
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
               UIView.animate(withDuration: 0.3) { [self] in
        firstTaskButton.backgroundColor = .systemGray
        secondTaskButton.backgroundColor = .systemGray2
        fourTaskButton.backgroundColor = .systemGray3
                   firstTaskButton.isEnabled = false
                   secondTaskButton.isEnabled = false
                   fourTaskButton.isEnabled = false
             clockLabel.text = "Start"
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
                
            clockLabel.text = "Stop"
            }
            
        } else {
        timerCounting = true
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
               UIView.animate(withDuration: 0.3) { [self] in
        firstTaskButton.backgroundColor = .systemGray
        secondTaskButton.backgroundColor = .systemGray2
        thirdTaskButton.backgroundColor = .systemGray3
        firstTaskButton.isEnabled = false
        secondTaskButton.isEnabled = false
        thirdTaskButton.isEnabled = false
             clockLabel.text = "Start"
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
