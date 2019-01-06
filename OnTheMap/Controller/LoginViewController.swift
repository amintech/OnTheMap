//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by  AminSaleh on 07/04/1440 AH.
//  Copyright © 1440 AminTech. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var logIn: UIButton!
    @IBOutlet weak var signUp: UIButton!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func logIn(_ sender: Any) {
        
        let email = emailText.text!
        let password = passwordText.text!
        
        ActivityIndicator.aiStart(view: self.view)
        
        API.login(email, password){(loginSuccess, key, error) in
        
            DispatchQueue.main.async {
                
                if error != nil {
                    ActivityIndicator.aiStop()
                    let error = UIAlertController(title: "Erorr", message: "There was an error", preferredStyle: .alert )
                    
                    error.addAction(UIAlertAction (title: "OK", style: .default, handler: { _ in
                        return
                    }))
                    self.present(error, animated: true, completion: nil)
                    return
                }
                
                if !loginSuccess {
                    ActivityIndicator.aiStop()
                    let loginAlert = UIAlertController(title: "Erorr logging in", message: "incorrect email or password", preferredStyle: .alert )
                    
                    loginAlert.addAction(UIAlertAction (title: "OK", style: .default, handler: { _ in
                        return
                    }))
                    self.present(loginAlert, animated: true, completion: nil)
                } else {
                    ActivityIndicator.aiStop()
                    let object = UIApplication.shared.delegate
                    let appDelegate = object as! AppDelegate
                    appDelegate.uniqueKey = key
                    self.performSegue(withIdentifier: "tapBar", sender: nil)
                }
            }
        }
}
    
    @IBAction func signUp(_ sender: Any) {
        
        guard let url = URL(string: "https://auth.udacity.com/sign-up?next=https://classroom.udacity.com/authenticated") else {return}
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
        
    }
    
}

