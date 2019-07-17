//
//  MapRowView.swift
//  Lotto
//
//  Created by Exey Panteleev on 13/03/16.
//  Copyright © 2016 Mozgazm. All rights reserved.
//

import UIKit

typealias MapColumnFactory = (index:Int, col:MapRowCol)->()

class MapRowView: HBox {
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    // MARK: - API
    
    func addCols(firstCol: (setCol:Bool, label:String), count:Int, colFactory:MapColumnFactory) {
        let size = frame.width / (CGFloat(count) + 1)
        let colDrawNumber = createCol(size*2, h: size)
        add(colDrawNumber)
        if firstCol.label.characters.count > 0 {
            colDrawNumber.setLabel(firstCol.label, color:UIColor.grayColor())
        }
        for i in (0..<count) {
            let c = createCol(size, h: size)
            if i == 0 {
                c.setColor(UIColor.clearColor())
            } else {
                colFactory(index: i, col: c)
            }
            add(c)
        }
        arrange(size, cols: count + 1)
    }
    
    func createCol(w:CGFloat, h:CGFloat)->MapRowCol {
        let c = MapRowCol(frame: CGRect(x: 0, y: 0, width: w, height: h))
        return c
    }
    
    // MAPS
    
    func addColorsByMatrixRowData(cd:CombinationData){
        
        addCols((true, "\(cd.drawNumber)"), count: cd.matrixRow.count) { i, c in
            let r = cd.matrixRow[i]
            if r > 0 {
                c.setColor(StyleManager.COLOR_MINT_GREEN)
                c.setLabel("\(r)", color: StyleManager.COLOR_MAP_SQUARE)
            } else {
                c.setColor(UIColor.grayColor())
            }
        }
    }
    
    // BUTTON-NUMBERS
    
    var selectedCol:MapRowCol?
    
    func addNumberButtons(onTap:(value:Int)->()) {
        
        addCols((false, ""), count: Conf.MAX_LOTTO_VALUE) { i, c in
            c.setColor(UIColor.grayColor())
            c.layer.addBorder(UIRectEdge.Left, color: UIColor.whiteColor(), thickness: 1)
            print("==== \(i) == \(c)")
            c.setLabel("\(Int(i))", color: UIColor.whiteColor())
            c.label?.font = c.label!.font.fontWithSize(12)
            let tgr = UITapGestureRecognizer { gr in
                // unselect
                self.selectedCol?.setColor(UIColor.grayColor())
                self.selectedCol?.label?.textColor = UIColor.whiteColor()
                // select
                let col = gr.view as! MapRowCol
                onTap(value: Int(col.label!.text!)!)
                col.setColor(UIColor.yellowColor())
                col.label?.textColor = UIColor.blackColor()
                self.selectedCol = col
            }
            c.addGestureRecognizer(tgr)
        }
        
    }
    
    // HOT NUMBERS
    
