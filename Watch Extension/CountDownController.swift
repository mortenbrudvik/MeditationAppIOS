//
//  CountDownController.swift
//  Healthkit Meditation Demo
//
//  Created by Morten Brudvik on 14/05/2019.
//  Copyright © 2019 Morten Brudvik. All rights reserved.
//

import WatchKit

class CountDownController: WKInterfaceController {

    var seconds = 60.0
    
    @IBOutlet weak var timer: WKInterfaceTimer!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
    }
    
    override func willActivate() {
        super.willActivate()
        
        timer.setDate(Date(timeIntervalSinceNow: seconds))
        timer.start()
    }
    
    @objc func countDownOneSecond() {

    }
}
