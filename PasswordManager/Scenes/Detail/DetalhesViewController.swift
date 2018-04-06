//
//  DetalhesViewController.swift
//  PasswordManager
//
//  Created by Italo Henrique Queiroz on 03/04/18.
//  Copyright © 2018 Italo Henrique Queiroz. All rights reserved.
//

import UIKit

class DetalhesViewController: UIViewController {

    @IBOutlet weak var faviconImageView: UIImageView!
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    lazy var presenter = DetalhesPresenter(view: self)
    @IBOutlet weak var showPassowordButton: UIButton!
    @IBOutlet var textFields: [UITextField]!
    @IBOutlet weak var containerView: UIView!
    lazy var alertViewController: AlertViewController? = {
        return self.containerView.subviews.first?.viewController() as? AlertViewController
    }()
    
    
    @IBAction func deletar(_ sender: Any) {
        alertViewController?.canDismiss = true
        alertViewController?.addOption(title: "excluir", with: 0, action: { (button) in
            self.presenter.removeItem()
            self.alertViewController?.hideAlert()
        })
        alertViewController?.addOption(title: "cancelar", with: 1, action: { (button) in
            self.alertViewController?.hideAlert()
        })
        alertViewController?.setTitle(title: "Deseja excluir?")
        alertViewController?.showAlert()
    }
    
    @IBAction func copyPassword(_ sender: UIButton) {
        if let text = self.passwordTextField.text {
            DispatchQueue.main.async {
                UIPasteboard.general.string = text
            }
            alertViewController?.setTitle(title: "Senha copiada!")
            alertViewController?.canDismiss = true
            alertViewController?.showAlert()
        }
    }
    
    @IBAction func showPassword(_ sender: UIButton) {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
        self.showPassowordButton.isSelected = !self.showPassowordButton.isSelected
    }
    
    @IBAction func save(_ sender: Any) {
        guard let url = urlTextField.text,let user = userTextField.text,let senha = passwordTextField.text else {return}
        self.presenter.replaceItem(with: PasswordItem(url: url, email: user, senha: senha))
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showPassowordButton.setImage(#imageLiteral(resourceName: "eye-closed"), for: .selected)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func present(passwordItem: PasswordItem) {
        DispatchQueue.main.async {
            self.urlTextField.text = passwordItem.url
            self.userTextField.text = passwordItem.email
            self.passwordTextField.text = passwordItem.senha
            self.faviconImageView.image = UIImage(data: passwordItem.favicon!)
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for textField in textFields {
            textField.resignFirstResponder()
        }
    }
    
}
