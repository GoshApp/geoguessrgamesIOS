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
            Auth.auth().sendPasswordReset(withEmail: emailField.text!) { (error) in
                if error == nil{
                   self.dismiss(animated: true, completion: nil)
                }else{
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
}
