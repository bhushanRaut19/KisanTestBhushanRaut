//
//  NetworkHandler.swift
//  Bhushan_Raut_Test
//
//  Created by Bhushan Raut on 21/01/19.
//  Copyright © 2019 Bhushan Raut. All rights reserved.
//
import Foundation
import UIKit

final class NetworkHandler : NSObject{
    
    static let sharedInstance = NetworkHandler()
    
    
    typealias requestCompletionBlock =  (_ dataDict : [String : Any]? , _ isError : Bool,_ errorMessage : String?)->Void
    typealias completionBlock = (_ dic : Data?,_ isError : Bool,_ errorMessage : String?) -> Void
    
    var reachability = Reachability(hostname: "https://www.google.com")

    var coreDtaObject = CoreDataManagerClass()

    private override init() {
        super.init()
    }
    
    

    
    func getRequestWith(metric : metricType, location: locationType) {
        if reachability?.isReachable ?? false
        {
            
            let url = URL(string: "https://s3.eu-west-2.amazonaws.com/interview-question-data/metoffice/\(metric.rawValue)-\(location.rawValue).json")
            let task = URLSession.shared.dataTask(with: url!) {(data, response, error ) in
                
                guard error == nil else {
                    print("returned error")
                    return
                }
                
                guard let content = data else {
                    print("No data")
                    return
                }
                
                do {
                    guard let todo = try JSONSerialization.jsonObject(with: content, options: []) as? Any? else {
                        print("error trying to convert data to JSON")
                        return
                    }
                    do {
                        let weatherObject = try JSONDecoder().decode(WeatherArray.self, from: data!)
                        print(weatherObject)
                        self.coreDtaObject.insertDataInCoreData(WeatherArrayObj: weatherObject, city: location.rawValue, metrics: metric.rawValue)
                        
                    } catch {
                        print(error.localizedDescription)
                    }
                    
                } catch  {
                    print("error trying to convert data to JSON")
                    return
                }
                
            }
            task.resume()
            
        }
        else
        {
//            callback(nil, true, "Network Issue")
        }
        
    }
    

    
}

