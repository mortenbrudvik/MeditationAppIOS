//
//  CountDownController.swift
//  Healthkit Meditation Demo
//
//  Created by Morten Brudvik on 14/05/2019.
//  Copyright © 2019 Morten Brudvik. All rights reserved.
//

import WatchKit

class CountDownController: WKInterfaceController {

    var myTimer : Timer?
    var isPaused = false
    var elapsedTime : TimeInterval = 0.0
    var startTime = NSDate()
    var duration : TimeInterval = 60.0

    @IBOutlet weak var timer: WKInterfaceTimer!
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
    
    func playAlert() {
        let device = WKInterfaceDevice.current()
        device.play(.notification)
    }
    
    override func willActivate() {
        super.willActivate()
        myTimer = Timer.scheduledTimer(timeInterval: duration, target: self, selector: Selector(("timerDone")), userInfo: nil, repeats: false)
        
        timer.setDate(Date(timeIntervalSinceNow: duration))
        timer.start()
    }
    
    @IBAction func pauseTimer() {
        if isPaused {
            isPaused = false
            myTimer = Timer.scheduledTimer(timeInterval: duration - elapsedTime, target: self, selector: Selector(("timerDone")), userInfo: nil, repeats: false)
            timer.setDate(NSDate(timeIntervalSinceNow: duration - elapsedTime) as Date)
            timer.start()
            startTime = NSDate()
            pauseButton.setTitle("Pause")
        } else {
            isPaused = true
            let paused = NSDate()
            elapsedTime += paused.timeIntervalSince(startTime as Date)
            timer.stop()
            myTimer!.invalidate()
            pauseButton.setTitle("Continue")
        }
    }
    
    func timerDone(){

    }
}
