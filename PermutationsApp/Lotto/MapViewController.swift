//
//  MapViewController.swift
//  Lotto
//
//  Created by Exey Panteleev on 12/03/16.
//  Copyright © 2016 Mozgazm. All rights reserved.
//

import UIKit

class MapViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {

    // UI
    @IBOutlet var tableView: UITableView!
    
    // MARK: - Handlers
    
    /** Entrty point */
    override func viewDidLoad() {
        super.viewDidLoad()
        // tableview
        tableView.registerClass(MapRowTableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.allowsSelection = false
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        tableView.sectionHeaderHeight = 0.0
        // orientaion changed
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MapViewController.redraw), name: UIDeviceOrientationDidChangeNotification, object: nil)
    }
    
    func redraw() {
        tableView.reloadData()
    }
    
    // MARK: - TableView Handlers
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.draws!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")! as! MapRowTableViewCell
        let cd = DataManager.draws![indexPath.row]
        cell.build(cd)
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let h = view.frame.width / (CGFloat(Conf.MAX_LOTTO_VALUE) + 1)
        return h
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let h = view.frame.width / (CGFloat(Conf.MAX_LOTTO_VALUE) + 1)
        //let hotRow = MapRowView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: h))
        //hotRow.addHotNumbers()
        let header = MapHeader(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: h*3))
        //header.backgroundColor = UIColor.redColor()
        header.addRows(h)
        return header
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let h = view.frame.width / (CGFloat(Conf.MAX_LOTTO_VALUE) + 1)
        return h
    }
}
