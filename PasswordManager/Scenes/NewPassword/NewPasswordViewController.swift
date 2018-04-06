//
//  NewPasswordViewController.swift
//  PasswordManager
//
//  Created by Italo Henrique Queiroz on 03/04/18.
//  Copyright © 2018 Italo Henrique Queiroz. All rights reserved.
//

import UIKit

class NewPasswordViewController: UIViewController {
    
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var senhaTextField: UITextField!
    
    @IBOutlet var textFields: [UITextField]!
    
    @IBAction func save(_ sender: Any) {
        self.sendValuesToPresenter()
    }
    private lazy var presenter = NewPasswordPresenter(view: self)
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func sendValuesToPresenter() {
        guard let url = urlTextField.text, let email = emailTextField.text, let senha = senhaTextField.text else {return}
        presenter.saveButtonPressed(url: url, email: email, senha: senha)
    }

    func back(){
        self.navigationController?.popViewController(animated: true)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for textField in textFields {
            textField.resignFirstResponder()
        }
    }
}
