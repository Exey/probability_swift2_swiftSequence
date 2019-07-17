//
//  TabBarController.swift
//  Lotto
//
//  Created by Exey Panteleev on 07/06/16.
//  Copyright © 2016 Mozgazm. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // update first item
        dispatch_async(dispatch_get_main_queue()) {
            self.setSelection(self.tabBar.selectedItem!)
        }
    }
    
    // MARK: - UITabBarDelegate handlers
    
    override func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        clearSelections()
        setSelection(item)
    }
    
    // MARK: - Selection Methods
    
    func setSelection(item:UITabBarItem) {
        dispatch_async(dispatch_get_main_queue()) {
            for i in 0..<self.tabBar.items!.count {
                let ii = self.tabBar.items![i]
                if(item == ii) {
                    let sv = self.tabBar.subviews[i+1]
                    let label:UILabel =  sv.subviews[1] as! UILabel
                    print("didSelectItem \(label.text) = \(ii.title)")
                    sv.backgroundColor = StyleManager.COLOR_PROBABILITIES[0]
                }
            }
        }
    }
    
    func clearSelections() {
        for s in tabBar.subviews {
            s.backgroundColor = UIColor.clearColor()
        }
    }
    
}
