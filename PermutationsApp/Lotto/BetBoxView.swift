//
//  BetBoxView.swift
//  Lotto
//
//  Created by Exey Panteleev on 22/03/16.
//  Copyright © 2016 Mozgazm. All rights reserved.
//

import UIKit

class BetBoxView: UIView {
    
    // UI
    var grid:Grid?
    var statsView:BetStatsView?
    
    // data
    var boxIndex:Int = -1
    var delegate:BetsCtrlDelegate?
    
    var selectedNumbers:[Int] {
        var result = [Int]()
        for el in grid!.elements! {
            let nb = el as! NumberButton
            if nb.selected {
                let number = Int(nb.titleLabel!.text!)!
                result.append(number)
            }
        }
        return result
    }
    
    /* Constructor */
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    // MARK: - API
    
    func addGrid(h:CGFloat) {
        grid = Grid(frame: CGRect(x: 0, y: 0, width: Conf.BET_GRID_SIZE, height: Conf.BET_GRID_SIZE))
        
        for i in 1 ..< Conf.MAX_LOTTO_VALUE {
            let b = createButton("\(i)")
            grid?.add(b)
        }
        grid?.arrange(Conf.BET_BOX_BUTTON_SIZE, tileSizeY: Conf.BET_BOX_BUTTON_SIZE, cols: 6, gapX: 0)
        addSubview(grid!)
        grid?.userInteractionEnabled = true
        //print("addGrid \(grid?.frame)")
        grid?.layer.addBorder(.Bottom, color: UIColor.whiteColor(), thickness: 1)
    }
    
    func createButton(label:String)->NumberButton {
        //print(label)
        let nb = NumberButton(frame: CGRect(x: 0, y: 0, width: Conf.BET_BOX_BUTTON_SIZE, height: Conf.BET_BOX_BUTTON_SIZE))
        nb.setTitle(label, forState: UIControlState.Normal)
        nb.userInteractionEnabled = true
        nb.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(BetBoxView.didTapButton(_:))))
        return nb
    }
    
    func addStatsView() {
        let h = frame.height - Conf.BET_GRID_SIZE
        statsView = BetStatsView(frame: CGRect(x: 0, y: Conf.BET_GRID_SIZE, width: frame.width, height: h))
        addSubview(statsView!)
    }
    
    // MARK: - Handlers
    
    func didTapButton(gesture: UIGestureRecognizer) {
        let sn = selectedNumbers
        let nb = gesture.view as! NumberButton
        
        // LIMIT SELECTED
        if sn.count >= Conf.BET_BOX_MAX_SELECTED && !nb.selected {
            return
        }
        
        //nb.state = nb.state == .Selected ? .Selected : .Normal
        nb.updateSelection()
        print("didTapButton \(nb.titleLabel?.text)")
        
        // update model
        print("SELECTED \(selectedNumbers)")
        delegate?.betsChanged(boxIndex, selectedNumbers: selectedNumbers)
        
    }
    

}
