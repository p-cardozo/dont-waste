//
//  HomeLogadaViewController.swift
//  projeto-dont-waste
//
//  Created by Patricia dos Santos Cardozo on 28/10/20.
//

import UIKit

class HomeLogadaViewController: UIViewController {

    
    @IBOutlet weak var vencimentoBotao: UIButton!
    @IBOutlet weak var desperdicioBotao: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.vencimentoBotao.layer.borderWidth = 1
        self.vencimentoBotao.layer.borderColor = UIColor.black.cgColor
        self.desperdicioBotao.layer.borderWidth = 1
        self.desperdicioBotao.layer.borderColor = UIColor.black.cgColor
    }

}
