//
//  PasswordTableViewCell.swift
//  PasswordManager
//
//  Created by Italo Henrique Queiroz on 04/04/18.
//  Copyright © 2018 Italo Henrique Queiroz. All rights reserved.
//

import UIKit

class PasswordTableViewCell: UITableViewCell {
    
   
    @IBOutlet weak var faviconImageView: UIImageView!
    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    
    private lazy var presenter = PasswordCellPresenter(view: self)

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func presentFavicon(data: Data){
        DispatchQueue.main.async {
            let image = UIImage(data: data)
            self.faviconImageView.image = image
        }
    }
    
    func presentInfo(url: String, user:String, favicon: Data?) {
        self.urlLabel.text = url
        self.userLabel.text = user
        if let favicon = favicon {
            self.faviconImageView.image = UIImage(data: favicon)
        }
    }
    
    func configureCell(passwordItem: PasswordItem) {
        presenter.passwordItem = passwordItem
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func prepareForReuse() {
        super.prepareForReuse()
    }
   
    
}
