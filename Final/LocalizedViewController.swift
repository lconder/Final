//
//  LocalizedViewController.swift
//  Final
//
//  Created by Luis Conde on 30/01/18.
//  Copyright © 2018 Luis Conde. All rights reserved.
//

import UIKit

class LocalizedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.showAlert()
    }
    
    
    func showAlert(){
    
        let alertTitle = NSLocalizedString("WELCOME", comment: "")
        let alertMessage = NSLocalizedString("THANK_YOU", comment: "")
        let cancelButtonText = NSLocalizedString("CANCEL", comment: "")
        let signupButtonText = NSLocalizedString("SIGNUP", comment: "")
        
        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: cancelButtonText, style: .destructive, handler: nil)
        let signupAction = UIAlertAction(title: signupButtonText, style: .destructive, handler: nil)
        
        alertController.addAction(cancelAction)
        alertController.addAction(signupAction)
        
        self.present(alertController, animated: true, completion: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
