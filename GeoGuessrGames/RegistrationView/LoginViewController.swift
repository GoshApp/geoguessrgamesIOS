//
//  LoginViewController.swift
//  GeoGuessrGames
//
//  Created by Vadim Merkalo on 03.01.2023.
//

import UIKit
import FirebaseAuth
import FacebookLogin

class LoginViewController: UIViewController {

    @IBOutlet weak var textEmail: UILabel!
    @IBOutlet weak var textPassword: UILabel!
    
    @IBOutlet weak var fieldEmail: UITextField!
    @IBOutlet weak var fieldPassword: UITextField!
    
    
    @IBOutlet weak var buttonCreate: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textEmail.text = "Email"
        textPassword.text = "Password"
        
        buttonCreate.setTitle("Sign in", for: .normal)
        
        let loginButton = FBLoginButton()
        loginButton.delegate = self
        loginButton.permissions = ["public_profile", "email"]
        loginButton.frame.origin.y = 550
        loginButton.frame.origin.x = 100
        
        view.addSubview(loginButton)
        
        if let token = AccessToken.current,
            !token.isExpired {
            // User is logged in, do work such as go to next view controller.
        }
    }
    
    @IBAction func loginAction(_ sender: Any) {
        Auth.auth().signIn(withEmail: fieldEmail.text!, password: fieldPassword.text!) { (user, error) in
           if error == nil{
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

extension LoginViewController : LoginButtonDelegate {
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
//        if error == nil {
//            GraphRequest(graphPath: "me", parameters: ["fields" : "email, name"], tokenString: AccessToken().tokenString, version: nil, httpMethod: HTTPMethod(rawValue: "GET")).start(completionHandler: { (nil, result, error) in
//                if error == nil {
//                    print(result)
//                }
//            })
//        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("Logout")
    }
}
