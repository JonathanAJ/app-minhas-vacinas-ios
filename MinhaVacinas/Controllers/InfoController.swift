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
    
    var vacinas = VacinasDAO.retornaFakeVacinas()
    var sessoes = VacinasDAO.categorias
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        listaVacinas.delegate = self
        listaVacinas.dataSource = self
        
        //print(vacinas)
        
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
    
    // Configuracoes da table view
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sessoes[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sessoes.count
    }
    
    // Numero de linhas em cada sessao
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vacinas[section].count
    }
    
    // Configurando as celulas da tableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Vacina", for: indexPath)
        
        let vacina = vacinas[indexPath.section][indexPath.row]
        
        cell.textLabel?.text = vacina.vacina
        
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
                let vacina = vacinas[posicao.section][posicao.row]
                
                
                controller.nome = vacina.vacina
                controller.descricao = vacina.descricao
                
            }
        }
    }
    

}
