//
//  PerfilDAO.swift
//  MinhaVacinas
//
//  Created by Jonathan Alves Jardim on 27/11/17.
//  Copyright © 2017 Alyson Brito Girão. All rights reserved.
//

import Foundation
import Firebase

class PerfilDAO{
    static let ref : DatabaseReference =
        Database.database().reference().child("perfil")
    
    static func create(perfil : Perfil){
        
        let perfil : [NSString : Any] = [
            "name" : perfil.name,
            "born" : perfil.born,
            "sex" : perfil.sex
        ]
        
        self.ref.childByAutoId().setValue(perfil)
    }
    
    static func listAll(onComplete : @escaping ((_ perfil : Perfil) -> Void) ){
        self.ref.observeSingleEvent(of: .childAdded, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            var perfil : Perfil = Perfil()
            
            perfil.id = snapshot.key
            perfil.name = value?["name"] as? String ?? ""
            perfil.born = value?["born"] as? String ?? ""
            perfil.sex = value?["sex"] as? String ?? ""
            
            onComplete(perfil)
        
        }) { (error) in
            print(error.localizedDescription)
        }
    }
}
