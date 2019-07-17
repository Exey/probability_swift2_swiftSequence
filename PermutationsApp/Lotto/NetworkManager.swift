//
//  NetworkManager.swift
//  Lotto
//
//  Created by Exey Panteleev on 27/03/16.
//  Copyright © 2016 Mozgazm. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static func loadStats(onComplete:(drawsArray:[String])->()) {
        
        // remove cache
        if Reachability.isConnectedToNetwork() {
            NSURLCache.sharedURLCache().removeAllCachedResponses()
        }
            
        Alamofire.request(.GET, "https://mozgazm.com/lotto/5x36.txt").responseString { response in
            // deserialize
            let drawsString = response.result.value
            let drawsArray = drawsString?.componentsSeparatedByString("\r\n")
            onComplete(drawsArray: drawsArray!)
            
        }
    }
    
}