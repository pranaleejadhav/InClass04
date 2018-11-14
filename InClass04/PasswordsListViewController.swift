//
//  PasswordsListViewController.swift
//  
//
//  Created by Pranalee Jadhav on 11/2/18.
//

import UIKit

class PasswordsListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var length:Int!
    var cnt:Int!
    var tableArray = [String]()
    var pwd_chosen = ""
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        self.title = "Passwords"
        createPasswords()
        
        
        // Do any additional setup after loading the view.
    }
    
    

    func createPasswords() {
        DispatchQueue.global().async {
            for _ in 0..<self.cnt {
                self.tableArray.append(AppsData.getPassword(len: self.length))
            }
            
            print(self.tableArray)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellItem")
        cell?.textLabel?.text = tableArray[indexPath.row]
        return cell!
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! PasswordSetupViewController
        vc.pwdChosen = tableArray[(tableView.indexPathForSelectedRow?.row)!]// pwd_chosen
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    
}
