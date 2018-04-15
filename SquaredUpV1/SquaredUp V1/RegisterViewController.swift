//
//  RegisterViewController.swift
//  SquaredUp V1
//
//  Created by Sam Ruben on 1/24/18.
//  Copyright © 2018 Sam Ruben. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var retypePasswordTextField: UITextField!
    
    @IBOutlet weak var roundedSignUp: UIButton!
    @IBOutlet weak var roundedCancel: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roundedSignUp.layer.cornerRadius = 4
        roundedCancel.layer.cornerRadius = 4
        
    
      

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
    @IBAction func cancelButtonTapped(_ sender: Any) {
        print("Cancel")
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        
        print("sign up")
        // Validate Required Filed Are Not Empty
        if (emailTextField.text?.isEmpty)! || (passwordTextField.text?.isEmpty)!
        {
            // Display Alert Message
            displayAlertMessage(userMessage: "All fields are required to fill in.")
            return
        }
        
        // Check if Passwords Match
        if (passwordTextField.text?.elementsEqual(retypePasswordTextField.text!))! != true
        {
            // Display Alert Message
            displayAlertMessage(userMessage: "Please make sure passwords match.")
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
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://cgi.soic.indiana.edu/~team52/InsertUser.php")! as URL)
        request.httpMethod = "POST"
        
        let postString = "email=\(emailTextField.text!)&password=\(passwordTextField.text!)&fname=\(firstNameTextField.text!)"
        
        
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
        
        
        let alertController = UIAlertController(title: "Candidate's Name", message:
            "Successfully Added", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
        
        removeActivityIndicator(activityIndicator: myActivityIndicator)
        firstNameTextField.text = ""
        lastNameTextField.text = ""
        emailTextField.text = ""
        passwordTextField.text = ""
        retypePasswordTextField.text = ""
    }
    
    
    

  
}
