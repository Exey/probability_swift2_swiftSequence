//
//  GestureUtil.swift
//  Blandly
//
//  Created by Exey on 14/09/14.
//  Copyright (c) 2014 MPL. All rights reserved.
//

import Foundation
import UIKit

public struct GestureUtil {
    
    static public func addTap(tappable:UIView, target:AnyObject, action:Selector)->UITapGestureRecognizer {
        let recognizer = UITapGestureRecognizer(target: target, action:action)
        tappable.addGestureRecognizer(recognizer)
        return recognizer
    }
    
    static public func addSwipes(swipeable:UIView, target:AnyObject, action:Selector, directions:[UISwipeGestureRecognizerDirection] = [.Up, .Right, .Down, .Left]) {
        for d in directions {
            let swipe = UISwipeGestureRecognizer(target: target, action: action)
            swipe.numberOfTouchesRequired = 1
            swipe.direction = d
            swipeable.addGestureRecognizer(swipe)
        }
    }
    
}