import UIKit

class PerfilController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var myName: UILabel!
    @IBOutlet weak var myAge: UILabel!
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var textProgress: UILabel!
    @IBOutlet weak var circleProgress: CircleProgressView!
    @IBOutlet weak var myTableVacinas: UITableView!
    
    var myPerfil : Perfil? = nil

    var vacinas = [[Vacina]]()
    var sessoes: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        circleProgress.setProgress(1, animated: true);
        loadPerfil(perfil: myPerfil!)
        loadUserInformation()
        
        self.myTableVacinas.delegate = self
        self.myTableVacinas.dataSource = self
        
        VacinasDAO.listAll(onComplete: { vacinas in
            self.vacinas = vacinas
            self.sessoes = VacinasDAO.categorais
            self.myTableVacinas.reloadData()
        })
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
    // Configuracoes da table view
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return sessoes[section].uppercased()
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
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(44)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        if cell?.accessoryType == UITableViewCellAccessoryType.checkmark {
            cell?.accessoryType = UITableViewCellAccessoryType.none
        }else{
            cell?.accessoryType = UITableViewCellAccessoryType.checkmark
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}
