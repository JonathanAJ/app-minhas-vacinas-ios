//
//  PerguntaDAO.swift
//  MinhaVacinas
//
//  Created by Alyson Brito Girão on 22/11/17.
//  Copyright © 2017 Alyson Brito Girão. All rights reserved.
//

import UIKit
import Firebase




struct PerguntaDao {
    static let categorias = ["Perguntas"]
    static let ref : DatabaseReference! =
    Database.database().reference().child("perguntas")
    
    static func listAll(onComplete : @escaping ((_ pergunta : [Pergunta]) -> Void)){
        self.ref.observeSingleEvent(of: .value, with: { (snapshot) in
            var perguntas = [Pergunta]()
            let value = snapshot.value as? NSArray
            
            
            for pergunta in value! {
                if let perguntaValue = pergunta as? NSDictionary {
                    var p : Pergunta = Pergunta()
                    p.fonte = perguntaValue["fonte"] as? String ?? ""
                    p.pergunta = perguntaValue["pergunta"] as? String ?? ""
                    p.resposta = perguntaValue["resposta"] as? String ?? ""
                    perguntas.append(p)
                }
            }
            
            
            
            onComplete(perguntas)
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }

    
}
