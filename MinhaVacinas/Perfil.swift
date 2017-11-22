//
//  Perfil.swift
//  MinhaVacinas
//
//  Created by Jonathan Alves Jardim on 21/11/17.
//  Copyright © 2017 Alyson Brito Girão. All rights reserved.
//

import Foundation
import UIKit

struct Perfil {
    
    let name : String
    let age : String
    let image : UIImage?
    
    init(name : String,age : String, image : UIImage?) {
        self.name = name
        self.age = age
        self.image = image
    }
}
