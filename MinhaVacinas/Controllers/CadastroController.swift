//
//  CadastroController.swift
//  MinhaVacinas
//
//  Created by Jonathan Alves Jardim on 20/11/17.
//  Copyright © 2017 Alyson Brito Girão. All rights reserved.
//

import UIKit

class CadastroController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var btCancelar: UIBarButtonItem!
    
    @IBOutlet weak var btCadastrar: UIBarButtonItem!
    
    @IBOutlet weak var myButtonImage: UIButton!
    @IBOutlet weak var myName: UITextField!
    @IBOutlet weak var mySex: UISegmentedControl!
    @IBOutlet weak var myBorn: UIDatePicker!
    
    @IBAction func cancelar(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cadastrar(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
        
        let myPerfil = Perfil.init(id : "",
                                   name : myName.text!,
                                   born : myBorn.date.description,
                                   sex : mySex.selectedSegmentIndex == 0 ? "M" : "F",
                                   image: nil)
        
        PerfilDAO.create(perfil: myPerfil)
    }
    
    @IBAction func getImage(_ sender: UIButton) {
        let imagePick = UIImagePickerController()
        imagePick.allowsEditing = true
        imagePick.sourceType = .photoLibrary
        imagePick.delegate = self
        
        self.present(imagePick, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.myButtonImage.layer.masksToBounds = true
        self.myButtonImage.layer.cornerRadius = myButtonImage.frame.height * 0.5
        self.myButtonImage.layer.borderWidth = 1.0
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            myButtonImage.setImage(pickedImage, for: UIControlState())
                
        }
        
        self.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
