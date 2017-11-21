//
//  NetworkController.swift
//  MinhaVacinas
//
//  Created by Alyson Brito Girão on 16/11/17.
//  Copyright © 2017 Alyson Brito Girão. All rights reserved.
//
import UIKit

struct NetworkDAO {
    func retornaData() {
        let url = URL(string: "http://dados.recife.pe.gov.br/api/action/datastore_search?resource_id=8222148c-14d1-47ba-ae0e-39c879246284")
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard error == nil else {
                print(error!)
                return
            }
            guard let data = data else {
                print("Data is empty")
                return
            }
            
            print(data)
        }
        task.resume()
        
    }
    
    static func retornaFakeVacinas() -> [Vacina]{
        var vacinas = [Vacina]()
        vacinas.append(Vacina(idade: "Ao nascer", vacina: "BCG", doenca:"Turberculose" , dose: "20ml", doseQtd: "2", viaAdm: "Braco", descricao: "Vacina BCG"))
        vacinas.append(Vacina(idade: "10 anos", vacina: "HPV", doenca: "HPV", dose: "10ml", doseQtd: "3", viaAdm: "Braco", descricao: "Vacina HPV"))
    
        return vacinas
    }
    
}
