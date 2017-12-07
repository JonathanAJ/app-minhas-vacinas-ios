//
//  PostoDAO.swift
//  MinhaVacinas
//
//  Created by Alyson Brito Girão on 30/11/17.
//  Copyright © 2017 Alyson Brito Girão. All rights reserved.
//

import UIKit
import Firebase
import MapKit
struct PostoDAO {
    
    static let ref : DatabaseReference! =
        Database.database().reference().child("postos")
    
    static func listAll(onComplete : @escaping ((_ pergunta : [PostoSaude]) -> Void)){
        
        self.ref.observeSingleEvent(of: .value, with: { (snapshot) in
            var postos = [PostoSaude]()
            let value = snapshot.value as? NSDictionary
            
            let todosPostos = value!["CE"] as? NSDictionary
            
            for posto in todosPostos! {
                if let posto =  posto.value as? NSDictionary {
                    var lat = posto["latitude"] as? String ?? ""
                    var lon = posto["longitude"] as? String ?? ""
                    var nome = posto["n_fantasia"] as? String ?? ""
                    
                    var p = PostoSaude(nome: nome, coordenada: CLLocationCoordinate2D(latitude: Double(lat)!, longitude: Double(lon)!))
                    
                    postos.append(p)
                }
                
            }
            onComplete(postos)
//
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }

}

