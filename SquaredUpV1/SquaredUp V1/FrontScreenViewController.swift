//
//  FrontScreenViewController.swift
//  SquaredUp V1
//
//  Created by Sam Ruben on 1/29/18.
//  Copyright © 2018 Sam Ruben. All rights reserved.
//

import UIKit
import BraintreeDropIn
import Braintree

class FrontScreenViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    var myString = String()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = myString

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func sentButtonTapped(_ sender: Any) {
        let paymentViewController = self.storyboard?.instantiateViewController(withIdentifier: "PaymentViewController") as! PaymentViewController
        self.present(paymentViewController, animated: true)
    }
    
    
    @IBAction func menuButtonTapped(_ sender: Any) {
        print("hi")
        let menuViewController = self.storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        self.present(menuViewController, animated: true)
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
