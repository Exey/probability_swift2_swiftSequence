//
//  MapRowTableViewCell.swift
//  Lotto
//
//  Created by Exey Panteleev on 13/03/16.
//  Copyright © 2016 Mozgazm. All rights reserved.
//

import UIKit

class MapRowTableViewCell: UITableViewCell {

    // UI
    var mapRowView:MapRowView?
    
    // Data
    var combinationData:CombinationData?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layoutIfNeeded()
        
        backgroundColor = UIColor.clearColor()
        
        
        if (mapRowView != nil) {
            mapRowView?.removeFromSuperview()
        }
        
        mapRowView = MapRowView(frame: contentView.frame)
        //print("========== \(frame)")
        mapRowView!.addColorsByMatrixRowData(combinationData!)
        contentView.addSubview(mapRowView!)
    }
    
    func build(combinationData:CombinationData) {
        self.combinationData = combinationData
        
    }

}
