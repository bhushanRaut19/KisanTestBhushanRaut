//
//  LocationDetailViewController.swift
//  Bhushan_Raut_Test
//
//  Created by Bhushan Raut on 24/01/19.
//  Copyright © 2019 Bhushan Raut. All rights reserved.
//

import UIKit
import CoreData

class LocationDetailViewController: UIViewController {

    // MARK: - properties and IBOutlet

    var locationNameType : locationType?
    
    @IBOutlet weak var txtMonth: UITextField!
    
    @IBOutlet weak var txtYear: UITextField!
    
    @IBOutlet weak var lblTmin: UILabel!
    
    
    @IBOutlet weak var lblTmax: UILabel!
    
    @IBOutlet weak var lblRainfall: UILabel!
    
    // MARK: - Viewcontroller Method

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        // Do any additional setup after loading the view.
    }
    
    
    // MARK: - UserDefined Method

    func setUpUI()
    {
        lblTmin.text = ""
        lblTmax.text = ""
        lblRainfall.text = ""
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - ButtonAction
    
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func SubmitButtonAction(_ sender: Any)
    {
        guard myFetchRequest() == true else {
            let alert = UIAlertController(title: "Alert", message: "Enter Valid Data", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                switch action.style{
                case .default:
                    print("default")
                    
                case .cancel:
                    print("cancel")
                    
                case .destructive:
                    print("destructive")
                }}))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        getValuesForMetrics(metricTypeInput: metricType.Rainfall)
        getValuesForMetrics(metricTypeInput: metricType.Tmin)
        getValuesForMetrics(metricTypeInput: metricType.Tmax)

    }
    
    private func myFetchRequest() -> Bool
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let myRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Weather")
        myRequest.predicate = NSPredicate(format: "year == %@", txtYear.text!)
        let myRequest1 = NSFetchRequest<NSFetchRequestResult>(entityName: "Weather")
        myRequest1.predicate = NSPredicate(format: "month == %@", txtMonth.text!)
        do{
            let resultsYear = try context.fetch(myRequest)
            let resultsMonth = try context.fetch(myRequest1)
            if resultsYear.count > 0 && resultsMonth.count > 0
            {
                return true
            }
            else
            {
                return false
            }
        } catch let error{
            print(error)
            return false
        }
    }

    func getValuesForMetrics(metricTypeInput : metricType)
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let myRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Weather")
        let predicate1 = NSPredicate(format: "year == %@", txtYear.text!)
        let predicate2 = NSPredicate(format: "month == %@", txtMonth.text!)
        let predicate3 = NSPredicate(format: "city == %@", (locationNameType?.rawValue)!)
        let predicate4 = NSPredicate(format: "metrics == %@", metricTypeInput.rawValue)
        myRequest.returnsObjectsAsFaults = false
        myRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate1, predicate2, predicate3, predicate4])
        do{
            let results = try context.fetch(myRequest) as! [NSManagedObject]
            for item in results
            {
                switch metricTypeInput
                {
                case .Rainfall :
                    DispatchQueue.main.async {
                        self.lblRainfall.text = String(describing: item.value(forKey: "value")!)}
                case .Tmax:
                    DispatchQueue.main.async {
                        self.lblTmax.text = String(describing: item.value(forKey: "value")!)}
                case .Tmin:
                    DispatchQueue.main.async {
                        self.lblTmin.text = String(describing: item.value(forKey: "value")!)}
                }
            }
            
        } catch let error{
            print(error)
        }
    }
}
