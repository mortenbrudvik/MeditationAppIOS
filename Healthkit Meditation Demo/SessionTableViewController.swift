//
//  SessionTableViewController.swift
//  Healthkit Meditation Demo
//
//  Created by Morten Brudvik on 06/08/2018.
//  Copyright © 2018 Morten Brudvik. All rights reserved.
//

import UIKit
import HealthKit

class SessionTableViewController: UITableViewController {

    var meditationHealthKit = MeditationHealthKit()
    
    var meditationSamples: [HKSample] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {

        meditationHealthKit.onDataLoaded = {result in
            self.meditationSamples = result
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        meditationHealthKit.loadData()
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x:0, y:0, width:tableView.frame.size.width, height:18))
        let label = UILabel(frame: CGRect(x:0, y:0, width:tableView.frame.size.width, height:18))
        label.text = "Sessions";
        label.textColor = .flatWhite
        view.addSubview(label);
        view.backgroundColor = .flatMint;
        
        label.snp.makeConstraints{(make) in
            make.centerX.equalTo(view)
        }
        return view
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 28;
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(meditationSamples.count)
        return meditationSamples.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "MyTestCell")
        let startDate = meditationSamples[indexPath.row].startDate
        let endDate = meditationSamples[indexPath.row].endDate
        
        let elapsed = Int(endDate.timeIntervalSince(startDate))


        cell.textLabel?.text = "\(formatDate(startDate))"
        cell.detailTextLabel?.text = "Meditation \((elapsed % 3600) / 60) min"
        print(elapsed)
        
        return cell
    }
    
    func formatDate(_ date: Date) -> String {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy HH:mm"
        return dateFormatter.string(from: date)
    }
}

