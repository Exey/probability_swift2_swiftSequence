//
//  BetsViewController.swift
//  Lotto
//
//  Created by Exey Panteleev on 22/03/16.
//  Copyright © 2016 Mozgazm. All rights reserved.
//

import UIKit

protocol BetsCtrlDelegate {
    
    func betsChanged(boxIndex:Int, selectedNumbers:[Int])
    
}

class BetsViewController: UIViewController, BetsCtrlDelegate  {
    
    // UI
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var chance2Label: UIVerticalAlignLabel!
    @IBOutlet var chance3Label: UIVerticalAlignLabel!
    @IBOutlet var chance4Label: UIVerticalAlignLabel!
    @IBOutlet var chance5Label: UIVerticalAlignLabel!
    
    var isBoxesAdded:Bool = false
    
    // Data
    var boxes:[BetBoxView]?
    
    override func viewDidLoad() {
        
        // Important
        // Initial
        NavigationManager.navigationController = self.navigationController
        NavigationManager.addTitle()
        //NavigationManager.navigationController!.navigationBar.backgroundColor = StyleManager.COLOR_MAP_SQUARE.colorWithAlphaComponent(1)
        NavigationManager.navigationController!.navigationBar.barTintColor = UIColor(hex: 0x3ebb5e)
        UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: false)
        //UITabBar.appearance().
        tabBarController?.tabBar.backgroundColor = StyleManager.COLOR_MAP_SQUARE.colorWithAlphaComponent(1)
        //tabBarController?.tabBar.translucent = false
        //tabBarController?.tabBar.opaque = true
        UITabBar.appearance().tintColor = UIColor.whiteColor()
        tabBarController!.tabBar.tintColor = UIColor.whiteColor()
        //tabBarController!.tabBar.selectedImageTintColor = UIColor.blackColor()
        
        
        let font = UIFont (name: "HelveticaNeue", size: 12)
        for vc in tabBarController!.viewControllers! {
            let tbi = vc.tabBarItem
            tbi.image = tbi.image!.maskWithColor(UIColor.whiteColor())
            tbi.image = tbi.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
            tbi.setTitleTextAttributes([NSFontAttributeName: font!, NSForegroundColorAttributeName: UIColor.whiteColor()], forState: UIControlState.Normal)
        }
        
        DataManager.doInitialCalculations()
        
        StyleManager.styleBars()
        
        // UI
        chance2Label.verticalAlignment = VerticalAlignment.VerticalAlignmentTop
        chance3Label.verticalAlignment = VerticalAlignment.VerticalAlignmentTop
        chance4Label.verticalAlignment = VerticalAlignment.VerticalAlignmentTop
        chance5Label.verticalAlignment = VerticalAlignment.VerticalAlignmentTop
        
        automaticallyAdjustsScrollViewInsets = false
        
