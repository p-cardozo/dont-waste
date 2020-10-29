//
//  ProximoAcessoViewController.swift
//  projeto-dont-waste
//
//  Created by Patricia dos Santos Cardozo on 28/10/20.
//

import UIKit

class ProximoAcessoViewController: UIViewController {

    @IBOutlet weak var botaoProximo: UIButton!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var senhaTextField: UITextField!
    @IBOutlet weak var dicaLabel: UILabel!
    
    @IBOutlet weak var validationLabel: UILabel!
    
    override func viewDidLoad() {
        dicaLabel.isHidden = true
        super.viewDidLoad()
        self.botaoProximo.layer.borderWidth = 1
        self.botaoProximo.layer.borderColor = UIColor.black.cgColor
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        self.view.addGestureRecognizer(tap)
        
        validationLabel.isHidden = true
    }
    
    var timer: Timer?
    
  //botao casa - para retornar para a pagina home
    @IBAction func botaoCasa(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
   //botao dica - colocar dica da senha
    @IBAction func botaoTooltip(_ sender: Any) {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
                self.dicaLabel.isHidden = false
            }
        timer = Timer.scheduledTimer (timeInterval: 5.0, target: self, selector: #selector (timerAction), userInfo: nil, repeats: false)
    }
    
    @objc func timerAction () {
        dicaLabel.isHidden = true
        }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return false
    }
    
    @IBAction func botaoProximo(_ sender: Any) {
    
        if emailTextField.text == "" || senhaTextField.text == ""{
             mostraAlerta(mensagem: "Preencha todos os campos")
        } else
            if emailTextField.text!.validaEmail && senhaTextField.text!.validaSenha {
               performSegue(withIdentifier: "cadastroViewController", sender: nil)
               
        }else {
            if emailTextField.text?.validaEmail == false{
                validationLabel.isHidden = false
                validationLabel.text = "Email invalido"
            } else{
                senhaTextField.text?.validaSenha == false
                validationLabel.isHidden = false
                validationLabel.text = "Senha invalida"
            }
            
        }
        timer = Timer.scheduledTimer (timeInterval: 3.0, target: self, selector: #selector (actionTimer), userInfo: nil, repeats: false)
    }
    
    @objc func actionTimer () {
        validationLabel.isHidden = true
        }
    
    
    
    // popup alerta caso os campos estiverem vazios ou invalidos
    func mostraAlerta(mensagem: String){
    let alert = UIAlertController(title: "Atenção", message: mensagem, preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
    self.present(alert, animated: true, completion: nil)
    }

}
