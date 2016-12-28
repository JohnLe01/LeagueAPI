//
//  menuTableViewController.swift
//  LeagueAPI
//
//  Created by Mason Phillips on 27Dec16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit

class menuTableViewController: UITableViewController {
    
    let sectionTitles: Array<String> = ["Dynamic Data", "Static Data"]
    
    let rowTitles: Array<Array<String>> = [
        ["Summoner Search"],
        ["Champions"]
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "menuCell")
        view.backgroundColor = .white
        
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: 50))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowTitles[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath)

        cell.textLabel?.text = rowTitles[indexPath.section][indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let v = MenuView(usingPath: indexPath)
        moveToView(view: v)
    }
    
    func moveToView(view v: MenuView) {
        let controller: UIViewController!
        switch v {
        case .SSearch:
            controller = summonerDetailViewController()
            break
        case .Champs:
            controller = championsTableViewController()
            break
        }
        
        let nController = UINavigationController(rootViewController: controller)
        mm_drawerController.setCenterView(nController, withCloseAnimation: true, completion: nil)
    }
}

enum MenuView {
    case SSearch
    case Champs
    
    init(usingPath i: IndexPath) {
        switch i.section {
        case 1:
            self = .Champs
            break
        case 0: fallthrough
        default:
            self = .SSearch
            break
        }
    }
}
