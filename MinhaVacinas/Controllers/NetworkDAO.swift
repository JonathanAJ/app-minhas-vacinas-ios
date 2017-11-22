//
//  NetworkController.swift
//  MinhaVacinas
//
//  Created by Alyson Brito Girão on 16/11/17.
//  Copyright © 2017 Alyson Brito Girão. All rights reserved.
//
import UIKit

struct VacinasDAO {
    
    static let categorias = ["0 aos 2 anos", "4 aos 10 anos", "11 aos 19 anos", "20 aos 59 anos", "60+"]
    static var todasAsVacinas = [[Vacina]]()
    
    static func retornaFakeVacinas() -> [[Vacina]]{
        var vacinas1 = [Vacina]()
        vacinas1.append(Vacina(idade: "Ao nascer", vacina: "BCG", doenca:"Turberculose" , dose: "20ml", doseQtd: "2", viaAdm: "Braco", descricao: "Vacina BCG"))
        vacinas1.append(Vacina(idade: "10 anos", vacina: "HPV", doenca: "HPV", dose: "10ml", doseQtd: "3", viaAdm: "Braco", descricao: "Vacina HPV"))
        
        var vacinas2 = [Vacina]()
        vacinas2.append(Vacina(idade: "Ao nascer", vacina: "Sarampo", doenca:"Turberculose" , dose: "20ml", doseQtd: "2", viaAdm: "Braco", descricao: "Vacina BCG"))
        vacinas2.append(Vacina(idade: "10 anos", vacina: "Gripe", doenca: "HPV", dose: "10ml", doseQtd: "3", viaAdm: "Braco", descricao: "Vacina HPV"))
        
        var vacinas3 = [Vacina]()
        vacinas3.append(Vacina(idade: "Ao nascer", vacina: "Hepatite B", doenca:"Turberculose" , dose: "20ml", doseQtd: "2", viaAdm: "Braco", descricao: "Vacina BCG"))
        vacinas3.append(Vacina(idade: "10 anos", vacina: "Hepatite D", doenca: "HPV", dose: "10ml", doseQtd: "3", viaAdm: "Braco", descricao: "Vacina HPV"))
        
        var vacinas4 = [Vacina]()
        vacinas4.append(Vacina(idade: "Ao nascer", vacina: "Influenza", doenca:"Turberculose" , dose: "20ml", doseQtd: "2", viaAdm: "Braco", descricao: "Vacina BCG"))
        vacinas4.append(Vacina(idade: "10 anos", vacina: "Dengue", doenca: "HPV", dose: "10ml", doseQtd: "3", viaAdm: "Braco", descricao: "Vacina HPV"))
        
        var vacinas5 = [Vacina]()
        vacinas5.append(Vacina(idade: "Ao nascer", vacina: "Gripe", doenca:"Turberculose" , dose: "20ml", doseQtd: "2", viaAdm: "Braco", descricao: "Vacina BCG"))
        vacinas5.append(Vacina(idade: "10 anos", vacina: "Hepatite Z", doenca: "HPV", dose: "10ml", doseQtd: "3", viaAdm: "Braco", descricao: "Vacina HPV"))
        
        
        todasAsVacinas.append(vacinas1)
        
        todasAsVacinas.append(vacinas2)
        
        todasAsVacinas.append(vacinas3)
        
        todasAsVacinas.append(vacinas4)
        
        todasAsVacinas.append(vacinas5)
        
        return todasAsVacinas
    }
    
}
