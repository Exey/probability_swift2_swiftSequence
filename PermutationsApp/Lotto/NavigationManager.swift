//
//  NavigationManager.swift
//  Lotto
//
//  Created by Exey Panteleev on 27/03/16.
//  Copyright © 2016 Mozgazm. All rights reserved.
//

import UIKit
import Alamofire

class NavigationManager {
    
    static var navigationController:UINavigationController?
    
    static func addTitle() {
        //self.title = "5x36"
        navigationController!.navigationBar.topItem!.title = "5x36"
    }
    
}