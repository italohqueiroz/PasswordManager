//
//  UIButtonDesignable.swift
//  PasswordManager
//
//  Created by Italo Henrique Queiroz on 02/04/18.
//  Copyright © 2018 Italo Henrique Queiroz. All rights reserved.
//

import UIKit

@IBDesignable
class UIButtonDesignable: UIButton {
    
    @IBInspectable
    public var cornerRadius: CGFloat = 0 {
        didSet{
            let newCornerRadius = self.frame.height*self.cornerRadius
            self.layer.cornerRadius = newCornerRadius
        }
    }
    
}
