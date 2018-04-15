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
    
    func displayAlertMessage(userMessage: String) -> Void {
        DispatchQueue.main.async
            {
                let alertController = UIAlertController(title: "Alert", message: userMessage, preferredStyle: .alert)
                
                let OKAction = UIAlertAction(title: "OK", style: .default)
                {(action:UIAlertAction!) in
                    // Code in this block will trigger when OK is tapped
                    print("OK Button Tapped")
                    DispatchQueue.main.async
                        {
                            self.dismiss(animated: true, completion: nil)
                    }
                }
                alertController.addAction(OKAction)
                self.present(alertController, animated: true, completion: nil)
        }
        
    }
    func removeActivityIndicator(activityIndicator: UIActivityIndicatorView) {
        DispatchQueue.main.async
            {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
        }
    }
    
    @IBAction func addButton(_ sender: Any) {
        
        // Validate Required Filed Are Not Empty
        if (billTextField.text?.isEmpty)! || (totalAmountTextField.text?.isEmpty)!
        {
            // Display Alert Message
            displayAlertMessage(userMessage: "All fields are required to fill in.")
            return
        }
        
        
        
        // Create Activity Indicator
        let myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        
        // Positioning Indicator
        myActivityIndicator.center = view.center
        
        // Prevent from Hiding (?)
        myActivityIndicator.hidesWhenStopped = false
        
        // Start Activity Indicator
        myActivityIndicator.startAnimating()
        
        view.addSubview(myActivityIndicator)
        
        // Send HTTP Request to Register User
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://cgi.soic.indiana.edu/~team52/InsertBill.php")! as URL)
        request.httpMethod = "POST"
        
        let postString = "BIll=\(billTextField.text!)&Amount=\(totalAmountTextField.text!)&owe=\(amountPaidTextField.text!)&user_email=\(groupMembersTextField.text!)"
        
        
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            if error != nil {
                print("error=\(String(describing: error))")
                return
            }
            
            print("response = \(String(describing: response))")
            
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("responseString = \(String(describing: responseString))")
        }
        task.resume()
        
        
        let alertController = UIAlertController(title: "Bill", message:
            "Successfully Added", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
        
        removeActivityIndicator(activityIndicator: myActivityIndicator)
        billTextField.text = ""
        totalAmountTextField.text = ""
        amountPaidTextField.text = ""
        groupMembersTextField.text = ""

        
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
