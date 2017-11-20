//
//  CadastroController.swift
//  MinhaVacinas
//
//  Created by Jonathan Alves Jardim on 20/11/17.
//  Copyright © 2017 Alyson Brito Girão. All rights reserved.
//

import UIKit

class CadastroController: UIViewController {

    @IBOutlet weak var btCancelar: UIBarButtonItem!
    
    @IBAction func cancelar(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
