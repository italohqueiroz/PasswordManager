//
//  AlertViewController.swift
//  PasswordManager
//
//  Created by Italo Henrique Queiroz on 03/04/18.
//  Copyright © 2018 Italo Henrique Queiroz. All rights reserved.
//

import UIKit

@IBDesignable
class AlertViewController: UIViewController {

    @IBOutlet weak var optionsStack: UIStackView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    private(set) var views = [Int:UIView]()
    var canDismiss: Bool = true
    
    var closureTrigger:[Any] = []
    
    func add(view: UIView, with id: Int){
        self.views[id] = view
        self.stackView.addArrangedSubview(view)
    }
    
    func removeView(with id: Int) -> Bool{
        let view = self.views[id]
        let result = self.views.removeValue(forKey: id)
        view?.removeFromSuperview()
        return result != nil
    }
    
    
    func showAlert(){
        self.view.superview?.isUserInteractionEnabled = true
        UIView.animate(withDuration: 0.35) {
            let view = self.view!
            view.alpha = 1
            view.isHidden = false
        }
    }
    
    func hideAlert(){
        self.view.superview?.isUserInteractionEnabled = false
        let view = self.view!
        UIView.animate(withDuration: 0.35) {
            view.alpha = 0
            view.isHidden = true
        }
        self.removeAll()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setTitle(title:String){
        self.titleLabel.text = title
    }
    
    
    func addActivityView(for tag: Int) -> UIActivityIndicatorView? {
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
        activityIndicator.startAnimating()
        self.add(view: activityIndicator, with: tag)
        return activityIndicator
    }
    
    func addTextView(for tag: Int) -> UITextView {
        let textView = UITextView()
        textView.textColor = .white
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.backgroundColor = .clear
        self.add(view: textView, with: tag)
        self.view.layoutIfNeeded()
        self.view.layoutSubviews()
        return textView
    }
    
    func addOption(title: String,with tag: Int, action: @escaping (UIButton)->()){
        class ClosureTrigger : NSObject {
            let closure:(UIButton) -> ()
            
            init(closure: @escaping (UIButton) -> ()) {
                self.closure = closure
                
                super.init()
            }
            
            @objc func trigger(_ button:UIButton) {
                closure(button)
            }
        }
        let button = UIButton()
        let trigger = ClosureTrigger(closure: action)
        self.closureTrigger.append(trigger)
        button.setTitle(title, for: .normal)
        button.backgroundColor = .clear
        button.setTitleColor(.white, for: .normal)
        button.addTarget(trigger, action: #selector(trigger.trigger(_:)), for: .touchUpInside)
        self.optionsStack.addArrangedSubview(button)
        self.views[tag] = optionsStack
    }


    func removeAll(){
        for view in self.views {
            view.value.removeFromSuperview()
        }
        self.views.removeAll()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if canDismiss {
            hideAlert()
        }
    }

}
