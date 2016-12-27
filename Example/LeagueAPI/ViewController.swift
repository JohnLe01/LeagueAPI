//
//  ViewController.swift
//  LeagueAPI
//
//  Created by Mason Phillips on 12/26/2016.
//  Copyright (c) 2016 Mason Phillips. All rights reserved.
//

import UIKit
import Neon

class ViewController: UIViewController {

    let summonerName: UITextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        let label = UILabel()
        label.text = "Welcome"
        label.textAlignment = .center
        view.addSubview(label)
        label.anchorInCenter(width: view.width, height: 30)
        
        summonerName.placeholder = "Enter Summoner Name"
        view.addSubview(summonerName)
        summonerName.alignAndFillWidth(align: .underCentered, relativeTo: summonerName, padding: 10, height: 30)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

