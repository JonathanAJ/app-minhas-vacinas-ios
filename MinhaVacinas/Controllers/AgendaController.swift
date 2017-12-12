//
//  AgendaController.swift
//  MinhaVacinas
//
//  Created by Jonathan Alves Jardim on 14/11/17.
//  Copyright © 2017 Alyson Brito Girão. All rights reserved.
//

import UIKit

class AgendaController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var circleProgress: CircleProgressView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var textProgress: UILabel!
    
    var dataPerfis : [Perfil] = []
    var selectPerfil : Perfil? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        circleProgress.setProgress(0, animated: true);
        textProgress.text = "0%"
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        PerfilDAO.listAll(onComplete:  { perfis in
            if perfis != nil {
                self.dataPerfis = perfis!
            }else{
                self.dataPerfis = []
            }
            self.collectionView.reloadData()
            
            var sumProgress : Double = 0
            var countProgress : Double = 0
            for perfil in self.dataPerfis {
                sumProgress = sumProgress + perfil.progress
                countProgress = countProgress + 1
            }
            self.setProgress(sumProgress/countProgress)
        })
    }
    
    func setProgress(_ progress : Double){
        self.circleProgress.setProgress(progress, animated: true)
        self.textProgress.text = "\(String(format:"%.0f", progress * 100))%"
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataPerfis.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectPerfil = dataPerfis[indexPath.row]
        performSegue(withIdentifier: "seguePerfil", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? PerfilController {
            destination.myPerfil = self.selectPerfil
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCollectionCell", for: indexPath) as! MyCollectionCellController
        
        myCell.displayCell(image: dataPerfis[indexPath.row].image,
                           name: dataPerfis[indexPath.row].name,
                           age: dataPerfis[indexPath.row].age,
                           progress: dataPerfis[indexPath.row].progress)
        
        return myCell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
