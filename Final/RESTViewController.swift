//
//  RESTViewController.swift
//  Final
//
//  Created by Luis Conde on 30/01/18.
//  Copyright © 2018 Luis Conde. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class RESTViewController: UITableViewController {
    
    var contacts: [Contact] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.getData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addPressed(_ sender: UIButton) {
        
        let alertController = UIAlertController(title: "Nuevo contacto", message: "", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .destructive, handler: nil)
        
        alertController.addAction(cancelAction)
        
        let addAction = UIAlertAction(title: "Agregar", style: .default) { (action) in
            
            let nameContact = (alertController.textFields?.first!)?.text
            print(nameContact!)
            
            let numberContact = (alertController.textFields?[1])?.text
            print(numberContact!)
            
            self.postData(name: nameContact!, number: numberContact!)
            
            
        }
        
        alertController.addTextField { (textField) in
            textField.textColor = UIColor.black
            textField.placeholder = "Nombre del contacto"
        }
        
        alertController.addTextField { (textField) in
            textField.textColor = UIColor.black
            textField.placeholder = "Número del contacto"
        }
        
        alertController.addAction(addAction)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    
    //MARK: - Alamofire
    
    func postData(name: String, number: String){
        
        
        let parameters: Parameters = ["name": name, "phone": number]
        
        let url = "\(GlobalConstants.Server)/test"
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
        .responseJSON { (response) in
            
            switch response.result {
            case .success:
                print(response.result.value!)
            case .failure:
                print("Error")
            }
        }
        self.getData()
        
    }
    
    
    
    
    func getData() {
        
        self.contacts.removeAll()
    
        let url = "\(GlobalConstants.Server)/test"
        
        Alamofire.request(url).responseData { (response) in
            
            switch response.result {
            
            case .success:
                
                if response.result.value != nil {
                    
                    let jsonResponse = JSON(response.result.value!)
                    
                    if let dataContacts = jsonResponse["contacts"].array {
                        
                        for val in dataContacts {
                            
                            let contact = Contact()
                            
                            if let phone = val["phone"].dictionary {
                                
                                if let mobile = phone["mobile"]?.stringValue {
                                    
                                    contact.name = val["name"].stringValue
                                    contact.number = mobile
                                }
                            }
                         self.contacts.append(contact)
                        }
                    }
                }
                
            case .failure:
                print("Error")
            }
            self.tableView.reloadData()
        }
    
    
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return contacts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellContact", for: indexPath) as! ContactCell
        
        cell.nameContact.text = contacts[indexPath.row].name
        cell.numberContact.text = contacts[indexPath.row].number
        
        return cell
        
    }

   

}
