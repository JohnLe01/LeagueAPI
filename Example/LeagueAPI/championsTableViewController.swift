//
//  championsTableViewController.swift
//  LeagueAPI
//
//  Created by Mason Phillips on 27Dec16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import LeagueAPI
import MMDrawerController

class championsTableViewController: UITableViewController, MSCoreListener {
    
    var champions: Array<MSChampion> = []
    let requestTypes: MSInteractionReturnType = .championData
    
    //let searchController = UISearchController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "champCell")
        view.backgroundColor = .white
        navigationItem.title = "League of Legends Champions"
        navigationItem.leftBarButtonItem = MMDrawerBarButtonItem(target: self, action: #selector(championsTableViewController.openDrawer))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        LeagueAPIWrapper.registerAsDelegate(controller: self)
        LeagueAPIWrapper.getChampionStaticData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        LeagueAPIWrapper.resignDelegate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return champions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "champCell")

        let c = champions[indexPath.row]
        
        cell.textLabel?.text = c.championName
        cell.detailTextLabel?.text = c.championClass.description

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = champDetailTableViewController()
        controller.champion = champions[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }

    func didReturn(singleObject o: ResponseObjectSerializable) {
        
    }
    
    func openDrawer() {
        mm_drawerController.open(.left, animated: true, completion: nil)
    }
    
    func didReturn(collection c: Array<ResponseObjectSerializable>) {
        champions = (c as! Array<MSChampion>).sorted(by: { (cone, ctwo) -> Bool in
            return cone.championName < ctwo.championName
        })
        tableView.reloadData()
    }
}
