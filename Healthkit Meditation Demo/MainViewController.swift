//
//  MainViewController.swift
//  Healthkit Meditation Demo
//
//  Created by Morten Brudvik on 06/08/2018.
//  Copyright © 2018 Morten Brudvik. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let meditationView = MeditationViewController()
        meditationView.tabBarItem.image = UIImage(named: "home-black")
        meditationView.tabBarItem.selectedImage = UIImage(named: "home-green")?.withRenderingMode(.alwaysOriginal)
        
        let sessionView = SessionTableViewController()
        sessionView.tabBarItem.image = UIImage(named: "clock-black")
        sessionView.tabBarItem.selectedImage = UIImage(named: "clock-green")?.withRenderingMode(.alwaysOriginal)
        
        viewControllers = [meditationView, sessionView]
        
        for tabBarItem in tabBar.items!
        {
            tabBarItem.title = ""
            tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0)
        }
    }

}
