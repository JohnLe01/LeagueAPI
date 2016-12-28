//
//  summonerDetailViewController.swift
//  LeagueAPI
//
//  Created by Mason Phillips on 27Dec16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import Neon
import MMDrawerController
import LeagueAPI

class summonerDetailViewController: UIViewController, MSCoreListener {
    
    var summoner: MSSummoner!
    
    let requestTypes: MSInteractionReturnType = .summonerData
    
    let summonerLabel: UILabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        summonerLabel.numberOfLines = 0
        summonerLabel.lineBreakMode = .byWordWrapping
        view.addSubview(summonerLabel)
        summonerLabel.fillSuperview(left: 0, right: 0, top: 45, bottom: 0)
        
        navigationItem.leftBarButtonItem = MMDrawerBarButtonItem(target: self, action: #selector(summonerDetailViewController.openDrawer))
    }

    override func viewDidAppear(_ animated: Bool) {
        LeagueAPIWrapper.registerAsDelegate(controller: self)
        
        LeagueAPIWrapper.searchSummoner(byName: "MatrixSenpai")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        LeagueAPIWrapper.resignDelegate()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didReturn(singleObject o: ResponseObjectSerializable) {
        summonerLabel.text = (o as! MSSummoner).description
        navigationItem.title = (o as! MSSummoner).summonerName
    }
    
    func didReturn(collection c: Array<ResponseObjectSerializable>) {
        
    }
    
    func openDrawer() {
        mm_drawerController.open(.left, animated: true, completion: nil)
    }
}
