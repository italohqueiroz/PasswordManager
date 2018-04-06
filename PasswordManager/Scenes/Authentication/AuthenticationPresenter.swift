//
//  AuthenticationPresenter.swift
//  PasswordManager
//
//  Created by Italo Henrique Queiroz on 02/04/18.
//  Copyright © 2018 Italo Henrique Queiroz. All rights reserved.
//

import Foundation
import LocalAuthentication

class AuthenticationPresenter {
    
    var view: AuthenticationViewController!
    private var isLogin: Bool = true
    
    init() {
        DispatchQueue.main.async {
            self.authenticate()
        }
    }

    func switchMode(){
        if self.isLogin {
            self.view.loginToRegister()
        } else{
            self.view.registerToLogin()
        }
        
        self.isLogin = !self.isLogin
    }
    
    func send(){
        if isLogin {
            login()
        } else {
            register()
        }
    }
    
    private func login(){
        guard let email = self.view.emailTextField.text, let senha = self.view.senhaTextField.text else {
           // error("Preencha todos os campos")
            return
        }
        let _ = self.view.addActivityView(for: 1)
        self.view.showAlert()
        
        self.view.setTitle(title: "carregando...")
        NetworkManager.shared.login(email: email, senha: senha) { (success, errors) in
            if success {
                self.saveCredentials(email: email, senha: senha)
                self.firstLogin()
            } else {
                DispatchQueue.main.async {
                    let _ = self.view.getAlertViewController()?.removeView(with: 1)
                    self.view.setTitle(title: "Error")
                    let textView = self.view.addTextView(for: 1)
                    textView?.text = errors.first
                }
            }
        }
    }
    
    private func saveCredentials(email: String, senha: String) {
        KeychainManager.set(email, for: KeychainManager.kAccountEmail)
        KeychainManager.set(senha, for: KeychainManager.kAccountPassword)
    }
    
    private func register(){
        guard let name = self.view.nameTextField.text,let email = self.view.emailTextField.text, let senha = self.view.senhaTextField.text else {
       //     error("Preencha todos os campos")
            return
        }
        let _ = self.view.addActivityView(for: 1)
        self.view.showAlert()
        self.view.setTitle(title: "carregando...")
        self.view.getAlertViewController()?.canDismiss = false
        NetworkManager.shared.register(name: name, email: email, senha: senha) {(success, errors) in
            self.view.getAlertViewController()?.canDismiss = true
            if success {
                self.saveCredentials(email: email, senha: senha)
                self.firstLogin()
            } else {
                DispatchQueue.main.async {
                let _ = self.view.getAlertViewController()?.removeView(with: 1)
                    self.view.setTitle(title: "Error")
                    let textView = self.view.addTextView(for: 1)
                    textView?.text = errors.first
                }
            }
        }
    }
    
    
    private func firstLogin(){
        if KeychainManager.string(for: KeychainManager.kBiometrics) == nil{
            self.wantLoginWithBiometrics(completion: { (success) in
                if success {
                    self.loginWithBiometrics({ (success) in
                        KeychainManager.set("false", for: KeychainManager.kBiometrics)
                        if success {
                            KeychainManager.set("true", for: KeychainManager.kBiometrics)
                        }
                        self.peformPasswords()
                    })
                }else {
                    KeychainManager.set("false", for: KeychainManager.kBiometrics)
                    self.peformPasswords()
                }
            })
        }else {
            self.peformPasswords()
        }
    }
    
    private func wantLoginWithBiometrics(completion:@escaping (Bool) -> ()){
        if let alertVC = self.view.getAlertViewController() {
            DispatchQueue.main.async {
                alertVC.removeAll()
                alertVC.addOption(title: "Sim", with: 5, action: {button in
                    alertVC.hideAlert()
                    alertVC.canDismiss = true
                    completion(true)
                })
                alertVC.addOption(title: "Não", with: 5, action: { button in
                    alertVC.hideAlert()
                    alertVC.canDismiss = true
                    completion(false)
                })
                alertVC.setTitle(title: "Login com biometria?")
                alertVC.canDismiss = false
                alertVC.showAlert()
            }
        }
    }
    
    
    private func peformPasswords(){
        self.view.performSegue(withIdentifier: "PasswordsSegue", sender: nil)
    }
    
    func authenticate() {
        if let auth = KeychainManager.getAuthentication() {
            if let biometrics = KeychainManager.string(for: KeychainManager.kBiometrics){
                if biometrics == "true" {
                    self.loginWithBiometrics(){ success in
                        DispatchQueue.main.async {
                            if success {
                                let auth = KeychainManager.getAuthentication()!
                                self.view.emailTextField.text = auth.0
                                self.view.senhaTextField.text = auth.1
                                self.login()
                            }
                        }
                    }
                }else if biometrics == "false" {
                    self.loginWithPassword(email: auth.0)
                }
            }
        }
    }
    
    private func loginWithBiometrics(_ completion: @escaping (Bool) -> ()) {
        let context = LAContext()
        var authError: NSError? = nil
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Login", reply: { (success, err) in
                if success {
                    completion(true)
                }else{
                    completion(false)
                }
            })
        }else{
            completion(false)
        }
    }
    
    private func loginWithPassword(email: String){
        if let auth = KeychainManager.getAuthentication() {
            self.view.emailTextField.text = auth.0
        }
    }
    
}
