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
    
    var id : String = ""
    var name : String = ""
    var born : String = ""
    var sex : String = ""
    var imageBase64 : String = ""
    var myVaccines : NSDictionary = [:]
    var image : UIImage? {
        get {
            let dataImage : Data = Data(base64Encoded: imageBase64, options: .ignoreUnknownCharacters)!
            return UIImage(data: dataImage)
        }
    }
    var age : String {
        get {
            let date = Date(timeIntervalSince1970: Double(born)!)
            let dateYear = Calendar.current.dateComponents([.year], from: date, to: Date()).year!
            if dateYear != 0 {
                return "\(dateYear) \(dateYear == 1 ? "ano" : "anos")"
            }else{
                let dateMonth = Calendar.current.dateComponents([.month], from: date, to: Date()).month!
                return "\(dateMonth) \(dateMonth == 1 ? "mês" : "meses")"
            }
        }
    }
}
