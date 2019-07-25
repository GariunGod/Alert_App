//
//  ViewController.swift
//  AlertApp
//
//  Created by HGPMAC84 on 7/3/19.
//  Copyright © 2019 HGPMAC84. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func logintohomepageButton(_ sender: UIButton) {
        
        if (emailText.text != "" && passwordText.text != nil)
        {

            Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!, completion: {(user, error) in
                
                if user != nil
                {
                    self.performSegue(withIdentifier: "loginToHome", sender: self)
                }
                else
                {
                    if let myError = error?.localizedDescription
                    {
                        print(myError)
                    }
                    else
                    {
                        print("Error")
                    }
                    
                }
                
            })
        }
        
        performSegue(withIdentifier: "logintohomePage", sender: self)
    }

    
    @IBAction func signUpNewUser(_sender: UIButton) {
                
        Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!, completion: { ( user, error) in
            
            if user != nil
            {
                print(user)
            }
            else
            {
                if let myError = error?.localizedDescription
                {
                    print(myError)
                }
                else
                {
                    print("Error")
                }
                
            }
        })
        
        performSegue(withIdentifier: "signuptohomePage", sender: self)
    }
    
    
    
}

