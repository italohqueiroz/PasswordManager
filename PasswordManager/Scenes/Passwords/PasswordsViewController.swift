//
//  PasswordsViewController.swift
//  PasswordManager
//
//  Created by Italo Henrique Queiroz on 03/04/18.
//  Copyright © 2018 Italo Henrique Queiroz. All rights reserved.
//

import UIKit

class PasswordsViewController: UIViewController {

    
    private lazy var presenter = PasswordsPresenter(view: self)
    @IBOutlet weak var passwordTableView: UITableView!
    
    @IBAction func addPassword(_ sender: Any) {
    
        self.performSegue(withIdentifier: "NovaSenhaSegue", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureNavigationBar()
        self.configureTableView()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.fetchItems()
        passwordTableView.reloadSections(NSIndexSet(index: 0) as IndexSet, with: .none)
    }
    
    func configureTableView(){
        self.passwordTableView.register(UINib.init(nibName: "PasswordTableViewCell", bundle: nil), forCellReuseIdentifier: "PasswordCellIdentifier")
        self.passwordTableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        self.passwordTableView.rowHeight = 65
    }

    func configureNavigationBar(){
        if let navigationBar = self.navigationController?.navigationBar {
                navigationBar.setBackgroundImage(UIImage(), for: .default)
                navigationBar.shadowImage = UIImage()
                navigationBar.isTranslucent = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let index = sender as? IndexPath else {return}
        if segue.identifier == "DetalhesIdentifier" {
            if let viewController = segue.destination as? DetalhesViewController {
                viewController.presenter.passwordItem = self.presenter.item(by: index.row)
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension PasswordsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "DetalhesIdentifier", sender: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension PasswordsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.itemsCount
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = cell as! PasswordTableViewCell
        cell.faviconImageView.image = nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PasswordCellIdentifier", for: indexPath) as! PasswordTableViewCell
        let item = presenter.item(by: indexPath.row)
        cell.configureCell(passwordItem: item)
        return cell
    }
    
}
