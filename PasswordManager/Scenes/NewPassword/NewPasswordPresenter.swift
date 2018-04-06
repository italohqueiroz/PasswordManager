//
//  NewPasswordPresenter.swift
//  PasswordManager
//
//  Created by Italo Henrique Queiroz on 04/04/18.
//  Copyright © 2018 Italo Henrique Queiroz. All rights reserved.
//

import Foundation



class NewPasswordPresenter {
    
    let view: NewPasswordViewController
    init(view: NewPasswordViewController){
        self.view = view
    }

    func saveButtonPressed(url: String, email: String, senha: String){
        let passwordItem = PasswordItem(url: url, email: email, senha: senha)
        KeychainManager.shared.add(passwordItem)
        view.back()
    }
    
    
}
