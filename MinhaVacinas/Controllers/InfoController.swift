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
    
    var vacinas = [[Vacina]]()
    var sessoes: [String] = []
    
    
    
    // Informacoes Perguntas
    var perguntas = [Pergunta]()
    var sessoesPerguntas = PerguntaDao.categorias
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        listaVacinas.delegate = self
        listaVacinas.dataSource = self

        PerguntaDao.listAll(onComplete:  { perguntas in
            
            self.perguntas = perguntas
            
        })
        
        VacinasDAO.listAll(onComplete: { vacinas in
            self.vacinas = vacinas
            self.sessoes = VacinasDAO.categorais
            self.listaVacinas.reloadData()
        })
        
        
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
            return sessoes[section].uppercased()
        } else {
            return sessoesPerguntas[section].uppercased()
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
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(44)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if navegacaoSegmentInfo.selectedSegmentIndex == 0 {
            performSegue(withIdentifier: "detalheVacina", sender: nil)
       
        }else{
            
            performSegue(withIdentifier: "detalhePergunta", sender: nil)
        }
        
    }
    
    
    @IBAction func atualizarTable(_ sender: UISegmentedControl) {
        listaVacinas.reloadData()
    }

    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detalheVacina" {
            if let posicao = listaVacinas.indexPathForSelectedRow {
                
                if let destinationController = segue.destination as? UINavigationController{
                    
                    if let destination = destinationController.topViewController as? DetalheVacina {
                        let vacina = vacinas[posicao.section][posicao.row]
                        destination.nome = vacina.vacina
                        destination.doencas = vacina.doenca
                        destination.dosagem = vacina.dose
                        destination.idadeRecomendada = vacina.idade
                    
                    }
                }
                
            }
            
        }
        else {
            if let posicao = listaVacinas.indexPathForSelectedRow {
                
                if let destinationController = segue.destination as? UINavigationController{
                    
                    if let destination = destinationController.topViewController as? DetalhePergunta {
                        let pergunta = perguntas[posicao.row]
                        destination.titulo = pergunta.pergunta
                        destination.respostaT = pergunta.resposta
                        
                    }
                }
                
            }
        }
    

    }
}
