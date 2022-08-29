//
//  TimerController.swift
//  PPL
//
//  Created by Chris Boshoff on 2022/08/29.
//

import UIKit

class TimerController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var startTimeTitle: UIButton!
    @IBOutlet weak var timerLabel    : UILabel!
    
    
    // MARK: - Initializers
    var timeRemaining :  Int = 30
    var timer         :  Timer!
    var isTimerRunning:  Bool = false
    
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.timerLabel.text = timeString(time: TimeInterval(timeRemaining))
    }
    
    
    // MARK: - Methods
    func setupTimer() {
        timer          = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(runTimer), userInfo: nil, repeats: true)
        isTimerRunning = true
        RunLoop.main.add(timer!, forMode: .common)
    }
    
    @objc func runTimer() {
        if timeRemaining < 1 {
            timer.invalidate()
            startTimeTitle.titleLabel?.text = "Start"
            isTimerRunning                  = false
            timeRemaining                   = 30
        } else {
            timeRemaining                  -= 1
            timerLabel.text                 = timeString(time: TimeInterval(timeRemaining))
            isTimerRunning                  = true
            startTimeTitle.titleLabel?.text = "Pause"
        }
        timerLabel.text = timeString(time: TimeInterval(timeRemaining))
    }
    
    func timeString(time:TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
    
    func addSecond() {
        timeRemaining += 15
        timerLabel.text = timeString(time: TimeInterval(timeRemaining))
    }
    
    func subtractSecond() {
        timeRemaining -= 15
        timerLabel.text = timeString(time: TimeInterval(timeRemaining))
    }
    
    
    // MARK: - IBActions
    @IBAction func resetTimeTapped(_ sender: Any) {
        timer.invalidate()
        timeRemaining                   = 30
        timerLabel.text                 = timeString(time: TimeInterval(timeRemaining))
        isTimerRunning                  = false
        startTimeTitle.titleLabel?.text = "Start"
    }
    
    @IBAction func startTimeTapped(_ sender: Any) {
        if isTimerRunning == false {
            setupTimer()
        } else {
            timer.invalidate()
            isTimerRunning = false
        }
    }
    
    @IBAction func addTimeTapped(_ sender: Any) {
        addSecond()
    }
    
    @IBAction func subtractTimeTapped(_ sender: Any) {
        if timeRemaining > 14 {
            subtractSecond()
        } else {
            timer.invalidate()
            timeRemaining                = 0
            timerLabel.text              = timeString(time: TimeInterval(timeRemaining))
            isTimerRunning               = false
        }
    }
}
