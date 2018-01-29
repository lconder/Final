//
//  ViewController.swift
//  Final
//
//  Created by Luis Conde on 27/01/18.
//  Copyright © 2018 Luis Conde. All rights reserved.
//

import UIKit
import BWWalkthrough

class ViewController: UIViewController {
    
    let userDefaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        

        if !userDefaults.bool(forKey: "Tutorial") {
        
            self.showWalkthrough()
            
            userDefaults.set(true, forKey: "Tutorial")
            userDefaults.synchronize()
            
        }
        
        
    }
    
    
    func showWalkthrough(){
    
        
        // Get view controllers and build the walkthrough
        let stb = UIStoryboard(name: "Main", bundle: nil)
        let walkthrough = stb.instantiateViewController(withIdentifier: "Master") as! BWWalkthroughViewController
        let page_one = stb.instantiateViewController(withIdentifier: "page1")
        let page_two = stb.instantiateViewController(withIdentifier: "page2")
        
        // Attach the pages to the master
        walkthrough.delegate = self
        walkthrough.add(viewController:page_one)
        walkthrough.add(viewController:page_two)
    
        
        self.present(walkthrough, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
            }


}

extension ViewController: BWWalkthroughViewControllerDelegate {

    func walkthroughPageDidChange(_ pageNumber: Int) {
            print(pageNumber)
    }
    
    func walkthroughCloseButtonPressed() {
        self.dismiss(animated: true)
    }

}

