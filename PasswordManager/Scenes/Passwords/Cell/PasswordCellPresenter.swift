//
//  CellPresenter.swift
//  PasswordManager
//
//  Created by Italo Henrique Queiroz on 04/04/18.
//  Copyright © 2018 Italo Henrique Queiroz. All rights reserved.
//

import Foundation

class PasswordCellPresenter {
    
    private let view: PasswordTableViewCell
    var passwordItem: PasswordItem? {
        didSet {
            self.configureCell()
        }
    }
    init(view: PasswordTableViewCell) {
        self.view = view
    }

    
    private func configureCell(){
        let passwordItem = self.passwordItem!
        self.view.presentInfo(url: passwordItem.url, user: passwordItem.email,favicon: passwordItem.favicon)
        self.fetchFaviconIfNecessary()
    }
    
    private func fetchFaviconIfNecessary(){
        guard self.passwordItem!.favicon == nil else {return}
        let url = passwordItem!.url
        NetworkManager.shared.logo(url: url, completion: {(data, errors) in
            guard let data = data, errors.count == 0 else {return}
            if url == self.passwordItem!.url {
                self.passwordItem?.favicon = data
                self.view.presentFavicon(data: data)
            }
        })
    }
    
}
