//
//  HomeViewController.swift
//  SquaredUp V1
//
//  Created by Sam Ruben on 1/24/18.
//  Copyright © 2018 Sam Ruben. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var roundedSignIn: UIButton!
    @IBOutlet weak var roundedRegister: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roundedSignIn.layer.cornerRadius = 4
        roundedRegister.layer.cornerRadius = 4

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func registerButtonTapped(_ sender: Any) {
        print("hi")
        let registerViewController = self.storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        self.present(registerViewController, animated: true)
    }

    

    @IBAction func SignInButtonTapped(_ sender: UIButton) {
        print("ok")
        
        // Read Values
        let email = emailTextField.text
        let password = passwordTextField.text
        
        // Check if required fields are empty
        if (email?.isEmpty)! || (password?.isEmpty)!
        {
            print("Email \(String(describing: email)) or password \(String(describing: password)) is empty")
            displayMessage(userMessage: "One of the required fields is missing.")
            
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
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://cgi.soic.indiana.edu/~team52/GettingUser.php")! as URL)
        request.httpMethod = "POST"
        
        let postString = "email=\(emailTextField.text!)&password=\(passwordTextField.text!)"
        
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            if error != nil{
                print("1\(String(describing: error))")
            }
            else{
                let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                print("responseString = \(responseString!)")
            }
            // Parse Json Function
            do {
                
                if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data!, options: []) as? NSArray {
                    
                    // Print out dictionary
                    print(convertedJsonIntoDict)
                    
                    // Get value by key
                    let userEmailValue = (convertedJsonIntoDict[0] as! NSDictionary)["user_email"] as? String
                    print(userEmailValue!)
                    
                    if (userEmailValue == nil) {
                        self.displayMessage(userMessage: "Invalid Credentials.")
                    } else {
                        
                        DispatchQueue.main.async {
                            
                            let FrontScreenViewController = self.storyboard?.instantiateViewController(withIdentifier: "FrontScreenViewController") as! FrontScreenViewController
                            
                            self.present(FrontScreenViewController, animated: true)
                        }
                    }
                    
                }
                else{
                    print("error")
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        task.resume()
        
        
        
        
        
        
        
        removeActivityIndicator(activityIndicator: myActivityIndicator)
        emailTextField.text = ""
        passwordTextField.text = ""
        
        
    } //sign in button end
    
    func removeActivityIndicator(activityIndicator: UIActivityIndicatorView) {
        DispatchQueue.main.async
            {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
        }
    }
    
    func displayMessage (userMessage:String) -> Void {
        DispatchQueue.main.async
            {
                let alertController = UIAlertController(title: "Alert", message: userMessage, preferredStyle: .alert)
                
                let OKAction = UIAlertAction(title: "OK", style: .default)
                { (action:UIAlertAction!) in
                    // Code in this block will trigger when OK button tapped.
                    DispatchQueue.main.async
                        {
                            self.dismiss(animated: true, completion: nil)
                    }
                }
                alertController.addAction(OKAction)
                self.present(alertController, animated: true, completion: nil)
        }
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
