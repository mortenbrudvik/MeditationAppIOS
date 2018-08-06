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
    
    func saveSession(start: Date, seconds: Double) {
        
        let endTime = start.addingTimeInterval(seconds)
        
        if let mindfulType = HKObjectType.categoryType(forIdentifier: .mindfulSession) {
        
            let mindfullSample = HKCategorySample(type:mindfulType, value: 0, start: start, end: endTime)
            
            print("saving session. Time: \(seconds) seconds")
            self.dataStore?.save(mindfullSample, withCompletion: { (success, error) -> Void in
                
                if error != nil {
                    self.errorDescription = error.debugDescription
                    print(error.debugDescription)
                    return
                }
                
                if success {
                    print("Meditation session has been saved to HealthKit")
                    
                } else {
                    print("Failed to save session to HealthKit")
                }
            })
        }
    }
    

}
