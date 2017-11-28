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
    static let perguntas = [Pergunta(pergunta: "Vacina causa autismo?", resposta: "Não causa"), Pergunta(pergunta: "Vacina é um plano dos iluminatis?", resposta: "Sim, eles querem dominar o mundo!")]
    static let categorias = ["Perguntas"]
    
    static let ref : DatabaseReference! =
        Database.database().reference().child("perguntas")
    
    // onComplete : @escaping ((_ perfil : Perfil) -> Void)
    
    static func listAll(){
        self.ref.observeSingleEvent(of: .childAdded, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            var pergunta : Pergunta = Pergunta()
            
            pergunta.pergunta = value?["pergunta"] as? String ?? ""
            pergunta.resposta = value?["resposta"] as? String ?? ""
            
            print("Teste")
            
            // onComplete(perfil)
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }

    
}
