//
//  ImageManager
//  Created by Exey Panteleev
//

import Foundation
import UIKit

struct ImageManager {
    
    static var cache = NSCache()
    
    static func loadImage(url: String, completionHandler:(image: UIImage?, url: String) -> ()) {
        if (url != "") {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) {
                // Try get from cache
                let data: NSData? = self.cache.objectForKey(url) as? NSData
                if let existData = data {
                    let image = UIImage(data: existData)
                    dispatch_async(dispatch_get_main_queue(), {() in
                        completionHandler(image: image, url: url)
                    })
                    return
                }
                // Or Load
                
                // Add NSURLSession Way
                
                // Alamofire Way
                /*Alamofire.manager.request(.GET, url).response({ request, response, data, error in
                    // Error
                    if error != nil {
                        completionHandler(image: nil, url: url)
                        return
                    }
                    // Success
                    if data != nil {
                        let image = UIImage(data: data as! NSData)
                        self.cache.setObject(data!, forKey: url)
                        dispatch_async(dispatch_get_main_queue(), {() in
                            completionHandler(image: image, url: url)
                        })
                        return
                    }

                })*/
            }
        }
    }
    
}