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
    static let categories = ["Bebês", "Crianças", "Adolescentes", "Adultos", "Idosos"]
    
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
        
                            let id = vacina.key as? String ?? ""
                            let v = addVaccine(id: id, vacinaValue)
                            
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
    
    static func listVaccinesBy(perfil : Perfil, onComplete : @escaping ((_ : [Vacina]?) -> Void)){
        
        for vaccinePerfil in perfil.myVaccines {
            
            let category = vaccinePerfil.key as? String ?? ""
            
            self.ref.child(category).observeSingleEvent(of: .value, with: { (snapshot) in
                if let value = snapshot.value as? NSDictionary {
                    var vaccineList = [Vacina]()
                    for vacina in value {
                        if let vacinaValue = vacina.value as? NSDictionary {
                            let id = vacina.key as? String ?? ""
                            var v = addVaccine(id: id, vacinaValue)
                            
                            if let vaccinesCheck = vaccinePerfil.value as? NSDictionary{
                                var listCheck = [String]()
                                for vac in vaccinesCheck {
                                    listCheck.append(vac.key as? String ?? "")
                                }
                                if listCheck.contains(id) {
                                    v.isChecked = true
                                }
                            }
                            
                            vaccineList.append(v)
                        }
                    }
                    onComplete(vaccineList)
                }else{
                    onComplete(nil)
                }
                
            }) { (error) in
                onComplete(nil)
                print(error.localizedDescription)
            }
        }
    }
    
    
    
    private static func addVaccine(id : String, _ vacinaValue : NSDictionary) -> Vacina{
        var vacina = Vacina()
        vacina.id = id
        vacina.doenca = vacinaValue["doenca_protecao"] as? String ?? ""
        vacina.idade = vacinaValue["idade"] as? String ?? ""
        vacina.vacina = vacinaValue["vacina"] as? String ?? ""
        vacina.doseQtd = vacinaValue["dose_qtd"] as? String ?? ""
        vacina.dose = vacinaValue["dose"] as? String ?? ""
        
        return vacina
    }
    
}
