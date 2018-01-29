//
//  TouchIDViewController.swift
//  Final
//
//  Created by Luis Conde on 27/01/18.
//  Copyright © 2018 Luis Conde. All rights reserved.
//

import UIKit
import LocalAuthentication

class TouchIDViewController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func buttonTouchPressed(_ sender: UIButton) {
        
        let context = LAContext()
        var error: NSError?
        
        let reason = "Necesitamos comprobar tú identitdad por medio de tu huella"
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason, reply: { (success, error) in
                
                if success{
                    print("Huella identificada")
                }else{
                    
                    if let error =  error as NSError? {
                    
                        switch error.code {
                        case LAError.systemCancel.rawValue:
                            print("El sistema ha cancelado el proceso de login")
                        case LAError.userCancel.rawValue:
                            print("El usuario ha cancelado el proceso de login")
                        case LAError.userFallback.rawValue:
                            print("El usuario ha elegido otro método para el login")
                        default:
                            break
                        
                        }
                    }
                }
            })
        
        }else{
            
            if let error = error {
            
                switch error.code {
                case LAError.touchIDNotEnrolled.rawValue:
                    print("El usuario no ha configurado su TouchID")
                case LAError.passcodeNotSet.rawValue:
                    print("El usuario no tiene PIN definido")
                default:
                    print("Touch ID no está disponible")
                }
                
            }
        }
        
        
    }
    
    func showAlert(){
        
        let alertController = UIAlertController(title: "Éxito", message: "El usuario se ha identificado", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        
        self.present(alertController, animated: true, completion: nil)
    
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}
