//
//  CadastroViewController.swift
//  projeto-dont-waste
//
//  Created by Patricia dos Santos Cardozo on 28/10/20.
//

import UIKit

class CadastroViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    

    @IBOutlet weak var textField: UITextField?
    @IBOutlet weak var botaoVoltar: UIButton?
    @IBOutlet weak var botaoSalvar: UIButton?
    @IBOutlet weak var qtdField: UITextField?
    @IBOutlet weak var freqField: UITextField?
    @IBOutlet weak var dateField: UITextField?
   
    
    
    var freq1Compras: [String] = []
    var qtd2Pessoas: [String] = []
    
    var pickerView = UIPickerView()
    var pickerView2 = UIPickerView()
    
    let datePicker = UIDatePicker()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTextField()
        self.setupButton()
        self.textField?.delegate = self
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        pickerView2.delegate = self
        pickerView2.dataSource = self
        
        createDatePicker()
    }
    
    @IBAction func saveButton(_ sender: Any) {
        
        if (textField!.text == "" || qtdField?.text == "" || dateField!.text == "" ||
            freqField!.text == "")
            {
                   mostraAlerta(mensagem: "Preencha todos os campos")
        } else {
            mostraAlerta(mensagem: "Informações Salvas")
            
        }
        
       }
    
    
    
    // popup alerta caso os campos estiverem vazios ou invalidos
       func mostraAlerta(mensagem: String){
       let alert = UIAlertController(title: "Atenção", message: mensagem, preferredStyle: UIAlertController.Style.alert)
       alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
       self.present(alert, animated: true, completion: nil)
       }
    @IBAction func botaoHome(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    @IBAction func botaoVoltar(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func setupTextField() {
        
        guard let qtdField = self.qtdField else { return }
        qtdField.inputView = pickerView
        qtdField.textAlignment = .center
        qtdField.placeholder = "Selecione"
        
        guard let freqField = self.freqField else { return }
        freqField.inputView = pickerView2
        freqField.textAlignment = .center
        freqField.placeholder = "Selecione"
    }
    
    func setupButton() {
        self.botaoVoltar?.layer.borderWidth = 1
        self.botaoVoltar?.layer.borderColor = UIColor.black.cgColor
        self.botaoSalvar?.layer.borderWidth = 1
        self.botaoSalvar?.layer.borderColor = UIColor.black.cgColor
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxCharCount = 200
        
        let currentString: NSString = (textField.text ?? "") as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxCharCount
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        freq1Compras = ["Pontual", "Semanal", "Quinzenal", "Mensal"]
        qtd2Pessoas = ["1","2", "3 ou Mais"]
        
        if pickerView == self.pickerView2 {
            return freq1Compras.count
        } else {
            return qtd2Pessoas.count
        }
    }
    
    internal func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == self.pickerView2 {
            return "\(freq1Compras[row])"
        } else {
            return "\(qtd2Pessoas[row])"
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == self.pickerView2 {
        guard let freqField = self.freqField else { return }
            freqField.text = freq1Compras[row]
            freqField.resignFirstResponder()
        } else {
        guard let qtdField = self.qtdField else { return }
            qtdField.text = qtd2Pessoas[row]
            qtdField.resignFirstResponder()
        }
        
    }
    
    func createDatePicker() {
        
        let daycomp = DateComponents(year: -1 )
        let date = Calendar.current.date(byAdding: daycomp, to: Date())
        
        // first create a toolBar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        guard let dateField = self.dateField else { return }
        // center the date
        dateField.textAlignment = .center
        // Assign the tool bar
        dateField.inputAccessoryView = toolbar
        // Assign date picker view to the tool bar
        dateField.inputView = datePicker
        // Placeholder
        dateField.placeholder = "Selecione"
        
        // Create a done button (bar button)
               let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
               toolbar.setItems([doneBtn], animated: true)
        
        // date picker mode (without hours)
               datePicker.datePickerMode = .date
        
//        datePicker.maximumDate = Date()
               datePicker.minimumDate = date
    }
    
    @objc func donePressed() {
        // formatter to just date
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        // show the date inside of my textField
        guard let dateField = self.dateField else { return }
        dateField.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
        
    }
}
