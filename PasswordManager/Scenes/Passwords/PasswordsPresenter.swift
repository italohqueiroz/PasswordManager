//
//  PasswordsPresenter.swift
//  PasswordManager
//
//  Created by Italo Henrique Queiroz on 04/04/18.
//  Copyright © 2018 Italo Henrique Queiroz. All rights reserved.
//

import Foundation


class PasswordsPresenter {
    
    
    private let view: PasswordsViewController
    private var items:[PasswordItem]
    var itemsCount: Int {
        return items.count
    }
    
    init(view: PasswordsViewController) {
        self.view = view
        self.items = KeychainManager.shared.getAll()
    }
    
    func fetchItems(){
        self.items = KeychainManager.shared.getAll()
    }
    
    func item(by index: Int) -> PasswordItem {
        return items[index]
    }

}
