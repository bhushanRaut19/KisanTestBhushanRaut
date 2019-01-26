//
//  CoreDataManager.swift
//  Bhushan_Raut_Test
//
//  Created by Bhushan Raut on 23/01/19.
//  Copyright © 2019 Bhushan Raut. All rights reserved.
//

import Foundation
import UIKit
import CoreData

public class CoreDataManagerClass : NSObject{
    
    
    func insertDataInCoreData(WeatherArrayObj : WeatherArray, city : String, metrics : String)
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Weather", in: context)
        print("insertDataInCoreData")
        for weatherObject in WeatherArrayObj
        {
            let newUser = NSManagedObject(entity: entity!, insertInto: context)
            newUser.setValue(String(describing: weatherObject.month!), forKey: "month")
            newUser.setValue(String(describing: weatherObject.year!), forKey: "year")
            newUser.setValue(weatherObject.value, forKey: "value")
            newUser.setValue(city, forKey: "city")
            newUser.setValue(metrics, forKey: "metrics")
        }
        do
        {
            try context.save()
        }  catch let error as NSError {
            print(error)
        }
        
    }
}
