//
//  AddBillViewController.swift
//  SquaredUp V1
//
//  Created by Sam Ruben on 4/15/18.
//  Copyright © 2018 Sam Ruben. All rights reserved.
//

import UIKit

class AddBillViewController: UIViewController {
    
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var totalAmountTextField: UITextField!
    
    @IBOutlet weak var amountPaidTextField: UITextField!
    
    @IBOutlet weak var groupMembersTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addButton(_ sender: Any) {
    }
    
    @IBAction func cancelButton(_ sender: Any) {
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
