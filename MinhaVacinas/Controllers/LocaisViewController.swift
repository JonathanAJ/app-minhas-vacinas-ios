//
//  LocaisViewController.swift
//  MinhaVacinas
//
//  Created by Alyson Brito Girão on 30/11/17.
//  Copyright © 2017 Alyson Brito Girão. All rights reserved.
//

import UIKit
import MapKit

class LocaisViewController: UIViewController {
    
    
    
    @IBOutlet weak var mapa: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
