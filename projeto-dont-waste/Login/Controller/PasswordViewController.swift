//
//  PasswordViewController.swift
//  projeto-dont-waste
//
//  Created by Patricia dos Santos Cardozo on 28/10/20.
//

import UIKit

class PasswordViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        validationLabel.isHidden = true
        self.sendButton.layer.borderWidth = 1
        self.sendButton.layer.borderColor = UIColor.black.cgColor
    }
    
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var validationLabel: UILabel!
    @IBOutlet weak var emailField: UITextField!
    @IBAction func HomeButton(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    var timer = Timer()
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
            return false
        }
    
    
    @IBAction func sendButton(_ sender: Any) {
        
               if emailField.text == "" {
                    mostraAlerta(mensagem: "Preencha o campo")
               } else
                   if emailField.text!.validaEmail  {
                  navigationController?.popViewController(animated: true)

               }else {
                   if emailField.text?.validaEmail == false{
                       validationLabel.isHidden = false
                       validationLabel.text = "Email invalido"
                
                   }
               }
        
        timer = Timer.scheduledTimer (timeInterval: 5.0, target: self, selector: #selector (timerAction), userInfo: nil, repeats: false)
    }
    @objc func timerAction () {
    validationLabel.isHidden = true
    }
    
    func mostraAlerta(mensagem: String){
    let alert = UIAlertController(title: "Atenção", message: mensagem, preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
    self.present(alert, animated: true, completion: nil)
    }

}