    func addHotNumbers() {
        
        //var maxNum = DataManager.currentDistances.reduce(-1, combine: { max($0, $1) })
        
        
        addCols((true, ""), count: DataManager.distancies!.currentDistances.count) { i, c in
            let d = DataManager.distancies!.currentDistances[i]
            
            let cc = StyleManager.getHotColorByDistance(d, maxDistance: Conf.HOT_DISTANCE)
            c.setColor(cc)
            
            c.setLabel("\(Int(d))", color: UIColor.whiteColor())
            c.label?.font = c.label!.font.fontWithSize(12)
        }
        
        // design
        layer.addBorder(UIRectEdge.Bottom, color: StyleManager.COLOR_LIGHT_GRAY2, thickness: 1)
        
        let coldIcon = UIImageView(image: UIImage(named: "cold")!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate))
        coldIcon.frame.origin.y = -2
        coldIcon.tintColor = StyleManager.COLOR_COLD
        let hotIcon  = UIImageView(image: UIImage(named: "hot")!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate))
        hotIcon.contentMode = UIViewContentMode.ScaleAspectFit
        hotIcon.frame = CGRect(x: 30, y: 3, width: frame.height*0.85, height: frame.height*0.85)
        hotIcon.tintColor = StyleManager.HOT_COLD
        
        addSubview(coldIcon)
        addSubview(hotIcon)
        
    }
    
    // MARK: - EXPERIMENTAL
    
    /*func addMakarovChainProbability() {
        
       //var mcd = MakarovChainData(startDraw: DataManager.draws!.count-100, endDraw: DataManager.draws!.count)
        var mcd = MakarovChainData(startDraw: Conf.PRNG_START_DRAW, endDraw: DataManager.draws!.count)
        mcd.buildTransitionTable()
        let predict = mcd.getPredictionByLastCombination(DataManager.draws![0])
        
        var minVal = Int.max
        for p in 1..<predict.count { minVal = min(minVal, predict[p]) }
        let maxVal = Double(predict.maxElement()!)
        
        
        addCols((true, ""), count: DataManager.distancies!.currentDistances.count) { i, c in
            
            let d = Double(predict[i])
            
            var dd = Double(d) / maxVal
            
            let cc = StyleManager.getColorByValue(d, minVal:Double(minVal), maxVal: maxVal, colorMin: 0xbebebe, colorMax: 0x232323)
            c.setColor(cc)
            c.layer.addBorder(UIRectEdge.Left, color: StyleManager.COLOR_LIGHT_GRAY2, thickness: 1)
            
            c.setLabel(dd.format("%.2f"), color: UIColor.whiteColor())
            c.label?.font = c.label!.font.fontWithSize(11)
            
            if AnalysisManager.isBetweenDrawsChainGood(dd) {
                c.setColor(StyleManager.COLOR_MAP_SQUARE)
            }
            
        }
    }*/
    
    /*
    func addAverageHotNumbers()  {
        
        let minVal = DataManager.distancies!.averageDistPerValue.reduce(1000, combine: { $0 == -1 ? 1000 : min($0, $1) })
        let maxVal = DataManager.distancies!.averageDistPerValue.maxElement()!
        
        addCols("", count: DataManager.distancies!.currentDistances.count) { i, c in
            //print("ADD COL \(i)")
            let d = DataManager.distancies!.averageDistPerValue[i]
            
            let cc = StyleManager.getColorByValue(d, minVal:minVal, maxVal: maxVal, colorMin: 0xbebebe, colorMax: 0x232323)
            c.setColor(cc)
            c.layer.addBorder(UIRectEdge.Left, color: StyleManager.COLOR_LIGHT_GRAY2, thickness: 1)
            
            c.setLabel("\(d.format("%.2f"))", color: UIColor.whiteColor())
            c.label?.font = c.label!.font.fontWithSize(11)
        }
    }
    
    func probableProbability()  {
        
        var pp = [Double](count: Conf.MAX_LOTTO_VALUE, repeatedValue: -1)
        for ii in 1..<pp.count {
            let freq = DataManager.allFrequencies!.values[ii]
            let averDist = DataManager.distancies!.averageDistPerValue[ii]
            let drawsCount = DataManager.draws!.count
            pp[ii] = Double(freq) * averDist / Double(drawsCount)
            print("PP \(ii) = \(drawsCount) = \(pp[ii])")
        }
        
        let minVal = pp.reduce(1000, combine: { $0 == -1 ? 1000 : min($0, $1) })
        let maxVal = pp.maxElement()!
        
        addCols("", count: DataManager.distancies!.currentDistances.count) { i, c in
            //print("ADD COL \(i)")
            let d = pp[i]
            
            let cc = StyleManager.getColorByValue(d, minVal:minVal, maxVal: maxVal, colorMin: 0xbebebe, colorMax: 0x232323)
            c.setColor(cc)
            c.layer.addBorder(UIRectEdge.Left, color: StyleManager.COLOR_LIGHT_GRAY2, thickness: 1)
            
            c.setLabel("\(d.format("%.2f"))", color: UIColor.whiteColor())
            c.label?.font = c.label!.font.fontWithSize(11)
        }
    }
    */

}
