//
//  InterfaceController.swift
//  Watch Extension
//
//  Created by Morten Brudvik on 13/04/2019.
//  Copyright © 2019 Morten Brudvik. All rights reserved.
//

import WatchKit
import HealthKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet weak var timePicker: WKInterfacePicker!
    
    var minutes: [Int] = []
    
    var meditationInMinutes = 1
    
    let meditationDataAccess = MeditationHealthKit()
    
    @IBAction func pickerChanged(_ value: Int) {
        meditationInMinutes = value + 1
        print("time: \(meditationInMinutes) min")
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        minutes.append(contentsOf: (1...60).map{$0})
        
        var pickerItems: [WKPickerItem] = []
        
        minutes.forEach{
            let pickerItem = WKPickerItem()
            pickerItem.title = "\($0) \($0 == 1 ? "min" : "mins")"
            pickerItems.append(pickerItem)
        }
        
        timePicker.setItems(pickerItems)
    }
    

    
    override func contextForSegue(withIdentifier segueIdentifier: String) -> Any? {
        
        return meditationInMinutes
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    
        meditationDataAccess.authorize()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
