//
//  CompleteController.swift
//  Watch Extension
//
//  Created by Morten Brudvik on 30/05/2019.
//  Copyright © 2019 Morten Brudvik. All rights reserved.
//

import WatchKit

class CompleteController: WKInterfaceController {

    @IBOutlet weak var timeLabel: WKInterfaceLabel!
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        if let time: TimeInterval = context as? TimeInterval {
            timeLabel.setText("\(Int(time/60)) min")
        }

    }
    @IBAction func backToMain() {
        popToRootController()
    }
    
}
