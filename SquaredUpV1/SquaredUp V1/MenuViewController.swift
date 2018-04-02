//
//  MenuViewController.swift
//  SquaredUp V1
//
//  Created by Sam Ruben on 3/26/18.
//  Copyright © 2018 Sam Ruben. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func contactButtonTapped(_ sender: Any) {
        print("hi")
        let contactViewController = self.storyboard?.instantiateViewController(withIdentifier: "ContactViewController") as! ContactViewController
        self.present(contactViewController, animated: true)
    }
    
    @IBAction func cameraButtonTapped(_ sender: Any) {
        print("hi")
        let cameraViewController = self.storyboard?.instantiateViewController(withIdentifier: "CameraViewController") as! CameraViewController
        self.present(cameraViewController, animated: true)
    }
    
    @IBAction func homeButtonTapped(_ sender: Any) {
        print("hi")
        let frontScreenViewController = self.storyboard?.instantiateViewController(withIdentifier: "FrontScreenViewController") as! FrontScreenViewController
        self.present(frontScreenViewController, animated: true)
    }
    @IBAction func groupButtonTapped(_ sender: Any) {
        print("hi")
       
        
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
