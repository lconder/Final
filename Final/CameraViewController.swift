//
//  CameraViewController.swift
//  Final
//
//  Created by Luis Conde on 27/01/18.
//  Copyright © 2018 Luis Conde. All rights reserved.
//

import UIKit

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet var imageView: UIImageView!

    @IBOutlet var buttonSave: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.buttonSave.isEnabled = false

    }
    
    @IBAction func savePressed(_ sender: UIButton) {
        
        if let imageData = UIImageJPEGRepresentation(self.imageView.image!, 0.8) {
        
            if let compressedImage = UIImage(data: imageData) {
            
                UIImageWriteToSavedPhotosAlbum(compressedImage, nil, nil, nil)
            
            }
        
        }
        
        
        
    }
    
    @IBAction func cameraPressed(_ sender: UIButton) {
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
        
            let imagePickerVC = UIImagePickerController()
            imagePickerVC.delegate = self
            imagePickerVC.sourceType = .camera
            
            self.present(imagePickerVC, animated: true, completion: nil)
        
        }
        
    }
    
    @IBAction func galleryButton(_ sender: UIButton) {
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            
            let imagePickerVC = UIImagePickerController()
            imagePickerVC.delegate = self
            imagePickerVC.sourceType = .photoLibrary
            imagePickerVC.allowsEditing = true
            
            self.present(imagePickerVC, animated: true, completion: nil)
            
        }
        
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    //MARK: - UIImagePickerControllerDelegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.imageView.image = image
        self.buttonSave.isEnabled = true
        
        dismiss(animated:true)
    }


}
