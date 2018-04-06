//
//  PasswordItem.swift
//  PasswordManager
//
//  Created by Italo Henrique Queiroz on 01/04/18.
//  Copyright © 2018 Italo Henrique Queiroz. All rights reserved.
//

import Foundation


class PasswordItem: Codable, Equatable {
  
 

    private(set) var url: String
    private(set) var email: String
    private(set) var senha: String
    var favicon: Data?
    
    public init(url: String,email: String, senha: String, favicon: Data? = nil) {
        self.url = url
        self.email = email
        self.senha = senha
    }

    static func ==(lhs: PasswordItem, rhs: PasswordItem) -> Bool {
        return lhs.url == rhs.url && lhs.email == rhs.email
    }
    
    func copy() -> PasswordItem {
        return PasswordItem(url: self.url, email: self.email, senha: self.senha)
    }

}
