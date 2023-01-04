//
//  SignUpViewController.swift
//  GeoGuessrGames
//
//  Created by Vadim Merkalo on 03.01.2023.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {

    @IBOutlet weak var fieldEmail: UITextField!
    @IBOutlet weak var fieldPassword: UITextField!
    @IBOutlet weak var fieldRepeatPassword: UITextField!
    
    
    @IBOutlet weak var textEmail: UILabel!
    @IBOutlet weak var textPassword: UILabel!
    @IBOutlet weak var textRepeatPassword: UILabel!
    
    
    @IBOutlet weak var buttonCreate: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textEmail.text = "Email"
        textPassword.text = "Password"
        textRepeatPassword.text = "Repeat password"
        
        buttonCreate.setTitle("Register", for: .normal)
    }
    

    @IBAction func signUpAction(_ sender: Any) {
        if fieldPassword.text != fieldRepeatPassword.text {
        let alertController = UIAlertController(title: "Password Incorrect", message: "Please re-type password", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
                }
        else{
        Auth.auth().createUser(withEmail: fieldEmail.text!, password: fieldPassword.text!){ (user, error) in
         if error == nil {
             let storyboard = UIStoryboard(name: "Main", bundle: nil)
             let presentOne = storyboard.instantiateViewController(withIdentifier: "CoursesControllerID") as! CoursesController
             self.navigationController?.pushViewController(presentOne, animated: true)
                        }
         else{
           let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
           let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                            
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
               }
                    }
              }
    }
}
