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
import MMDrawerController

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        navigationItem.title = "LeagueAPI Example"
        navigationItem.leftBarButtonItem = MMDrawerBarButtonItem(target: self, action: #selector(ViewController.openDrawer))
        
        let label = UILabel()
        label.text = "Open the drawer to get started"
        label.textAlignment = .center
        view.addSubview(label)
        label.anchorInCenter(width: view.width, height: 30)

    }
    
    func openDrawer() {
        mm_drawerController.open(.left, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

