//
//  AgendaController.swift
//  MinhaVacinas
//
//  Created by Jonathan Alves Jardim on 14/11/17.
//  Copyright © 2017 Alyson Brito Girão. All rights reserved.
//

import UIKit

class AgendaController: UIViewController {

    @IBOutlet weak var circleProgress: CircleProgressView!
    @IBOutlet weak var textProgress: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        circleProgress.setProgress(1, animated: true);
        textProgress.text = "100%"

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
