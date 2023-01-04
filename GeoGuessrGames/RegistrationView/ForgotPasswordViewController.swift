//
//  ForgotPasswordViewController.swift
//  GeoGuessrGames
//
//  Created by Vadim Merkalo on 03.01.2023.
//

import UIKit
import FirebaseAuth

class ForgotPasswordViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    
    @IBAction func resetButton(_ sender: Any) {
        let email = emailField.text!
        if(!email.isEmpty){
            Auth.auth().sendPasswordReset(withEmail: email) { (error) in
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}
