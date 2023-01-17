//
//  SettingViewController.swift
//  GeoGuessrGames
//
//  Created by Vadim Merkalo on 06.01.2023.
//

import UIKit
import FirebaseAuth
import FacebookLogin
import FirebaseCore
import Firebase
import GoogleSignIn


class SettingViewController: UIViewController {
    
    var handle: AuthStateDidChangeListenerHandle?

    @IBOutlet weak var emailAdress: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handle = Auth.auth().addStateDidChangeListener { auth, user in
            if Auth.auth().currentUser != nil {
                // User is signed in.
                // ...
            } else {
                // No user is signed in.
                // ...
            }
        }
        
        let user = Auth.auth().currentUser
        if let user = user {
            // The user's ID, unique to the Firebase project.
            // Do NOT use this value to authenticate with your backend server,
            // if you have one. Use getTokenWithCompletion:completion: instead.
            let uid = user.uid
            let email = user.email
            let photoURL = user.photoURL
            var multiFactorString = "MultiFactor: "
            for info in user.multiFactor.enrolledFactors {
                multiFactorString += info.displayName ?? "[DispayName]"
                multiFactorString += " "
            }
            Auth.auth().currentUser?.updateEmail(to: email!) { error in
                self.emailAdress.text = email
            }
        }
    }
    
    
    @IBAction func logOut(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            AccessToken.current = nil
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "StartViewController") as? StartViewController
            self.navigationController?.pushViewController(vc!, animated: true)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}
