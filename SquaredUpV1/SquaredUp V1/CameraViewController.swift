//
//  CameraViewController.swift
//  SquaredUp V1
//
//  Created by Sam Ruben on 3/26/18.
//  Copyright © 2018 Sam Ruben. All rights reserved.
//

import UIKit

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var pickedImage: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    @IBAction func backButtonTapped(_ sender: Any) {
        print("hi")
        let menuViewController = self.storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        self.present(menuViewController, animated: true)
        
    }
    @IBAction func cameraButtonAction(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
            imagePicker.allowsEditing = false
            self.present(imagePicker,animated: true,completion: nil)
            
            
        }
    }
    @IBAction func photoLibraryAction(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker,animated: true, completion: nil)
        }
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
        let imageData = UIImageJPEGRepresentation(pickedImage.image!,0.6 )
        let compressedJPEGImage = UIImage(data:imageData!)
        UIImageWriteToSavedPhotosAlbum(compressedJPEGImage!, nil, nil, nil)
        saveNotice()
        
    }
    
    func imagePickerController(_ picker:UIImagePickerController, didFinishPickingImage image:UIImage!, editingInfo: [NSObject : AnyObject]!) {
        pickedImage.image = image
        self.dismiss(animated: true, completion: nil);
        
    }
    
    func saveNotice(){
        let alertController = UIAlertController(title: "Image Saved!", message: "Your Picture Was Succesfully Saved!", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
    
}
