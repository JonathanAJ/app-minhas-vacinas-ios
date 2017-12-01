import UIKit

class PerfilController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var myName: UILabel!
    @IBOutlet weak var myAge: UILabel!
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var textProgress: UILabel!
    @IBOutlet weak var circleProgress: CircleProgressView!
    @IBOutlet weak var myTableVacinas: UITableView!
    
    var myPerfil : Perfil? = nil

    var vacinas = [Vacina]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        circleProgress.setProgress(1, animated: true);
        loadPerfil(perfil: myPerfil!)
        loadUserInformation()
        
        self.myTableVacinas.delegate = self
        self.myTableVacinas.dataSource = self
        
        VacinasDAO.listBy(category: myPerfil!.myVaccines, onComplete: { vacinas in
            self.vacinas = vacinas!
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
            }
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return "Minhas Vacinas"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
            return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return vacinas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Vacina", for: indexPath)
        
        let vacina = vacinas[indexPath.row]
        cell.textLabel?.text = vacina.vacina
        cell.detailTextLabel?.text = vacina.dose
        cell.selectionStyle = UITableViewCellSelectionStyle.none
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(44)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath){
            selectLabel(cell)
        }
    }
    
    func selectLabel(_ cell : UITableViewCell){
        if cell.accessoryType == UITableViewCellAccessoryType.checkmark {
            cell.accessoryType = UITableViewCellAccessoryType.none
            self.strikeTo(label: cell.textLabel!, with: cell.textLabel!.text!, with: .styleNone)
            self.strikeTo(label: cell.detailTextLabel!, with: cell.detailTextLabel!.text!, with: .styleNone)
        }else{
            cell.accessoryType = UITableViewCellAccessoryType.checkmark
            self.strikeTo(label: cell.textLabel!, with: cell.textLabel!.text!, with: .styleSingle)
            self.strikeTo(label: cell.detailTextLabel!, with: cell.detailTextLabel!.text!, with: .styleSingle)
        }
    }
    
    func strikeTo(label : UILabel, with text : String, with style : NSUnderlineStyle){
        let attrString = NSAttributedString(string: text, attributes: [NSAttributedStringKey.strikethroughStyle: style.rawValue])
        label.attributedText = attrString
        
        if style == .styleSingle {
            label.textColor = UIColor.lightGray
        } else {
            label.textColor = UIColor.black
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}
