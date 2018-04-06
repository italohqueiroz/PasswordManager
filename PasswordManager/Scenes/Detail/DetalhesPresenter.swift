//
//  DetailViewControllerPresenter.swift
//  PasswordManager
//
//  Created by Italo Henrique Queiroz on 04/04/18.
//  Copyright © 2018 Italo Henrique Queiroz. All rights reserved.
//

import Foundation


class DetalhesPresenter {
    
    private var view: DetalhesViewController
    var passwordItem: PasswordItem? {
        didSet {
            view.present(passwordItem: self.passwordItem!)
        }
    }
    init(view: DetalhesViewController) {
        self.view = view
    }
    
    func replaceItem(with item: PasswordItem) {
        if let passwordItem = self.passwordItem {
            KeychainManager.shared.update(passwordItem, with: item)
        }
    }
    
    func removeItem(){
        if let item = self.passwordItem {
            KeychainManager.shared.remove(item)
            self.view.navigationController?.popViewController(animated: true)
        }
    }
    
}
