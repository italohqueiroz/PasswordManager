//
//  ViewController.swift
//  PasswordManager
//
//  Created by Italo Henrique Queiroz on 01/04/18.
//  Copyright © 2018 Italo Henrique Queiroz. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
class AuthenticationViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var nameView: UIViewDesignable!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var senhaTextField: UITextField!
    @IBOutlet weak var switchButton: UIButton!
    @IBOutlet weak var sendButton: UIButtonDesignable!
    @IBOutlet var textFields: [UITextField]!
    lazy var alertViewController: AlertViewController? = {
        return self.containerView.subviews.first?.viewController() as? AlertViewController
    }()
    fileprivate var isLogin = true
    fileprivate var presenter = AuthenticationPresenter()
    
    @IBAction func switchMode(_ sender: Any) {
       self.presenter.switchMode()
    }
    
    @IBAction func send(_ sender: Any) {
        self.presenter.send()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.view = self
    }
    
    func loginToRegister(){
        UIView.animate(withDuration: 0.35) {
            self.nameView.alpha = 1
            self.nameView.isHidden = false
            self.switchButton.setTitle("logar-se", for: .normal)
            self.sendButton.setTitle("registrar", for: .normal)
        }
    }
    
    func registerToLogin(){
        UIView.animate(withDuration: 0.35) {
            self.nameView.alpha = 0
            self.nameView.isHidden = true
            self.switchButton.setTitle("registre-se", for: .normal)
            self.sendButton.setTitle("login", for: .normal)
        }
    }
    
    func getAlertViewController() -> AlertViewController? {
        return self.alertViewController
    }
    
    func addActivityView(for tag: Int) -> UIActivityIndicatorView? {
        return self.getAlertViewController()?.addActivityView(for: tag)
    }
    
    func addTextView(for tag: Int) -> UITextView? {
        if let alertView = self.getAlertViewController() {
            let textView = alertView.addTextView(for: tag)
            textView.sizeToFit()
            return textView
        }
        return nil
    }
    
    func getView(for tag: Int) -> UIView? {
        return self.getAlertViewController()?.views[tag]
    }
    
    func setTitle(title: String) {
         self.getAlertViewController()?.setTitle(title: title)
    }
    
    func showAlert(){
        self.getAlertViewController()?.showAlert()
    }

    func hideAlert(){
        self.getAlertViewController()?.hideAlert()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for textField in textFields {
            textField.resignFirstResponder()
        }
    }
    
}

