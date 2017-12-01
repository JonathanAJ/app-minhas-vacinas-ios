//
//  PostoDAO.swift
//  MinhaVacinas
//
//  Created by Alyson Brito Girão on 30/11/17.
//  Copyright © 2017 Alyson Brito Girão. All rights reserved.
//

import UIKit
import Firebase

struct PostoDAO {
    
    static let ref : DatabaseReference! =
        Database.database().reference().child("postos")
    
    static func listAll(onComplete : @escaping ((_ pergunta : [Pergunta]) -> Void)){
        self.ref.queryLimited(toFirst: 100).queryOrdered(byChild: "uf").queryEqual(toValue: "RJ", childKey: "uf").observeSingleEvent(of: .value, with: { (snapshot) in
//        self.ref.observeSingleEvent(of: .value, with: { (snapshot) in
            var perguntas = [Pergunta]()
            let value = snapshot.value as? NSArray
            
            
//            for pergunta in value! {
//                if let perguntaValue = pergunta as? NSDictionary {
//                    var p : Pergunta = Pergunta()
//                    p.fonte = perguntaValue["fonte"] as? String ?? ""
//                    p.pergunta = perguntaValue["pergunta"] as? String ?? ""
//                    p.resposta = perguntaValue["resposta"] as? String ?? ""
//                    perguntas.append(p)
//                }
//            }
            onComplete(perguntas)
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }

}

