//
//  AmalgamTableViewCell.swift
//  Lotto
//
//  Created by Exey Panteleev on 30/04/16.
//  Copyright © 2016 Mozgazm. All rights reserved.
//

import UIKit

class AmalgamTableViewCell: UITableViewCell {

    var countContainer:ColoredContainer?
    var numbersContainers:[ColoredContainer]?
    
    /*override var layoutMargins: UIEdgeInsets {
        return UIEdgeInsetsZero
    }*/
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        separatorInset = UIEdgeInsetsZero
        layoutMargins = UIEdgeInsetsZero
        preservesSuperviewLayoutMargins = false
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func update(count:Int, nums:[Int], selected:[Int]) {
        clean()
        
        var shiftX:CGFloat = 0
        
        // count
        countContainer = ColoredContainer(frame: CGRect(x: shiftX, y: 0, width: 60, height: frame.height))
        countContainer!.addUI( CGRect(x: 3, y: 0, width: 40, height: frame.height),
                                         iconImage: nil,
                                         color: UIColor.whiteColor(),
                                         gap: 0)
        
        let a = AnalysisManager.pairPriority(count)
        countContainer?.backgroundColor = StyleManager.COLORS_PAIRS[a]
        
        
        countContainer?.updateLabel("\(count)")
        countContainer?.label?.autoSize()
        countContainer?.label?.label!.textAlignment = NSTextAlignment.Center
        contentView.addSubview(countContainer!)
        shiftX += countContainer!.frame.width + 1
        
        // numbers
        numbersContainers = [ColoredContainer]()
        for n in 0..<nums.count {
            
            let c = ColoredContainer(frame: CGRect(x: shiftX, y: 0, width: 60, height: frame.height))
            c.addUI( CGRect(x: 3, y: 0, width: 40, height: frame.height),
                     iconImage: nil,
                     color: UIColor.whiteColor(),
                     gap: 0)
            contentView.addSubview(c)
            
            // caclulate color
            let v = nums[n]
            c.backgroundColor = StyleManager.getHotColorByDistance(DataManager.distancies!.currentDistances[v], maxDistance: Conf.HOT_DISTANCE)
            c.updateLabel("\(v)")
            c.label?.autoSize()
            c.label?.label!.textAlignment = NSTextAlignment.Center
            numbersContainers?.append(c) // add to array
            
            // selection
            if selected.contains(v) {
                c.borderSelected = true
            } else {
                c.borderSelected = false
            }
            
            
            shiftX += c.frame.width + 1
            
        }
        
    }
    


    func clean() {
        while contentView.subviews.count > 0 {
            contentView.subviews[0].removeFromSuperview()
        }
    }
    
}