        // test
        /*
        Conf.COMBS_COUNT_2_IN_36
        Conf.COMBS_COUNT_3_IN_36
        Conf.COMBS_COUNT_4_IN_36
        //
        print("\(Int64.max) \(Int.max) \(Int32.max)")
        let hgd2 = MathCombinatoricsUtil.hyperGeometricDistribution(5, y: 36, z: 5, n: 2)
        //let hgd = MathCombinatoricsUtil.hyperGeometricDistribution(36, y: 36, z: 5, n: 2)
        print("PROBABILITY 2 \(hgd2)")
        let hgd3 = MathCombinatoricsUtil.hyperGeometricDistribution(5, y: 36, z: 5, n: 3)
        print("PROBABILITY 3 \(hgd3)")
        */
    }
    
    //
    
    override func viewDidLayoutSubviews() {
        if isBoxesAdded { return }

        boxes = [BetBoxView]()
        let boxCount = 6
        
        var shiftX:CGFloat = 0
        for i in 0..<boxCount {
            let bbv = addBox(shiftX)
            scrollView.addSubview(bbv)
            shiftX += bbv.frame.width + 2
            // data
            bbv.boxIndex = i
            bbv.delegate = self
            boxes!.append(bbv)
        }
        
        // Prepare
        DataManager.bets = [[Int]](count: boxCount, repeatedValue: [Int]())
        DataManager.probabilities = ProbabilityData()
        
        isBoxesAdded = true
    }
    
    // Create TableView for Boxes
    
    func addBox(x:CGFloat)->BetBoxView {
        let bbv = BetBoxView(frame: CGRect(x: x, y: 0, width: Conf.BET_BOX_BUTTON_SIZE*6, height: scrollView.frame.height))
        //print("BetsViewController \(scrollView.frame) ** \(scrollView.contentSize)")
        scrollView.contentSize.height = scrollView.frame.height
        bbv.addGrid(scrollView.frame.height)
        bbv.addStatsView()
        bbv.layer.addBorder(UIRectEdge.Right, color: UIColor.whiteColor(), thickness: 1)
        bbv.userInteractionEnabled = true
        return bbv
    }
    
    // MARK: - BetsCtrlDelegate
    
    func betsChanged(boxIndex:Int, selectedNumbers:[Int]) {
        print("betsChanged")
        DataManager.bets![boxIndex] = selectedNumbers
        //
        var readyForProbability:[[Int]] = [[Int]]()
        for i in 0..<DataManager.bets!.count {
            let b = DataManager.bets![i]
            print("BET \(i) - \(b)")
            if b.count >= Conf.CHOOSE_COUNT {
                readyForProbability.append(b)
            }
        }
        if(readyForProbability.count > 0) {
            DataManager.calculateProbability(readyForProbability)
            let pb = DataManager.probabilities!
            updateProbabilityTexts(pb)
        }
        updateBetStats()
    }
    
    func updateBetStats()  {
        let bets = DataManager.bets!
        let draws = DataManager.draws!
        
        for i in 0..<bets.count {
            let b = bets[i]
            let bb = boxes![i]
            
            // sum
            var cd = CombinationData(values: b)
            var numCounts:NumCounts         = (0,0,0,0,0,0) // PNRG draws
            var numCountsMachine:NumCounts  = (0,0,0,0,0,0) // Machine draws
            bb.statsView?.updateSum(cd.sum)
            
            // odd and even
            let oddAndEven = cd.oddAndEven
            bb.statsView?.updateOddEven(oddAndEven.0, evenNum: oddAndEven.1)
            
            // average + cold and hot
            cd.resetDistances()
            var coldAndHot = (0, 0)
            for v in cd.values {
                let dist = DataManager.distancies!.currentDistances[v]
                cd.setDistanceForValue(v, distance: dist)
                if AnalysisManager.isHotNumber(dist) {
                    coldAndHot.1 += 1
                } else {
                    coldAndHot.0 += 1
                }
            }
            
            bb.statsView?.updateAverageAndColdHot(cd.averageDistance, cold: coldAndHot.0, hot: coldAndHot.1)
            
            // pairs gravity
            let pc = cd.pairsClustered
            bb.statsView?.updateGravity(pc.c0.count, clusterMid: pc.c1.count, clusterLow: pc.c2.count)
            
            // matches
            //var s = ""
            // Machine
            for i in 0..<Conf.PRNG_START_DRAW-1 {
                let d = draws[i]
                d.compareAndIncrement(&numCountsMachine, bet: b)
            }
            
            // PRNG
            for i in 0...draws.count-Conf.PRNG_START_DRAW {
                let d = draws[i]
                d.compareAndIncrement(&numCounts, bet: b)
            }
            
            
            bb.statsView?.updateMatches(numCounts, machineNumCounts: numCountsMachine)
           
            //s += "matches\n"
            //s += "\(pc.c0.count) = \(pc.c1.count) = \(pc.c2.count) \n"
            /*s += "0: \(numCounts.0)\n"
            s += "1: \(numCounts.1)\n"
            s += "2: \(numCounts.2)\n"
            s += "3: \(numCounts.3)\n"
            s += "4: \(numCounts.4)\n"
            s += "5: \(numCounts.5)\n"*/
            //bb.updateStatsLabel(s)
            
            //bb.statsView!.otherStatsLabel?.text = s
        }
        
    }
    
    func updateProbabilityTexts(pb:ProbabilityData) {
        let p2 = String(format: "%.3f", pb.probabilty2)
        let p3 = String(format: "%.4f", pb.probabilty3)
        let p4 = String(format: "%.5f", pb.probabilty4)
        let p5 = String(format: "%.7f", pb.probabilty5)
        
        let p2percent = "\(Double(p2)!*100)%"
        let p3percent = "\(Double(p3)!*100)%"
        let p4percent = "\(Double(p4)!*100)%"
        let p5percent = "\(Double(p5)!*100)%"
        
        let chance2 = 1.0/pb.probabilty2
        let chance3 = 1.0/pb.probabilty3
        let chance4 = 1.0/pb.probabilty4
        let chance5 = 1.0/pb.probabilty5
        
        chance2Label.text = "\(p2)\n\(p2percent)\n1:\(chance2.roundToDecimals(0))"
        chance3Label.text = "\(p3)\n\(p3percent)\n1:\(chance3.roundToDecimals(0))"
        chance4Label.text = "\(p4)\n\(p4percent)\n1:\(chance4.roundToDecimals(0))"
        chance5Label.text = "\(p5)\n\(p5percent)\n1:\(chance5.roundToDecimals(0))"
    }
    
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Landscape
    }
    
}