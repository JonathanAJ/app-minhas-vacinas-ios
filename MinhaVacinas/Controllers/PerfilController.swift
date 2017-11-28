import UIKit

class PerfilController: UIViewController {
    
    @IBOutlet weak var myName: UILabel!
    @IBOutlet weak var myAge: UILabel!
    @IBOutlet weak var myImage: UIImageView!
    
    
    var myPerfil : Perfil? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        loadUserInformation()
    }
    
    func loadUserInformation(){
        self.myName.text = myPerfil?.name
        self.myAge.text = myPerfil?.age
        self.myImage.image = myPerfil?.image
        self.myImage.layer.masksToBounds = true
        self.myImage.layer.cornerRadius = myImage.frame.height * 0.5
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? CadastroController {
            destination.myPerfil = self.myPerfil
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}
