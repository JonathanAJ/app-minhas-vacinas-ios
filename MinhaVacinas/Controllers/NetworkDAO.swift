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
    static let categorais = ["Bebes", "Crianças", "Adolescentes", "Adultos", "Idosos"]
    
    
    static func listAll(onComplete : @escaping ((_ perguntas : [[Vacina]]) -> Void)){
        
        var todasAsVacinas = [[Vacina]]()
        var bebe = [Vacina]()
        var crianca = [Vacina]()
        var adolecentes = [Vacina]()
        var adultos = [Vacina]()
        var idoso = [Vacina]()
        
        self.ref.queryOrderedByValue().observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            
            for categoria in value! {
                if let categoriaValue = categoria.value as? NSArray {
                    
                    
                    for vacina in categoriaValue {
                        if let vacinaValue = vacina as? NSDictionary{
                            var v = Vacina()
                            v.doenca = vacinaValue["doenca_protecao"] as? String ?? ""
                            v.idade = vacinaValue["idade"] as? String ?? ""
                            v.vacina = vacinaValue["vacina"] as? String ?? ""
                            v.doenca = vacinaValue["doenca_protecao"] as? String ?? ""
                            v.doseQtd = vacinaValue["dose_qtd"] as? String ?? ""
                            v.dose = vacinaValue["dose"] as? String ?? ""
                            
                            v.descricao = "Protege contra a doença(s):\n\(v.doenca)\n\nIdade recomendada:\n\(v.idade)\n\nDose:\n\(v.dose)\n\nDose Quantidade:\n\(v.doseQtd)"
                            
                            if categoria.key as! String == "0_bebes" {
                                bebe.append(v)
                            }
                            else if categoria.key as! String == "1_criancas" {
                                crianca.append(v)
                            }
                            else if categoria.key as! String == "2_adolecentes" {
                                adolecentes.append(v)
                            }
                            else if categoria.key as! String == "3_adultos" {
                                adultos.append(v)
                            } else if categoria.key as! String == "4_idoso" {
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
    
}
