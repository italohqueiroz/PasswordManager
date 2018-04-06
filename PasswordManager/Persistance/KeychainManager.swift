//
//  KeychainManager.swift
//  PasswordManager
//
//  Created by Italo Henrique Queiroz on 01/04/18.
//  Copyright © 2018 Italo Henrique Queiroz. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

class KeychainManager {
    static let kItemKeys = "PasswordItemKeys"
    static let kAccountPassword = "AcountPassowrd"
    static let kAccountEmail = "AcountEmail"
    static let kBiometrics = "AccountBiometrics"
    static let kItems = "PasswordItems"
    
    static let shared = KeychainManager()
  
    public static func string(for key: String) -> String? {
        return KeychainWrapper.standard.string(forKey: key)
    }
    
    public static func set(_ string: String, for key: String){
        KeychainWrapper.standard.set(string, forKey: key, withAccessibility: nil)
    }

    public static func remove(with key: String) {
        KeychainWrapper.standard.removeObject(forKey: key)
    }
    
    public static func passwordItem(for key: String) -> PasswordItem? {
        return KeychainWrapper.standard.object(forKey: key) as? PasswordItem
    }
    
    public static func getAuthentication() -> (String,String)? {
        guard let email = self.string(for: kAccountEmail),let senha = self.string(for: kAccountPassword) else {
            return nil
        }
        return (email,senha)
    }
    
    public static func savePassword(email: String,senha:String){
        self.set(email, for: kAccountEmail)
        self.set(senha, for: kAccountPassword)
    }
    
    
    private init(){}
}

extension KeychainManager {
    
    func add(_ item: PasswordItem) {
        var items = self.getAll()
        items.append(item)
        self.addAll(items)
    }
    
    func update(_ item: PasswordItem, with new: PasswordItem){
        let items = self.getAll()
        if let index = items.index(of: item) {
            if let mutableItems = (items as NSArray).mutableCopy() as? NSMutableArray{
                mutableItems.replaceObject(at: index, with: new)
                self.addAll(mutableItems as! [PasswordItem])
            }
        }
    }
    
    func remove(_ item: PasswordItem) {
        var items = self.getAll()
        if let index = items.index(of: item) {
            items.remove(at: index)
            self.addAll(items)
        }
    }
    
    
    func getAll() -> [PasswordItem] {
        guard let items = KeychainWrapper.standard.data(forKey: KeychainManager.kItems) else {
            return []
        }
        let ret = try? JSONDecoder().decode([PasswordItem].self, from: items)
        return ret ?? []
        
    }
    
    func addAll(_ items: [PasswordItem]) {
        guard let encoded = try? JSONEncoder().encode(items) else { return }
        KeychainWrapper.standard.set(encoded, forKey: KeychainManager.kItems)
    }
    
}

