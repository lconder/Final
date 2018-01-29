//
//  FacebookLoginViewController.swift
//  Final
//
//  Created by Luis Conde on 29/01/18.
//  Copyright © 2018 Luis Conde. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import KFSwiftImageLoader

class FacebookLoginViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var labelName: UILabel!
    @IBOutlet var labelEmail: UILabel!
    @IBOutlet var labelID: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    @IBAction func loginFacebookPressed(_ sender: UIButton) {
        
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if (error == nil){
                let fbloginresult : FBSDKLoginManagerLoginResult = result!
                if fbloginresult.grantedPermissions != nil {
                    if(fbloginresult.grantedPermissions.contains("email"))
                    {
                        self.getFBUserData()
                        fbLoginManager.logOut()
                    }
                }
            }
        }
        
    }
    
    
    func getFBUserData(){
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    
                    print(result!)
                    
                    if let dict = result as? [String : AnyObject] {
                        
                        let email = dict["email"] as! String
                        
                        let userName = dict["name"] as! String
                        
                        let socialID = dict["id"] as! String
                        
                        self.labelName.text = userName
                        self.labelEmail.text = email
                        self.labelID.text = socialID
                        
                        
                        if let dataPicture = dict["picture"] as? [String:AnyObject] {
                        
                            if let dataURL = dataPicture["data"] as? [String:AnyObject] {
                                
                                let URLImage = dataURL["url"] as! String
                                self.imageView.loadImage(urlString: URLImage)
                                
                            }
                            
                        }
                        
                    }
                }
            })
        }
    }
    

}
