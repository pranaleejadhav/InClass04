//
//  PasswordSetupViewController.swift
//  
//
//  Created by Pranalee Jadhav on 11/2/18.
//

import UIKit

class PasswordSetupViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var password_cnt: UITextField!
    @IBOutlet weak var selected_pwd: UILabel!
    @IBOutlet weak var tableview: UITableView!
    let tableArray = ["Weak (Length 5)","Medium (Length 8)","Strong (Length 15)","Extra Strong (Length 25)"]
    let lenArr = [5,8,15,25]
    var count = 0
    
    var selected_len = -1
    var pwdChosen = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.tableFooterView = UIView()
        self.title = "Types"
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        view.isUserInteractionEnabled = true

    }

    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        password_cnt.resignFirstResponder()
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selected_len = lenArr[indexPath.row]
    }
    
    
    @IBAction func create_pwd(_ sender: Any) {
        let cnt = Int(password_cnt.text!)
        guard cnt != nil  else {
            showMsg(title: "", subTitle: "Invalid count")
            return
        }
        
        guard cnt! > 0  else {
            showMsg(title: "", subTitle: "Count > 0")
            return
        }
        
        guard selected_len != -1 else {
            showMsg(title: "", subTitle: "Select length")
            return
        }
        
        
        count = cnt!
        performSegue(withIdentifier: "createpasswords", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        
       let vc = segue.destination as! PasswordsListViewController
            vc.length = selected_len
            vc.cnt = count
            
            print("cnt: \(count) .... len \(selected_len)")
        
        
    }
    
   
    
    func showMsg(title: String, subTitle: String) -> Void {
        DispatchQueue.main.async(execute: {
            let alertController = UIAlertController(title: title, message:
                subTitle, preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
        })
    }
    
    @IBAction func unwindToVC(segue:UIStoryboardSegue) {
        selected_pwd.text = pwdChosen
    }
}
