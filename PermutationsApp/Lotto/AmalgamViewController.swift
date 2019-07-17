//
//  AmalgamViewController.swift
//  Lotto
//
//  Created by Exey Panteleev on 27/04/16.
//  Copyright © 2016 Mozgazm. All rights reserved.
//

import UIKit

class AmalgamViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // UI
    @IBOutlet var tableViewPairs: UITableView!
    @IBOutlet var tableViewTrios: UITableView!
    
    var numberButtons:MapRowView?
    
    // Data
    var selectedNumbers:[Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewPairs.separatorColor = UIColor.whiteColor()
        tableViewTrios.separatorColor = UIColor.whiteColor()

        let h = view.frame.width / (CGFloat(Conf.MAX_LOTTO_VALUE) + 1)
        numberButtons = MapRowView(frame: CGRect(x: 0, y: 64, width: view.frame.width, height: h))
        numberButtons?.addNumberButtons { v in
            self.selectedNumbers = [v]
            self.tableViewPairs.reloadData()
            self.tableViewTrios.reloadData()
        }
        view.addSubview(numberButtons!)
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of items in the sample data structure.
        
        var count:Int?
        
        if tableView == self.tableViewPairs {
            count = DataManager.pairs.values.count
        }
        
        if tableView == self.tableViewTrios {
            count =  DataManager.trios.values.count
        }
        
        return count!
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:AmalgamTableViewCell?
        
        if tableView == self.tableViewPairs {
            cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! AmalgamTableViewCell
            let p = DataManager.pairs.values[indexPath.row]
            //cell!.textLabel!.text = "\(p.count) - \(p.comb)"
            cell?.update(p.count, nums: p.comb, selected: selectedNumbers)
        }
        
        if tableView == self.tableViewTrios {
            cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! AmalgamTableViewCell
            let t = DataManager.trios.values[indexPath.row]
            //cell!.textLabel!.text = "\(t.count) - \(t.comb)"
            cell?.update(t.count, nums: t.comb, selected: selectedNumbers)
        }
        
        return cell!
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("did select:      \(indexPath.row)  ")
    }
    
    /*func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let h = view.frame.width / (CGFloat(Conf.MAX_LOTTO_VALUE) + 1)
        let hotRow = MapRowView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: h))
        hotRow.addNumberButtons()
        return hotRow
    }*/
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let h = view.frame.width / (CGFloat(Conf.MAX_LOTTO_VALUE) + 1)
        return h
    }
}
