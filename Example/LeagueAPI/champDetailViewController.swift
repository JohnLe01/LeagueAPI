//
//  champDetailViewController.swift
//  LeagueAPI
//
//  Created by Mason Phillips on 27Dec16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import Neon
import LeagueAPI

class champDetailTableViewController: UIViewController {
    
    var champion: MSChampion!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let label = UILabel()
        
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        
        label.text = champion.description
        label.textAlignment = .left
        
        label.sizeToFit()
        view.addSubview(label)
        label.fillSuperview(left: 0, right: 0, top: 45, bottom: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
