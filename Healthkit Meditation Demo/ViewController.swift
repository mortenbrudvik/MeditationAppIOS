//
//  ViewController.swift
//  Healthkit Meditation Demo
//
//  Created by Morten Brudvik on 14/07/2018.
//  Copyright © 2018 Morten Brudvik. All rights reserved.
//

import UIKit
import AVFoundation
import SnapKit

enum timerState {
    case notStarted, running, paused, completed
}

class ViewController: UIViewController {
    
    var minutes: [Int] = []
    var timer: Timer! = nil
    var timerState: timerState = .notStarted
    var seconds = 0
    
    var mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .flatWhite
        return view
    }()
    
    var headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .flatMint
        return view
    }()
    
    let minutesSelectionView: UIPickerView = UIPickerView()
    
    let countDownLabel: UILabel = {
        let label = UILabel()
        label.text = "01:00"
        label.textColor = .flatBlack
        label.font = UIFont(name: "Courier",
                            size: 54.0)
        return label
    }()
    
    let startButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.backgroundColor = .flatMintDark
        button.setTitle("Start", for: .normal)
        button.contentEdgeInsets = UIEdgeInsetsMake(7,22,7,22)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        button.titleLabel?.textColor = .flatWhite
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }()
    
    @objc func buttonAction(_ sender: UIButton) {
        print("current state: ")
        
        switch self.timerState {
        case .notStarted:
            startCountdown()
            self.timerState = .running
            break
        case .running:
            break
        case .paused:
            break
        case .completed:
            break
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        minutes.append(contentsOf: (1...60).map{$0})
        
        setup()
        setupViews()
    }
    
    func setup() {
        view.backgroundColor = .flatWhite
        //navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupViews() {
        view.addSubview(mainView)
        mainView.snp.makeConstraints {(make) in
            make.edges.equalTo(self.view)
        }
        
        // Header view
        mainView.addSubview(headerView)
        headerView.snp.makeConstraints {(make) in
            make.top.left.right.equalTo(self.mainView)
            make.height.equalTo(68)
        }
        
        let titleLabel = UILabel()
        headerView.addSubview(titleLabel)
        titleLabel.text = "Meditation Timer"
        titleLabel.textColor = .flatWhite
        titleLabel.sizeToFit()
        titleLabel.snp.makeConstraints{(make) in
            make.centerX.equalTo(self.headerView)
            make.bottom.equalTo(self.headerView).offset(-10)
        }
        
        // Time Picker View
        minutesSelectionView.dataSource = self
        minutesSelectionView.delegate = self
        mainView.addSubview(minutesSelectionView)
        minutesSelectionView.snp.makeConstraints {(make) in
            make.top.equalTo(self.headerView.snp.bottom).offset(20)
            make.right.left.equalTo(mainView)
        }
        
        // Count Down Timer Label View
        mainView.addSubview(countDownLabel)
        countDownLabel.snp.makeConstraints{(make) in
            make.top.greaterThanOrEqualTo(self.minutesSelectionView.snp.bottom).offset(20)
            make.centerX.equalTo(self.mainView)
            make.centerY.equalTo(self.mainView).offset(20)
        }
        
        // Start, Pause, Continue Button
        mainView.addSubview(startButton)
        startButton.snp.makeConstraints {(make) in
            make.centerX.equalTo(self.mainView)
            make.bottom.equalTo(self.mainView.snp.bottom).offset(-110)
        }
    }
    

    
    // MARK: Helper Methods
    
    func timeString(minutes: Int) -> String {
        return timeString(time: TimeInterval(minutes*60))
    }
    
    func timeString(seconds: Int) -> String {
        return timeString(time: TimeInterval(seconds))
    }
    
    func timeString(time:TimeInterval) -> String {
        let minutes =  Int(time) != (60*60) ? Int(time) / 60 % 60 : 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}


// MARK: Meditation Timer

extension ViewController: CountDownClock {

    func startCountdown() {
        print("start")
        
        runTimer()
    }
    
    func pause() {
        print("pause")
    }
    
    func unPause() {
        print("unpause")
    }
    
    func triggerAlarm() {
        print("trigger alarm")
    }
  
    func reset() {
        print("reset")
    }

    
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if seconds < 1 {
            triggerAlarm()
        } else {
            seconds -= 1
            
            self.countDownLabel.text = "\(self.timeString(seconds: seconds))"
        }
        print(seconds)
    }
}


// MARK: Time Selection (PickerView)
extension ViewController :  UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return minutes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let titleData = "\(row + 1) \(row == 0 ? "minute" : "minutes" )"
        
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.textColor = .flatBlack
            pickerLabel?.font = UIFont(name: "AvenirNext-Regular", size: 28)
            pickerLabel?.textAlignment = .center
        }
        pickerLabel?.text = titleData
        
        return pickerLabel!
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let seconds = minutes[row]*60
        
        countDownLabel.text = "\(timeString(time: TimeInterval(seconds)))"
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
}

protocol CountDownClock {
    func pause()
    func unPause()
    func triggerAlarm()
    func startCountdown()
    func reset()
}
