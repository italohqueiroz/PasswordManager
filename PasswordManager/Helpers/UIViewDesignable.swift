//
//  UIViewDesignable.swift
//  PasswordManager
//
//  Created by Italo Henrique Queiroz on 02/04/18.
//  Copyright © 2018 Italo Henrique Queiroz. All rights reserved.
//

import UIKit


@IBDesignable
class UIViewDesignable: UIView {
    
    @IBInspectable
    public var cornerRadius: CGFloat = 0 {
        didSet{
            self.layer.cornerRadius = self.cornerRadius
        }
    }
    
    @IBInspectable
    public var shadowRadius: CGFloat = 0 {
        didSet{
            self.layer.shadowRadius = self.shadowRadius
        }
    }
    
    @IBInspectable
    public var shadowOffset: CGSize = .zero {
        didSet{
            self.layer.shadowOffset = self.shadowOffset
        }
    }
    
    @IBInspectable
    public var shadowOpacity: Float = 0 {
        didSet{
            self.layer.shadowOpacity = self.shadowOpacity
        }
    }
    
    @IBInspectable
    public var shadowColor: UIColor? = nil {
        didSet{
            self.layer.shadowColor = self.shadowColor?.cgColor
        }
    }
    

    
}
