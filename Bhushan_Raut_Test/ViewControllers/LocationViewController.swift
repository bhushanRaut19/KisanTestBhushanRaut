//
//  LocationViewController.swift
//  Bhushan_Raut_Test
//
//  Created by Bhushan Raut on 24/01/19.
//  Copyright © 2019 Bhushan Raut. All rights reserved.
//

import UIKit

class LocationViewController: UIViewController {

    // MARK: - Viewcontroller Method

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
    // MARK: - ButtonAction
    
    @IBAction func EnglandButtonAction(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LocationDetailViewController") as? LocationDetailViewController
        vc?.locationNameType = locationType.England
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func UKButtonAction(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LocationDetailViewController") as? LocationDetailViewController
        vc?.locationNameType = locationType.UK
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func ScotlandButtonAction(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LocationDetailViewController") as? LocationDetailViewController
        vc?.locationNameType = locationType.Scotland
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func WalesButtonAction(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LocationDetailViewController") as? LocationDetailViewController
        vc?.locationNameType = locationType.Wales
        self.navigationController?.pushViewController(vc!, animated: true)
    }

}
