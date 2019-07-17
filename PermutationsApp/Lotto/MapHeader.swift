//
//  MapHeader.swift
//  Lotto
//
//  Created by Exey Panteleev on 18/04/16.
//  Copyright © 2016 Mozgazm. All rights reserved.
//

import UIKit

class MapHeader:UIView {
    
    var probabilityRow:MapRowView?
    //var averageDistancesRow:MapRowView?
    var makaraovChainRow:MapRowView?
    var hotNumbersRow:MapRowView?
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    func addRows(size:CGFloat) {
        
        var shiftY:CGFloat = 0
        
        /*probabilityRow = MapRowView(frame: CGRect(x: 0, y: shiftY, width: frame.width, height: size))
        probabilityRow?.probableProbability()
        shiftY += (probabilityRow?.frame.height)!
        probabilityRow?.layer.addBorder(.Bottom, color: UIColor(hex: 0xefeff4), thickness: 1)
        addSubview(probabilityRow!)*/
        
        /*makaraovChainRow = MapRowView(frame: CGRect(x: 0, y: shiftY, width: frame.width, height: size))
        makaraovChainRow?.addMakarovChainProbability()
        shiftY += (makaraovChainRow?.frame.height)!
        makaraovChainRow?.layer.addBorder(.Bottom, color: StyleManager.COLOR_LIGHT_GRAY2, thickness: 1)
        addSubview(makaraovChainRow!)*/
        
        /*averageDistancesRow = MapRowView(frame: CGRect(x: 0, y: shiftY, width: frame.width, height: size))
        averageDistancesRow?.addAverageHotNumbers()
        shiftY += (averageDistancesRow?.frame.height)!
        averageDistancesRow?.layer.addBorder(.Bottom, color: StyleManager.COLOR_LIGHT_GRAY2, thickness: 1)
        addSubview(averageDistancesRow!)*/
        
        hotNumbersRow = MapRowView(frame: CGRect(x: 0, y: shiftY, width: frame.width, height: size))
        hotNumbersRow?.addHotNumbers()
        addSubview(hotNumbersRow!)
        
    }
    
}