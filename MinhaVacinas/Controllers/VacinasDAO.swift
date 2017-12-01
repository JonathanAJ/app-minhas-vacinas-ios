//
//  NetworkController.swift
//  MinhaVacinas
//
//  Created by Alyson Brito Girão on 16/11/17.
//  Copyright © 2017 Alyson Brito Girão. All rights reserved.
//
import UIKit
import Firebase

struct VacinasDAO {
    
    static let ref : DatabaseReference! =
        Database.database().reference().child("vacinas")
    static let categorais = ["Bebês", "Crianças", "Adolescentes", "Adultos", "Idosos"]
    
    static func listAll(onComplete : @escaping ((_ perguntas : [[Vacina]]) -> Void)){
        
        var todasAsVacinas = [[Vacina]]()
        var bebe = [Vacina]()
        var crianca = [Vacina]()
        var adolecentes = [Vacina]()
        var adultos = [Vacina]()
        var idoso = [Vacina]()
        
        self.ref.observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            
            for categoria in value! {
                if let categoriaValue = categoria.value as? NSDictionary {
                    
                    for vacina in categoriaValue {
                        if let vacinaValue = vacina.value as? NSDictionary{
                            var v = Vacina()
                            v.doenca = vacinaValue["doenca_protecao"] as? String ?? ""
                            v.idade = vacinaValue["idade"] as? String ?? ""
                            v.vacina = vacinaValue["vacina"] as? String ?? ""
                            v.doseQtd = vacinaValue["dose_qtd"] as? String ?? ""
                            v.dose = vacinaValue["dose"] as? String ?? ""
                            
                            if categoria.key as! String == "bebes" {
                                bebe.append(v)
                            }
                            else if categoria.key as! String == "criancas" {
                                crianca.append(v)
                            }
                            else if categoria.key as! String == "adolescentes" {
                                adolecentes.append(v)
                            }
                            else if categoria.key as! String == "adultos" {
                                adultos.append(v)
                            }
                            else if categoria.key as! String == "idosos" {
                                idoso.append(v)
                            }
                        }
                    }
                }
            }
            
            todasAsVacinas.append(bebe)
            todasAsVacinas.append(crianca)
            todasAsVacinas.append(adolecentes)
            todasAsVacinas.append(adultos)
            todasAsVacinas.append(idoso)
        
            onComplete(todasAsVacinas)
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    static func listBy(category : String, onComplete : @escaping ((_ : [Vacina]?) -> Void)){
        
        var myVacine = [Vacina]()
        
        self.ref.child(category).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            
            for vacina in value! {
                if let vacinaValue = vacina.value as? NSDictionary {
                    var v = Vacina()
                    
                    v.doenca = vacinaValue["doenca_protecao"] as? String ?? ""
                    v.idade = vacinaValue["idade"] as? String ?? ""
                    v.vacina = vacinaValue["vacina"] as? String ?? ""
                    v.doseQtd = vacinaValue["dose_qtd"] as? String ?? ""
                    v.dose = vacinaValue["dose"] as? String ?? ""
                    
                    myVacine.append(v)
                }
            }
            onComplete(myVacine)
            
        }) { (error) in
            onComplete(nil)
            print(error.localizedDescription)
        }
    }
    
}
