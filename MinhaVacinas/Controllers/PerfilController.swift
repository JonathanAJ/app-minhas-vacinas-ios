import UIKit

class PerfilController: UIViewController {
    
    @IBOutlet weak var myName: UILabel!
    @IBOutlet weak var myAge: UILabel!
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var textProgress: UILabel!
    @IBOutlet weak var circleProgress: CircleProgressView!
    
    var myPerfil : Perfil? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        loadPerfil(perfil: myPerfil!)
        loadUserInformation()
    }
    
    func loadUserInformation(){
        PerfilDAO.listPerfilBy(id: (myPerfil?.id)!, onComplete: { perfil in
            if let myPerfil = perfil {
                self.loadPerfil(perfil: myPerfil)
            }
        })
        self.myImage.layer.masksToBounds = true
        self.myImage.layer.cornerRadius = myImage.frame.height * 0.5
    }
    
    func loadPerfil(perfil : Perfil){
        self.myPerfil = perfil
        self.myName.text = perfil.name
        self.myAge.text = perfil.age
        self.myImage.image = perfil.image
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationController = segue.destination as? UINavigationController {
            if let destination = destinationController.topViewController as? CadastroController {
                destination.myPerfil = self.myPerfil
                print("entrou")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}
