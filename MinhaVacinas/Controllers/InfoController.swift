//
//  InfoController.swift
//  MinhaVacinas
//
//  Created by Alyson Brito Girão on 16/11/17.
//  Copyright © 2017 Alyson Brito Girão. All rights reserved.
//

import UIKit

class InfoController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var navegacaoSegmentInfo: UISegmentedControl!
    @IBOutlet weak var listaVacinas: UITableView!
    
    var vacinas = NetworkDAO.retornaFakeVacinas()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        listaVacinas.delegate = self
        listaVacinas.dataSource = self
        
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
    
    // numero de linhas na tabela
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vacinas.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.listaVacinas.dequeueReusableCell(withIdentifier: "Vacina") as UITableViewCell!
         let vacina = vacinas[indexPath.row]
         cell.textLabel?.text = vacina.doenca
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = listaVacinas.cellForRow(at: indexPath)
        
        performSegue(withIdentifier: "detalheVacina", sender: cell)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detalheVacina" {
            if let posicao = listaVacinas.indexPathForSelectedRow {
                let controller = segue.destination as! DetalheVacina
                let vacina = vacinas[posicao.row]
                
                
                controller.nome = vacina.vacina
                controller.descricao = vacina.descricao
                
            }
        }
    }
    

}
