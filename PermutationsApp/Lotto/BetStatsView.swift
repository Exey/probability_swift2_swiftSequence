//
//  BetStatsView.swift
//  Lotto
//
//  Created by Exey Panteleev on 02/04/16.
//  Copyright © 2016 Mozgazm. All rights reserved.
//

import UIKit

typealias DuoContainers  = (ColoredContainer, ColoredContainer)
typealias TrioContainers = (h: ColoredContainer, m: ColoredContainer, l: ColoredContainer)

class BetStatsView: UIView {

    // UI
    var sumContainer:ColoredContainer?
    var oddAndEvenContainers:DuoContainers?
    var averageContainer:ColoredContainer?
    var coldAndHotContainers:DuoContainers?
    var gravityContainers:TrioContainers?

    var matches0Containers:TrioContainers?
    var matches1Containers:TrioContainers?
    var matches2Containers:TrioContainers?
    var matches3Containers:TrioContainers?
    var matches4Containers:TrioContainers?
    var matches5Containers:TrioContainers?
    
    var otherStatsLabel:UIVerticalAlignLabel?
    
    /* CONSTRUCTOR */
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addUI()
    }
    
    func addUI() {
        var shiftY:CGFloat = 0
        // SUM
        sumContainer = ColoredContainer(frame: CGRect(x: 0, y: shiftY, width: frame.width, height: 30))
        sumContainer!.addUI( CGRect(x: 60, y: 5, width: 20, height: 20),
                                    iconImage: UIImage(named:"sum")!,
                                    color: UIColor.whiteColor(),
                                    gap: 5)
        addSubview(sumContainer!)
        shiftY += sumContainer!.frame.height + 1
        // ODD and EVEN
        oddAndEvenContainers = addDuoContainers(shiftY, icon1: UIImage(named:"circle-half"), icon2: UIImage(named:"circle-double"))
        shiftY += oddAndEvenContainers!.0.frame.height + 1
        // DISTANCE AVERAGE
        averageContainer = ColoredContainer(frame: CGRect(x: 0, y: shiftY, width: frame.width, height: 30))
        averageContainer!.addUI( CGRect(x: 60, y: 5, width: 20, height: 20),
                                         iconImage: UIImage(named:"average")!,
                                         color: UIColor.whiteColor(),
                                         gap: 5)
        addSubview(averageContainer!)
        shiftY += averageContainer!.frame.height + 1
        // COLD and HOT
        coldAndHotContainers = addDuoContainers(shiftY, icon1: UIImage(named:"cold"), icon2: UIImage(named:"hot"))
        shiftY += coldAndHotContainers!.0.frame.height + 1
        // GRAVITY
        let col3W = frame.width/3
        gravityContainers = addTrioContainers(shiftY, icon1: UIImage(named:"gravity"), icon2: nil, icon3: nil, cw1: col3W, cw2: col3W, cw3: col3W)
        shiftY += gravityContainers!.0.frame.height + 1
        // MATCHES
        let col5W = frame.width/5
        // 0
        matches0Containers = addTrioContainers(shiftY, icon1: nil, icon2: nil, icon3: nil, cw1: col5W, cw2: col5W*2, cw3: col5W*2)
        shiftY += matches0Containers!.0.frame.height + 1
        // 1
        matches1Containers = addTrioContainers(shiftY, icon1: nil, icon2: nil, icon3: nil, cw1: col5W, cw2: col5W*2, cw3: col5W*2)
        shiftY += matches1Containers!.0.frame.height + 1
        // 2
        matches2Containers = addTrioContainers(shiftY, icon1: nil, icon2: nil, icon3: nil, cw1: col5W, cw2: col5W*2, cw3: col5W*2,
                                               initialColor: UIColor(hex: 0x2e7b4f))
        shiftY += matches2Containers!.0.frame.height + 1
        // 3
        matches3Containers = addTrioContainers(shiftY, icon1: nil, icon2: nil, icon3: nil, cw1: col5W, cw2: col5W*2, cw3: col5W*2,
                                               initialColor: UIColor(hex: 0xc6d700))
        shiftY += matches3Containers!.0.frame.height + 1
        // 4
        matches4Containers = addTrioContainers(shiftY, icon1: nil, icon2: nil, icon3: nil, cw1: col5W, cw2: col5W*2, cw3: col5W*2,
                                               initialColor: UIColor(hex: 0xd7ac39))
        shiftY += matches4Containers!.0.frame.height + 1
        // 5
        matches5Containers = addTrioContainers(shiftY, icon1: nil, icon2: nil, icon3: nil, cw1: col5W, cw2: col5W*2, cw3: col5W*2,
                                               initialColor: UIColor(hex: 0xd78a39))
        shiftY += matches5Containers!.0.frame.height + 1
        // initial
        matches0Containers?.h.updateLabel("0:")
        matches1Containers?.h.updateLabel("1:")
        matches2Containers?.h.updateLabel("2:")
        matches3Containers?.h.updateLabel("3:")
        matches4Containers?.h.updateLabel("4:")
        matches5Containers?.h.updateLabel("5:")
        
        matches0Containers?.l.label?.label?.font = matches0Containers!.l.label!.label!.font.fontWithSize(13)
        matches1Containers?.l.label?.label?.font = matches1Containers!.l.label!.label!.font.fontWithSize(13)
        matches2Containers?.l.label?.label?.font = matches2Containers!.l.label!.label!.font.fontWithSize(13)
        matches3Containers?.l.label?.label?.font = matches3Containers!.l.label!.label!.font.fontWithSize(13)
        matches4Containers?.l.label?.label?.font = matches4Containers!.l.label!.label!.font.fontWithSize(13)
        matches5Containers?.l.label?.label?.font = matches5Containers!.l.label!.label!.font.fontWithSize(13)
        
        // OTHER
        
        /*otherStatsLabel = UIVerticalAlignLabel(frame: CGRect(x: 5, y: shiftY+5, width: Conf.BET_GRID_SIZE-5, height: Conf.BET_GRID_SIZE+5))
        otherStatsLabel!.numberOfLines = 0
        otherStatsLabel!.verticalAlignment = .VerticalAlignmentTop
        otherStatsLabel!.text = ""
        otherStatsLabel!.textColor = UIColor.whiteColor()
        addSubview(otherStatsLabel!)*/
        
        // INITIAL VALUES
        updateSum(0)
        updateOddEven(0, evenNum: 0)
        updateAverageAndColdHot(0, cold: 0, hot: 0)
        updateGravity(0, clusterMid: 0, clusterLow: 0)
        updateMatches((0,0,0,0,0,0), machineNumCounts: (0,0,0,0,0,0))
    }
    
    // MARK: - Factories
    
    func addDuoContainers(yPos:CGFloat, icon1:UIImage?, icon2:UIImage?) -> DuoContainers {
        // 1
        let c1 = ColoredContainer(frame: CGRect(x: 0, y: yPos, width: frame.width/2, height: 30))
        c1.addUI(CGRect(x: 20, y: 5, width: 20, height: 20),
                            iconImage: icon1,
                            color: UIColor.whiteColor(),
                            gap: 10)
        addSubview(c1)
        
        // 2
        let c2 = ColoredContainer(frame: CGRect(x: frame.width/2, y: yPos, width: frame.width/2, height: 30))
        c2.addUI(CGRect(x: 20, y: 5, width: 20, height: 20),
                             iconImage: icon2,
                             color: UIColor.whiteColor(),
                             gap: 10)
        addSubview(c2)
        return (c1, c2)
    }
    
    func addTrioContainers(yPos:CGFloat, icon1:UIImage?, icon2:UIImage?, icon3:UIImage?, cw1:CGFloat, cw2:CGFloat, cw3:CGFloat, initialColor:UIColor? = nil) -> TrioContainers {
        // 1
        let h = ColoredContainer(frame: CGRect(x: 0, y: yPos, width: cw1, height: 30))
        h.addUI(CGRect(x: icon1 == nil ? 35 : 5, y: 5, width: 20, height: 20),
                 iconImage: icon1,
                 color: UIColor.whiteColor(),
                 gap: 5)
        addSubview(h)
        // 2
        let m = ColoredContainer(frame: CGRect(x: cw1, y: yPos, width: cw2, height: 30))
        m.addUI(CGRect(x: 35, y: 5, width: 20, height: 20),
                 iconImage: icon2,
                 color: UIColor.whiteColor(),
                 gap: 5)
        addSubview(m)
        // 3
        let l = ColoredContainer(frame: CGRect(x: cw1+cw2, y: yPos, width: cw3, height: 30))
        l.addUI(CGRect(x: 35, y: 5, width: 20, height: 20),
                 iconImage: icon3,
                 color: UIColor.whiteColor(),
                 gap: 5)
        addSubview(l)
        
        if let ic = initialColor {
            h.backgroundColor = ic
            m.backgroundColor = ic
            l.backgroundColor = ic
        }
        
        return (h: h, m: m, l: l)
    }
    
    // MARK: - Updates
    
    func updateOddEven(oddNum:Int, evenNum:Int) {
        oddAndEvenContainers?.0.updateLabel("\(oddNum)")
        oddAndEvenContainers?.1.updateLabel("\(evenNum)")
        oddAndEvenContainers?.0.updateColor(AnalysisManager.isOddNumberGood(oddNum))
        oddAndEvenContainers?.1.updateColor(AnalysisManager.isEvenNumberGood(evenNum))
    }
    
    func updateSum(value:Int) {
        //print("------- UPDATE SUM \(value)")
        sumContainer?.updateColor(AnalysisManager.isSumGood(value))
        sumContainer?.updateLabel("\(value)")
    }
    
    func updateAverageAndColdHot(value:Double, cold:Int, hot:Int) {
        averageContainer?.updateColor(AnalysisManager.isAverageDistanceGood(value))
        averageContainer?.updateLabel(value.format())
        coldAndHotContainers?.0.updateColor(AnalysisManager.isColdNumberGood(cold))
        coldAndHotContainers?.0.updateLabel("\(cold)")
        coldAndHotContainers?.1.updateColor(AnalysisManager.isHotNumberGood(hot))
        coldAndHotContainers?.1.updateLabel("\(hot)")
    }
    
    func updateGravity(clusterHigh:Int, clusterMid:Int, clusterLow:Int){
        //print("GRAVITY \(clusterHigh) = \(clusterMid) = \(clusterLow)")
        gravityContainers!.h.updateColor(AnalysisManager.isClusterHighGood(clusterHigh))
        gravityContainers!.h.updateLabel("\(clusterHigh)")
        gravityContainers?.m.updateColor(AnalysisManager.isClusterMidGood(clusterMid))
        gravityContainers?.m.updateLabel("\(clusterMid)")
        gravityContainers?.l.updateColor(AnalysisManager.isClusterLowGood(clusterLow))
        gravityContainers?.l.updateLabel("\(clusterLow)")
    }
    
    func updateMatches(numCounts:NumCounts, machineNumCounts:NumCounts) {
        matches0Containers?.m.updateLabel("\(numCounts.0)")
        matches1Containers?.m.updateLabel("\(numCounts.1)")
        matches2Containers?.m.updateLabel("\(numCounts.2)")
        matches3Containers?.m.updateLabel("\(numCounts.3)")
        matches4Containers?.m.updateLabel("\(numCounts.4)")
        matches5Containers?.m.updateLabel("\(numCounts.5)")
        
        // TODO 0-1459
        matches0Containers?.l.updateLabel("(\(machineNumCounts.0))")
        matches1Containers?.l.updateLabel("(\(machineNumCounts.1))")
        matches2Containers?.l.updateLabel("(\(machineNumCounts.2))")
        matches3Containers?.l.updateLabel("(\(machineNumCounts.3))")
        matches4Containers?.l.updateLabel("(\(machineNumCounts.4))")
        matches5Containers?.l.updateLabel("(\(machineNumCounts.5))")
    }
    

}
