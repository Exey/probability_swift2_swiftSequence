//
//  SumsViewController.swift
//  Lotto
//
//  Created by Exey Panteleev on 17/03/16.
//  Copyright © 2016 Mozgazm. All rights reserved.
//

import UIKit
import PNChartSwift

class SumsViewController: UIViewController, PNChartDelegate {
    
    @IBOutlet var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SumsViewController.redraw), name: UIDeviceOrientationDidChangeNotification, object: nil)
        redraw()
    }
    
    func redraw() {
        // remove all
        while scrollView.subviews.count > 0 {
            scrollView.subviews[0].removeFromSuperview()
        }
        
        let lastDraws = DataManager.getLastDraws(Conf.DEFAULT_RECENT_STAS_DRAWS*3)
        let lastSums = DataManager.calcSumsStats(lastDraws)
        let lastChart = ChartFactory.addSumBarChart(0, yPos: 5, ssd: lastSums, color: UIColor.purpleColor(), ctrl: self)
        
        // ALL PRNG DRAWS
        let allPRNGDraws = DataManager.getLastDraws(DataManager.draws!.count-Conf.PRNG_START_DRAW)
        let allSums = DataManager.calcSumsStats(allPRNGDraws)
        //let allSums = DataManager.calcSumsStats(DataManager.draws!)
        ChartFactory.addSumBarChart(0, yPos: lastChart.frame.height-10, ssd: allSums, color: PNGreenColor, ctrl: self)
        
        scrollView.contentSize.width = Conf.SUMS_WIDTH
        print("scrollView \(scrollView.contentSize)")
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
