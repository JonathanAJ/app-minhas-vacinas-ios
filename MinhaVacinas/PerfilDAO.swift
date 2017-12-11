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
    private static let ref : DatabaseReference =
        Database.database().reference().child("perfil")
    
    private static func getMyVaccines(born : String) -> String {
        let date = Date(timeIntervalSince1970: Double(born)!)
        let dateYear = Calendar.current.dateComponents([.year], from: date, to: Date()).year!
        
        if dateYear <= 2 {
            return "bebes"
        }else if dateYear > 2 && dateYear <= 10 {
            return "criancas"
        }else if dateYear > 10 && dateYear <= 19 {
            return "adolescentes"
        }else if dateYear > 19 && dateYear <= 59 {
            return "adultos"
        }else {
            return "idosos"
        }
    }
    
    static func create(perfil : Perfil){
        
        let perfilCreate : [NSString : Any] = [
            "name" : perfil.name,
            "born" : perfil.born,
            "sex" : perfil.sex,
            "imageBase64" : perfil.imageBase64,
            "myVaccines" : [getMyVaccines(born: perfil.born) : true]
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
    
    static func addVaccine(id vaccineID : String, to perfil : Perfil){
        for vaccine in perfil.myVaccines {
            let category = vaccine.key as? String ?? ""
            self.ref.child(perfil.id)
                    .child("myVaccines")
                    .child(category)
                    .child(vaccineID)
                    .setValue(true)
        }
    }
    
    static func set(progress : Double, to perfil : Perfil){
        self.ref.child(perfil.id)
            .child("progress")
            .setValue(progress)
    }
    
    static func removeVaccine(id vaccineID : String, to perfil : Perfil){
        for vaccine in perfil.myVaccines as NSDictionary {
            let category = vaccine.key as? String ?? ""
            self.ref.child(perfil.id)
                .child("myVaccines")
                .child(category)
                .child(vaccineID)
                .removeValue()
            
            if let numberOfVaccines = vaccine.value as? NSDictionary {
                if numberOfVaccines.allKeys.count <= 1 {
                    self.ref.child(perfil.id)
                        .child("myVaccines")
                        .updateChildValues([category : true])
                }
            }
        }
    }
    
    static func listPerfilBy(id : String, onComplete : @escaping ((_ perfil : Perfil?) -> Void)) {
        self.ref.child(id).observe(.value, with: { snapshot in
            if let perfilValue = snapshot.value as? NSDictionary {
                let id = snapshot.key
                onComplete(addPerfil(id : id, perfilValue))
            }
        }) { (error) in
            onComplete(nil)
            print(error.localizedDescription)
        }
    }
    
    // lista todos os perfis, criando um onComplete para finalizar o request
    static func listAll(onComplete : @escaping ((_ perfis : [Perfil]?) -> Void) ){
        
        self.ref.observe(.value, with: { (snapshot) in
            var arrayPerfil : [Perfil] = []
            if let value = snapshot.value as? NSDictionary{
                for child in value {
                    if let perfilValue = child.value as? NSDictionary {
                        let id = child.key as! String
                        arrayPerfil.append(addPerfil(id : id, perfilValue))
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
    
    private static func addPerfil(id : String, _ perfilValue : NSDictionary) -> Perfil{
        var perfil : Perfil = Perfil()
        perfil.id = id
        perfil.name = perfilValue["name"] as? String ?? ""
        perfil.born = perfilValue["born"] as? String ?? ""
        perfil.sex = perfilValue["sex"] as? String ?? ""
        perfil.imageBase64 = perfilValue["imageBase64"] as? String ?? ""
        perfil.progress = perfilValue["progress"] as? Double ?? 0
        perfil.myVaccines = perfilValue["myVaccines"] as? NSDictionary ?? [:]
        
        return perfil
    }
}
