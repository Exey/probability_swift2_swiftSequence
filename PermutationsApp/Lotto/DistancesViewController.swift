//
//  DistancesViewController.swift
//  Lotto
//
//  Created by Exey Panteleev on 05/04/16.
//  Copyright © 2016 Mozgazm. All rights reserved.
//

import UIKit

class DistancesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // UI
    @IBOutlet var tableView: UITableView!
    
    // MARK: - Handlers
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // tableview
        tableView.registerClass(DistancesTableViewCell.self, forCellReuseIdentifier: "Cell")
        //tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        tableView.separatorInset = UIEdgeInsetsZero
        tableView.allowsSelection = false
        tableView.separatorColor = UIColor.whiteColor()
        
        for cd in DataManager.draws! {
            //print("\(cd.drawNumber) - \(cd.values) - \(cd.distanciesPerValue)")
        }
    }

    // MARK: - TableView Handlers
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.draws!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")! as! DistancesTableViewCell
        cell.layoutMargins = UIEdgeInsetsZero
        cell.preservesSuperviewLayoutMargins = false
        let cd = DataManager.draws![indexPath.row]
        cell.update(cd)
        return cell
    }

}
