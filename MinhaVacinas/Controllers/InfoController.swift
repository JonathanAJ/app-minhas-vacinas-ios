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
    
    
    
    // Informacoes Perguntas
    var perguntas = PerguntaDao.perguntas
    var sessoesPerguntas = PerguntaDao.categorias
    
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
        if navegacaoSegmentInfo.selectedSegmentIndex == 0 {
            return sessoes[section]
        } else {
            return sessoesPerguntas[section]
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if navegacaoSegmentInfo.selectedSegmentIndex == 0 {
            return sessoes.count
        }
        return sessoesPerguntas.count
        
    }
    
    // Numero de linhas em cada sessao
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if navegacaoSegmentInfo.selectedSegmentIndex == 0 {
            return vacinas[section].count
        }
        return perguntas.count
    }
    
    // Configurando as celulas da tableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Vacina", for: indexPath)
        
        if navegacaoSegmentInfo.selectedSegmentIndex == 0 {
            let vacina = vacinas[indexPath.section][indexPath.row]
            cell.textLabel?.text = vacina.vacina
            
            return cell
        }
        let pergunta = perguntas[indexPath.row]
        cell.textLabel?.text = pergunta.pergunta
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = listaVacinas.cellForRow(at: indexPath)
        
        performSegue(withIdentifier: "detalheVacina", sender: cell)
        
        
        
    }
    
    
    @IBAction func atualizarTable(_ sender: UISegmentedControl) {
        listaVacinas.reloadData()
    }
    
    
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detalheVacina" {
            if let posicao = listaVacinas.indexPathForSelectedRow {
                let controller = segue.destination as! DetalheVacina
                
                if navegacaoSegmentInfo.selectedSegmentIndex == 0 {
                    let vacina = vacinas[posicao.section][posicao.row]
                    controller.nome = vacina.vacina
                    controller.descricao = vacina.descricao
                } else {
                    let pergunta = perguntas[posicao.row]
                    controller.nome = pergunta.pergunta
                    controller.descricao = pergunta.resposta
                }
                
                
            }
        }
    }
    

}
