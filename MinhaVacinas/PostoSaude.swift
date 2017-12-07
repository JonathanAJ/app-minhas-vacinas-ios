//
//  PostoSaude.swift
//  MinhaVacinas
//
//  Created by Alyson Brito Girão on 30/11/17.
//  Copyright © 2017 Alyson Brito Girão. All rights reserved.
//

import UIKit
import MapKit
class PostoSaude: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    
    init(nome: String,coordenada: CLLocationCoordinate2D) {
        self.title = nome
        self.coordinate = coordenada
        
        super.init()
    }
    
    var subtitle: String? {
        return title
    }
    
    
}
