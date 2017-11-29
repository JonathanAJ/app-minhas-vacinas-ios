//
//  DetalhePergunta.swift
//  MinhaVacinas
//
//  Created by Alyson Brito Girão on 29/11/17.
//  Copyright © 2017 Alyson Brito Girão. All rights reserved.
//

import UIKit

class DetalhePergunta: UIViewController {

    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var tiulo: UILabel!
    
    @IBOutlet weak var resposta: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
