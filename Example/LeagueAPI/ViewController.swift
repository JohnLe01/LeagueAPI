//
//  ViewController.swift
//  LeagueAPI
//
//  Created by Mason Phillips on 12/26/2016.
//  Copyright (c) 2016 Mason Phillips. All rights reserved.
//

import UIKit
import Neon
import LeagueAPI

class ViewController: UIViewController {

    let summonerName: UITextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .gray
        
        let label = UILabel()
        label.text = "Welcome"
        label.textAlignment = .center
        view.addSubview(label)
        label.anchorInCenter(width: view.width, height: 30)

        let button = UIButton()
        button.addTarget(self, action: #selector(ViewController.refreshData), for: .touchUpInside)
        button.setTitle("Refresh Static Data", for: .normal)
        button.setTitleColor(.red, for: .normal)
        view.addSubview(button)
        button.alignAndFillWidth(align: .underCentered, relativeTo: label, padding: 10, height: 30)
    }
    
    func refreshData() {
        LeagueAPIWrapper.initializeStaticData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

