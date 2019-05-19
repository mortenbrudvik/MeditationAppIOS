//
//  CountDownController.swift
//  Healthkit Meditation Demo
//
//  Created by Morten Brudvik on 14/05/2019.
//  Copyright © 2019 Morten Brudvik. All rights reserved.
//

import WatchKit

class CountDownController: WKInterfaceController {

    var timer : Timer?
    var isPaused = false
    var elapsedTime : TimeInterval = 0.0
    var startTime = NSDate()
    var duration : TimeInterval = 60.0

    @IBOutlet weak var interfaceTimer: WKInterfaceTimer!
    @IBOutlet weak var pauseButton: WKInterfaceButton!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        if let time: Int = context as? Int {
            duration = Double(time) * 60.0
            print("time recieved: \(time)" )
        } else {
            duration = 60.0
        }
    }
    override func willActivate() {
        super.willActivate()
        timer = Timer.scheduledTimer(timeInterval: duration, target: self, selector: Selector(("timerDone")), userInfo: nil, repeats: false)
        
        interfaceTimer.setDate(Date(timeIntervalSinceNow: duration))
        interfaceTimer.start()
    }
    
    override func willDisappear() {
        super.willDisappear()
        
        timer!.invalidate()
        timer = nil
    }
    
    @IBAction func pauseTimer() {
        if isPaused {
            isPaused = false
            timer = Timer.scheduledTimer(timeInterval: duration - elapsedTime, target: self, selector: #selector(timerDone), userInfo: nil, repeats: false)
            interfaceTimer.setDate(NSDate(timeIntervalSinceNow: duration - elapsedTime) as Date)
            interfaceTimer.start()
            startTime = NSDate()
            pauseButton.setTitle("Pause")
        } else {
            isPaused = true
            let paused = NSDate()
            elapsedTime += paused.timeIntervalSince(startTime as Date)
            interfaceTimer.stop()
            timer!.invalidate()
            pauseButton.setTitle("Continue")
        }
    }
    
    func playAlert() {
        let device = WKInterfaceDevice.current()
        device.play(.notification)
    }
    
    @objc func timerDone(){
        pauseButton.setHidden(true)
        playAlert()
    }
}
