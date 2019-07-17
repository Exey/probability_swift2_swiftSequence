//
//  DistancesTableViewCell.swift
//  Lotto
//
//  Created by Exey Panteleev on 05/04/16.
//  Copyright © 2016 Mozgazm. All rights reserved.
//

import UIKit

class DistancesTableViewCell: UITableViewCell {
    
    // UI
    var drawNumberLabel:UILabel?
    var numberCols:[DistanceNumberCol]?
    var averageDistanceContainer:ColoredContainer?
    var coldContainer:ColoredContainer?
    var hotContainer:ColoredContainer?
    var sumContainer:ColoredContainer?
    var oddContainer:ColoredContainer?
    var evenContainer:ColoredContainer?
    
    var pairs0Container:ColoredContainer?
    var pairs1Container:ColoredContainer?
    var pairs2Container:ColoredContainer?
    
    var otherLabel:UILabel?
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        //backgroundColor = StyleManager.COLOR_LIGHT_GRAY2
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - API
    
    func update(cd:CombinationData) {
        clean()
        
        drawNumberLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 60, height: frame.height))
        drawNumberLabel?.textAlignment = NSTextAlignment.Center
        drawNumberLabel?.text = "\(cd.drawNumber)"
        contentView.addSubview(drawNumberLabel!)
        
        var shiftX:CGFloat = 60
        
        numberCols = [DistanceNumberCol]()
        for i in 0..<cd.values.count {
            let v = cd.values[i]
            let dv = cd.distanciesPerValue[i]
            
            let dnc = DistanceNumberCol(frame: CGRect(x: shiftX, y: 0, width: 50, height: frame.height))
            dnc.create(v, bottomValue: dv)
            numberCols?.append(dnc)
            contentView.addSubview(dnc)
            shiftX += 50
        }
        
        // AVERAGE
        averageDistanceContainer = ColoredContainer(frame: CGRect(x: shiftX+1, y: 0, width: 60, height: frame.height))
        
        averageDistanceContainer!.addUI( CGRect(x: 3, y: 10, width: 40, height: 20),
                                         iconImage: UIImage(named:"average")!,
                                         color: UIColor.whiteColor(),
                                         gap: 1)
        contentView.addSubview(averageDistanceContainer!)
        shiftX += 1 + averageDistanceContainer!.frame.width
        
        //let adc = averageDistanceContainer
        //print("AVRG \(adc!.frame) = \(adc!.label!.frame) = \(adc!.label!.label!.frame) = \(adc!.label!.icon!.frame)")
        
        averageDistanceContainer?.updateLabel(cd.averageDistance.format())
        averageDistanceContainer?.updateColor(AnalysisManager.isAverageDistanceGood(cd.averageDistance))
        
        let cah = cd.coldAndHot
        
        // COLD
        
        coldContainer = ColoredContainer(frame: CGRect(  x: shiftX + 1, y: 0, width: 60, height: frame.height))
        coldContainer?.addUI(CGRect( x: 10, y: 10, width: 20, height: 20),
                                     iconImage: UIImage(named:"cold")!,
                                     color: UIColor.whiteColor(),
                                     gap: 10)
        addSubview(coldContainer!)
        
        shiftX += 1 + coldContainer!.frame.width
        
        coldContainer?.updateLabel("\(cah.0)")
        coldContainer?.updateColor(AnalysisManager.isColdNumberGood(cah.0))
        
        // HOT
        
        hotContainer = ColoredContainer(frame: CGRect(  x: shiftX + 1, y: 0, width: 60, height: frame.height))
        hotContainer?.addUI(CGRect( x: 10, y: 10, width: 20, height: 20),
                             iconImage: UIImage(named:"hot")!,
                             color: UIColor.whiteColor(),
                             gap: 10)
        addSubview(hotContainer!)
        
        shiftX += 1 + hotContainer!.frame.width
        
        hotContainer?.updateLabel("\(cah.1)")
        hotContainer?.updateColor(AnalysisManager.isHotNumberGood(cah.1))
        
        // SUM
        
        sumContainer = ColoredContainer(frame: CGRect(  x: shiftX + 1, y: 0, width: 60, height: frame.height))
        sumContainer!.addUI( CGRect( x: 5, y: 10, width: 20, height: 20),
                                     iconImage: UIImage(named:"sum")!,
                                     color: UIColor.whiteColor(),
                                     gap: 2)
        contentView.addSubview(sumContainer!)
        
        shiftX += 1 + sumContainer!.frame.width
        
        sumContainer?.updateLabel("\(cd.sum)")
        sumContainer?.updateColor(AnalysisManager.isSumGood(cd.sum))
        
        let oae = cd.oddAndEven
        
        // ODD
        
        oddContainer = ColoredContainer(frame: CGRect(  x: shiftX + 1, y: 0, width: 60, height: frame.height))
        oddContainer?.addUI(CGRect( x: 10, y: 10, width: 20, height: 20),
                                    iconImage: UIImage(named:"circle-half")!,
                                    color: UIColor.whiteColor(),
                                    gap: 10)
        addSubview(oddContainer!)
        
        shiftX += 1 + oddContainer!.frame.width
        
        oddContainer?.updateLabel("\(oae.0)")
        oddContainer?.updateColor(AnalysisManager.isOddNumberGood(oae.0))
        
        // EVEN
        
        evenContainer = ColoredContainer(frame: CGRect(  x: shiftX + 1, y: 0, width: 60, height: frame.height))
        evenContainer?.addUI(CGRect(x: 10, y: 10, width: 20, height: 20),
                                    iconImage: UIImage(named:"circle-double")!,
                                    color: UIColor.whiteColor(),
                                    gap: 10)
        addSubview(evenContainer!)
        
        shiftX += 1 + evenContainer!.frame.width
        
        evenContainer?.updateLabel("\(oae.1)")
        evenContainer?.updateColor(AnalysisManager.isOddNumberGood(oae.1))
        
        // PAIRS
        
        shiftX += 2
        
        let pc = cd.pairsClustered
        
        //let ww:CGFloat = 115
        let ww:CGFloat = 60
        
        // 0
        pairs0Container = ColoredContainer(frame: CGRect(x: shiftX, y: 0, width: ww, height: frame.height))
        pairs0Container!.addUI(  CGRect(x: 10, y: 10, width: 20, height: 20),
                                 iconImage: UIImage(named:"gravity"),
                                 color: UIColor.whiteColor(),
                                 gap: 0)
        //pairs0Container!.backgroundColor = StyleManager.COLORS_PAIRS[0]
        pairs0Container?.updateColor(AnalysisManager.isClusterHighGood(pc.c0.count))
        //let pcs0 = pc.c0.map{"\($0.comb)"}.joinWithSeparator(" ")
        pairs0Container!.updateLabel("\(pc.c0.count)")
        pairs0Container!.label?.label?.frame.origin.x = 0
        pairs0Container!.label?.label?.frame.size.width = ww
        pairs0Container!.label?.label?.numberOfLines = 0
        //pairs0Container!.label?.label?.font = UIFont.systemFontOfSize(11)
        pairs0Container!.label?.label?.textAlignment = NSTextAlignment.Center
        shiftX += 1 + pairs0Container!.frame.width
        addSubview(pairs0Container!)
        
        // 1
        pairs1Container = ColoredContainer(frame: CGRect(x: shiftX, y: 0, width: ww, height: frame.height))
        pairs1Container!.addUI(  CGRect(x: 3, y: 0, width: ww, height: frame.height),
                                 iconImage: nil,
                                 color: UIColor.whiteColor(),
                                 gap: 0)
        //pairs1Container!.backgroundColor = StyleManager.COLORS_PAIRS[1]
        pairs1Container?.updateColor(AnalysisManager.isClusterMidGood(pc.c1.count))
        //let pcs1 = pc.c1.map{"\($0.comb)"}.joinWithSeparator(" ")
        pairs1Container!.updateLabel("\(pc.c1.count)")
        pairs1Container!.label?.label?.frame.origin.x = 0
        pairs1Container!.label?.label?.frame.size.width = ww
        pairs1Container!.label?.label?.numberOfLines = 0
        //pairs1Container!.label?.label?.font = UIFont.systemFontOfSize(10)
        pairs1Container!.label?.label?.textAlignment = NSTextAlignment.Center
        shiftX += 1 + pairs1Container!.frame.width
        addSubview(pairs1Container!)
        
        // 2
        pairs2Container = ColoredContainer(frame: CGRect(x: shiftX, y: 0, width: ww, height: frame.height))
        pairs2Container!.addUI(  CGRect(x: 3, y: 0, width: ww, height: frame.height),
                                 iconImage: nil,
                                 color: UIColor.whiteColor(),
                                 gap: 0)
        //pairs2Container!.backgroundColor = StyleManager.COLORS_PAIRS[2]
        pairs2Container?.updateColor(AnalysisManager.isClusterLowGood(pc.c2.count))
       // let pcs2 = pc.c2.map{"\($0.comb)"}.joinWithSeparator(" ")
        pairs2Container!.updateLabel("\(pc.c2.count)")
        pairs2Container!.label?.label?.frame.origin.x = 0
        pairs2Container!.label?.label?.frame.size.width = ww
        pairs2Container!.label?.label?.numberOfLines = 0
        //pairs2Container!.label?.label?.font = UIFont.systemFontOfSize(11)
        pairs2Container!.label?.label?.textAlignment = NSTextAlignment.Center
        shiftX += 1 + pairs2Container!.frame.width
        addSubview(pairs2Container!)
        
        /*otherLabel = createLabel(shiftX, width: 350)
        let prs = cd.pairs
        otherLabel?.text = "\(prs)"
        otherLabel?.numberOfLines = 0
        otherLabel?.font = UIFont.systemFontOfSize(10)*/
    }
    
    func createLabel(posX:CGFloat, width:CGFloat)->UILabel {
        let lbl = UILabel(frame: CGRect(x: posX, y: 0, width: width, height: frame.height))
        lbl.textAlignment = NSTextAlignment.Center
        addSubview(lbl)
        return lbl
    }
    
    func clean() {
        while contentView.subviews.count > 0 {
            contentView.subviews[0].removeFromSuperview()
        }
    }
    
    /*func update(cd:CombinationData) {
        
        var ranges = [NSRange]()
        
        var s = ""
        for i in 0..<cd.values.count {
            let v = cd.values[i]
            s += String(v)
            let dv = cd.distanciesPerValue[i]
            let ns = String(dv)
            ranges.append(NSRange(location: s.characters.count, length: ns.characters.count))
            s += ns + " "
        }
        
        let vals = cd.values.map{"\($0.formatZeros(2))"}.joinWithSeparator(", ")
        let dists = cd.distanciesPerValue.map{"\($0)"}.joinWithSeparator(", ")
        
        let font:UIFont? = UIFont(name: "Helvetica", size:20)
        let fontSuper:UIFont? = UIFont(name: "Helvetica", size:10)
        let attString:NSMutableAttributedString = NSMutableAttributedString(string: s, attributes: [NSFontAttributeName:font!])
        for r in ranges {
            attString.setAttributes([NSFontAttributeName:fontSuper!,NSBaselineOffsetAttributeName:10], range: r)
        }
        textLabel?.attributedText = attString
        
        //textLabel?.text = "\(cd.drawNumber) - \(vals) - \(dists)"
        
    }*/

}
