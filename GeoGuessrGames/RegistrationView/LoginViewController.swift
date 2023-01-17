//
//  LoginViewController.swift
//  GeoGuessrGames
//
//  Created by Vadim Merkalo on 03.01.2023.
//

import UIKit

import FirebaseAuth
import FirebaseCore
import Firebase

import FacebookLogin

import GoogleSignIn



class LoginViewController: UIViewController {
    
    @IBOutlet weak var textEmail: UILabel!
    @IBOutlet weak var textPassword: UILabel!
    
    @IBOutlet weak var fieldEmail: UITextField!
    @IBOutlet weak var fieldPassword: UITextField!
    
    
    @IBOutlet weak var buttonCreate: UIButton!
    @IBOutlet weak var googleButton: UIButton!
    @IBOutlet weak var forgotPassword: UIButton!
    
    @IBOutlet weak var facebookButton: FBLoginButton!
    
    let sinInConfig = GIDConfiguration(clientID: "76406962889-l0to1l1qu2a7v0k8fcquqav0p3rsknh4.apps.googleusercontent.com")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textEmail.text = "Email"
        textPassword.text = "Password"
        
        buttonCreate.setTitle("Sign in", for: .normal)
        googleButton.setTitle("Google", for: .normal)
        forgotPassword.setTitle("Forgot password?", for: .normal)
        
//       ObservingAuthenticationState()
        authFacebook()
    }
    
    func authFacebook(){
        if let token = AccessToken.current,
        token.isExpired{
            let token = token.tokenString
            let request = FBSDKLoginKit.GraphRequest(graphPath: "me",
                                                     parameters: ["fields" : "email, name"],
                                                     tokenString: token, version: nil,
                                                     httpMethod: .get)
            request.start { Iconnection, result, error in
                print(result)
            }
        }else{
            facebookButton.delegate = self
            facebookButton.permissions = ["public_profile", "email"]
        }
    }
    
    func ObservingAuthenticationState() {
        var handle: AuthStateDidChangeListenerHandle?
        
        handle = Auth.auth().addStateDidChangeListener { _, user in
          if user == nil {
            self.navigationController?.popToRootViewController(animated: true)
          } else {
            self.fieldEmail.text = nil
            self.fieldPassword.text = nil
          }
        }
        
        guard let handle = handle else { return }
        Auth.auth().removeStateDidChangeListener(handle)
    }
    
    @IBAction func loginAction(_ sender: Any) {
        Auth.auth().signIn(withEmail: fieldEmail.text!, password: fieldPassword.text!) { (user, error) in
            if error == nil{
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let presentOne = storyboard.instantiateViewController(withIdentifier: "CoursesControllerID") as! CoursesController
                self.navigationController?.pushViewController(presentOne, animated: true)
            }else{
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func signIn(_ sender: Any) {
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
            guard error == nil else { return }
            guard let signInResult = signInResult else { return }
            signInResult.user.refreshTokensIfNeeded { user, error in
                if error == nil {
                    guard error == nil else { return }
                    guard let user = user else { return }
                    let idToken = user.idToken
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let presentOne = storyboard.instantiateViewController(withIdentifier: "CoursesControllerID") as! CoursesController
                    self.navigationController?.pushViewController(presentOne, animated: true)
                }else{
                    print(error)
                }
                // Send ID token to backend (example below).
            }
        }
    }
}

extension LoginViewController : LoginButtonDelegate {
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if let error = error {
          print(error.localizedDescription)
          return
        }
        
        let token = result?.token?.tokenString
        let request = FBSDKLoginKit.GraphRequest(graphPath: "me",
                                                 parameters: ["fields" : "email, name"],
                                                 tokenString: token, version: nil,
                                                 httpMethod: .get)
        request.start { Iconnection, result, error in
            if error == nil {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let presentOne = storyboard.instantiateViewController(withIdentifier: "CoursesControllerID") as! CoursesController
                self.navigationController?.pushViewController(presentOne, animated: true)
                
                let credential = FacebookAuthProvider
                  .credential(withAccessToken: AccessToken.current!.tokenString)
                Auth.auth().signIn(with: credential) { result, error in
                    if error == nil{
                        print(result?.user.uid)
                    }
                }
                print(result)
            }else{
                print(error)
            }
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("Logout")
    }
}
