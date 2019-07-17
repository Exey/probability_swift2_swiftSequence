//
//  ViewController.swift
//  Lotto
//
//  Created by Exey Panteleev on 25/02/16.
//  Copyright © 2016 Mozgazm. All rights reserved.
//

import UIKit
import Alamofire
import PNChartSwift

class StatsViewController: UIViewController, PNChartDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        // Continue
        /*NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(StatsViewController.redraw), name: UIDeviceOrientationDidChangeNotification, object: nil)*/
        self.redraw()
    }
    
    func redraw() {
        
        // remove all
        while view.subviews.count > 0 {
            view.subviews[0].removeFromSuperview()
        }
        
        print("COUNT \(DataManager.draws?.count)")
        
        // LAST MONTH
        let last = DataManager.calcValueFrequencyStats(DataManager.draws!.count-Conf.DEFAULT_RECENT_STAS_DRAWS, endDraw: DataManager.draws!.count) // all
        print(last!)
        let lastMonthChart = ChartFactory.addFrequencyBarChart(0, yPos: 60, vfsd: last!, color: nil, ctrl: self)
        
        print("----")
        
        //return
        // ALL PRNG DRAWS
        //let vfsd = DataManager.calcValueFrequencyStats(1700, endDraw: 1880)
        //let all = DataManager.calcValueFrequencyStats(0, endDraw: DataManager.draws!.count) // all
        //print(all!)
        ChartFactory.addFrequencyBarChart(0, yPos: view.frame.height/2, vfsd: DataManager.allPRNGFrequencies!, color: PNGreenColor, ctrl: self)
        
    }
    
    // MARK: - Chart Handlers

    func userClickedOnLineKeyPoint(point: CGPoint, lineIndex: Int, keyPointIndex: Int)
    {
        print("Click Key on line \(point.x), \(point.y) line index is \(lineIndex) and point index is \(keyPointIndex)")
    }
    
    func userClickedOnLinePoint(point: CGPoint, lineIndex: Int)
    {
        print("Click Key on line \(point.x), \(point.y) line index is \(lineIndex)")
    }
    
    func userClickedOnBarChartIndex(barIndex: Int)
    {
        print("Click  on bar \(barIndex)")
    }
    
}

