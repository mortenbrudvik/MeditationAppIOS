//
//  ViewController.swift
//  Healthkit Meditation Demo
//
//  Created by Morten Brudvik on 14/07/2018.
//  Copyright © 2018 Morten Brudvik. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    lazy var box = UIView()
    
    var mainView: UIView {
        let view = UIView()
        view.backgroundColor = .gray
        view.layer.cornerRadius = 20
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
            setup()
        
//        box.backgroundColor = .red
//        self.view.addSubview(box)
//
//        box.snp.makeConstraints { (make) -> Void in
//            make.edges.equalTo(self.view)
//        }

        
    }
    
    func setup() {
        view.backgroundColor = .white
        title = "Meditation Timer"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

}

