//
//  DetalheVacina.swift
//  MinhaVacinas
//
//  Created by Alyson Brito Girão on 21/11/17.
//  Copyright © 2017 Alyson Brito Girão. All rights reserved.
//

import UIKit

class DetalheVacina: UIViewController {
    
    
    @IBOutlet weak var nomeVacina: UILabel!
    
    @IBOutlet weak var doencasImu: UILabel!
    
    @IBOutlet weak var idRecomendada: UILabel!
    
    @IBOutlet weak var dosagemVa: UILabel!
    
    
    
    
    var nome = ""
    var doencas = ""
    var idadeRecomendada = ""
    var dosagem = ""

    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nomeVacina.text = nome
        doencasImu.text = doencas
        idRecomendada.text = idadeRecomendada
        dosagemVa.text = dosagem

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
