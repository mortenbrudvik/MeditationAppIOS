//
//  MeditationHealthKit.swift
//  Healthkit Meditation Demo
//
//  Created by Morten Brudvik on 05/08/2018.
//  Copyright © 2018 Morten Brudvik. All rights reserved.
//

import Foundation
import HealthKit

class MeditationHealthKit {
    
    let dataStore: HKHealthStore?
    
    let typestoRead: Set<HKCategoryType>?
    let typestoShare: Set<HKCategoryType>?
    
    var isAuthorized = false
    var errorDescription = ""
    
    init() {
        dataStore = HKHealthStore()
        
        typestoRead = Set([
            HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.mindfulSession)!
            ])
        
        typestoShare = Set([
            HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.mindfulSession)!
            ])
    }
    
    func authorize() {
        if !HKHealthStore.isHealthDataAvailable() {
            return
        }
    
        dataStore!.requestAuthorization(toShare: typestoShare, read: typestoRead)
        { (success, error) -> Void in
            if success {
                self.isAuthorized = true
                print("Successful HealthKit authorization.")
            } else {
                self.isAuthorized = false
                self.errorDescription = error.debugDescription
                print(error.debugDescription)
            }
        }
    }
    

}
