import UIKit

class PerfilController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var myName: UILabel!
    @IBOutlet weak var myAge: UILabel!
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var textProgress: UILabel!
    @IBOutlet weak var circleProgress: CircleProgressView!
    @IBOutlet weak var myTableVacinas: UITableView!
    
    var myPerfil : Perfil? = nil
    var countComplete : Double = 0.0

    var listVacinas = [Vacina]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        circleProgress.setProgress(0, animated: true);
        loadPerfil(perfil: myPerfil!)
        loadUserInformation()
        
        self.myTableVacinas.delegate = self
        self.myTableVacinas.dataSource = self
        
        VacinasDAO.listVaccinesBy(perfil: myPerfil!, onComplete: { vacinas in
            self.listVacinas = vacinas!
            self.myTableVacinas.reloadData()
            
            DispatchQueue.global(qos: .background).async {
                for vacina in self.listVacinas where vacina.isChecked {
                    self.upCount()
                }
            }
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
        self.setProgress(perfil.progress)
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
            return listVacinas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Vacina") {
        
            let vacina = listVacinas[indexPath.row]
            cell.textLabel?.text = vacina.vacina
            cell.detailTextLabel?.text = vacina.dose
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            
            if vacina.isChecked {
                cell.accessoryType = UITableViewCellAccessoryType.checkmark
                self.strikeTo(label: cell.textLabel!, with: cell.textLabel!.text!, with: .styleSingle)
                self.strikeTo(label: cell.detailTextLabel!, with: cell.detailTextLabel!.text!, with: .styleSingle)
            }else{
                cell.accessoryType = UITableViewCellAccessoryType.none
                self.strikeTo(label: cell.textLabel!, with: cell.textLabel!.text!, with: .styleNone)
                self.strikeTo(label: cell.detailTextLabel!, with: cell.detailTextLabel!.text!, with: .styleNone)
            }
    
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(44)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath){
            selectLabel(cell, indexPath.row)
        }
    }
    
    func selectLabel(_ cell : UITableViewCell, _ index : Int){
        // Se a célula estiver checada
        if listVacinas[index].isChecked {
            cell.accessoryType = UITableViewCellAccessoryType.none
            self.strikeTo(label: cell.textLabel!, with: cell.textLabel!.text!, with: .styleNone)
            self.strikeTo(label: cell.detailTextLabel!, with: cell.detailTextLabel!.text!, with: .styleNone)
            
            PerfilDAO.removeVaccine(id: listVacinas[index].id, to: myPerfil!)
            listVacinas[index].isChecked = false
            
            self.downCount()
            
        }else{
            cell.accessoryType = UITableViewCellAccessoryType.checkmark
            self.strikeTo(label: cell.textLabel!, with: cell.textLabel!.text!, with: .styleSingle)
            self.strikeTo(label: cell.detailTextLabel!, with: cell.detailTextLabel!.text!, with: .styleSingle)
            
            PerfilDAO.addVaccine(id: listVacinas[index].id, to: myPerfil!)
            listVacinas[index].isChecked = true
        
            self.upCount()
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
    
    func calcProgress(){
        let myProgress : Double = self.countComplete / Double(self.listVacinas.count)
        self.setProgress(myProgress)
        PerfilDAO.set(progress: myProgress, to: myPerfil!)
    }
    
    func upCount(){
        if self.countComplete <= Double(listVacinas.count) {
            self.countComplete = self.countComplete + 1
            self.calcProgress()
        }
    }
    
    func downCount(){
        if self.countComplete >= 0 {
            self.countComplete = self.countComplete - 1
            self.calcProgress()
        }
    }
    
    func setProgress(_ progress : Double){
        DispatchQueue.main.async {
            self.textProgress.text = "\(String(format:"%.0f", progress * 100))%"
        }
        self.circleProgress.setProgress(progress, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}
