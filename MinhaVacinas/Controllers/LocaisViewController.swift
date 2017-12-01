//
//  LocaisViewController.swift
//  MinhaVacinas
//
//  Created by Alyson Brito Girão on 30/11/17.
//  Copyright © 2017 Alyson Brito Girão. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class LocaisViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapa: MKMapView!
    
    // Usado para começar a pegar a localização do usuário
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
//        centerMapLocation(location: initialLocation)
        
        locationManager.requestAlwaysAuthorization()
        
        // Se o servico de localizacao estiver habilitado, pegar a localizacao do usuário
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
            locationManager.startUpdatingLocation()
            print("Começou a procurar a localizacao")
        }
        
        PostoDAO.listAll(onComplete: { posto in
            
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            centerMapOnLocation(location: location)
            
        }
        
    }
    
    
    func centerMapOnLocation(location: CLLocation) {
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius, regionRadius)
        mapa.setRegion(coordinateRegion, animated: true)
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
