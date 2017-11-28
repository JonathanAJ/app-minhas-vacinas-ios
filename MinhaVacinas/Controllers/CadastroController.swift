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
    @IBOutlet weak var myNavigation: UINavigationBar!
    
    var myPerfil : Perfil? = nil
    var isCreate : Bool = true
    
    @IBAction func cancelar(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cadastrar(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
        
        var myPerfil = Perfil()
        
        myPerfil.name = myName.text!
        myPerfil.born = String(myBorn.date.timeIntervalSince1970)
        myPerfil.sex = mySex.selectedSegmentIndex == 0 ? "M" : "F"
        myPerfil.imageBase64 = self.getImageBase64()
        
        if isCreate {
            PerfilDAO.create(perfil: myPerfil)
        }else{
            myPerfil.id = (self.myPerfil?.id)!
            PerfilDAO.update(perfil: myPerfil)
        }
    }
    
    func getImageBase64() -> String {
        let image = myButtonImage.currentImage!
        let imageData : NSData = UIImageJPEGRepresentation(image, 0.5)! as NSData
        return imageData.base64EncodedString(options: .lineLength64Characters)
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
        
        loadUserInformation()
        self.myBorn.maximumDate = Date()
    }
    
    func loadUserInformation(){
        
        if let perfil = myPerfil {
            self.isCreate = false
            self.myNavigation.topItem?.title = "Atualizar Perfil"
            self.btCadastrar.title = "Atualizar"
            self.myName.text = perfil.name
            if (perfil.sex.elementsEqual("F")) {
                mySex.selectedSegmentIndex = 1
            }
            self.myBorn.date = Date(timeIntervalSince1970: Double(perfil.born)!)
            self.myButtonImage.setImage(myPerfil?.image, for: UIControlState())
        }else{
            self.myButtonImage.layer.borderWidth = 1.0
        }
        
        self.myButtonImage.layer.masksToBounds = true
        self.myButtonImage.layer.cornerRadius = myButtonImage.frame.height * 0.5
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
