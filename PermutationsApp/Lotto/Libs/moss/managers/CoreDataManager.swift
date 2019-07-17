//
//  CoreDataManager.swift
//  Created by Exey Panteleev on 20/04/15.
//

import Foundation
import CoreData

struct CoreDataManager {
    
    static var GlobalMainQueue: dispatch_queue_t {
        return dispatch_get_main_queue()
    }
    /*
    static var GlobalUserInteractiveQueue: dispatch_queue_t {
        return dispatch_get_global_queue(Int(QOS_CLASS_USER_INTERACTIVE.value), 0)
    }
    
    static var GlobalUserInitiatedQueue: dispatch_queue_t {
        return dispatch_get_global_queue(Int(QOS_CLASS_USER_INITIATED.value), 0)
    }
    
    static var GlobalUtilityQueue: dispatch_queue_t {
        return dispatch_get_global_queue(Int(QOS_CLASS_UTILITY.value), 0)
    }
    
    static var GlobalBackgroundQueue: dispatch_queue_t {
        return dispatch_get_global_queue(Int(QOS_CLASS_BACKGROUND.value), 0)
    }
    
    static var context:NSManagedObjectContext?
    
    static func initApllicationContext() {
        CoreDataManager.context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
    }
    
    static func fetch(entityName:String, var context:NSManagedObjectContext? = nil)->[AnyObject]? {
        if(context == nil) { context = CoreDataManager.context } // Get local if nil
        let fetchRequest = NSFetchRequest(entityName: entityName)
        var err:NSError?
        let fetchResult = context!.executeFetchRequest(fetchRequest, error: &err)
        return fetchResult
    }
    
    static func createEntityAndObject(name:String, var context:NSManagedObjectContext? = nil)->(NSEntityDescription, NSManagedObject) {
        if(context == nil) { context = CoreDataManager.context } // Get local if nil
        let entity = NSEntityDescription.entityForName(name, inManagedObjectContext: context!)
        let obj = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: context!)
        return (entity!, obj)
    }
    
    static func delete(obj:NSManagedObject, var context:NSManagedObjectContext? = nil) {
        if(context == nil) { context = CoreDataManager.context } // Get local if nil
        //println("CoreDataManager/delete \(obj)")
        context!.deleteObject(obj)
        save()
    }
    
    static func save(var context:NSManagedObjectContext? = nil) {
        if(context == nil) { context = CoreDataManager.context } // Get local if nil
        var err:NSError?
        if !context!.save(&err) {
            print("ERROR \(err)")
        }
    }
    */
}