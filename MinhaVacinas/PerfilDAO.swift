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
        
        let perfilCreate : [NSString : Any] = [
            "name" : perfil.name,
            "born" : perfil.born,
            "sex" : perfil.sex,
            "imageBase64" : perfil.imageBase64
        ]
        
        self.ref.childByAutoId().setValue(perfilCreate)
    }
    
    static func update(perfil : Perfil){
        let perfilUpdate : [NSString : Any] = [
            "name" : perfil.name,
            "born" : perfil.born,
            "sex" : perfil.sex,
            "imageBase64" : perfil.imageBase64
        ]
        self.ref.child(perfil.id).updateChildValues(perfilUpdate)
    }
    
    // lista todos os perfis, criando um onComplete para finalizar o request
    static func listAll(onComplete : @escaping ((_ perfis : [Perfil]?) -> Void) ){
        
        self.ref.observe(.value, with: { (snapshot) in
            var arrayPerfil : [Perfil] = []
            if let value = snapshot.value as? NSDictionary{
                for child in value {
                    if let perfilValue = child.value as? NSDictionary {
                        var perfil : Perfil = Perfil()
                        perfil.id = child.key as! String
                        perfil.name = perfilValue["name"] as? String ?? ""
                        perfil.born = perfilValue["born"] as? String ?? ""
                        perfil.sex = perfilValue["sex"] as? String ?? ""
                        perfil.imageBase64 = perfilValue["imageBase64"] as? String ?? ""
                        arrayPerfil.append(perfil)
                    }
                }
                onComplete(arrayPerfil)
            }else{
                onComplete(nil)
            }
        }) { (error) in
            onComplete(nil)
            print(error.localizedDescription)
        }
    }
}
