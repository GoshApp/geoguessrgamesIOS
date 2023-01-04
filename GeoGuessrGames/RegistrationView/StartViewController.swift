//
//  StartViewController.swift
//  GeoGuessrGames
//
//  Created by Vadim Merkalo on 03.01.2023.
//

import UIKit
import Foundation

class StartViewController: UIViewController {

    @IBOutlet weak var textCreateAccaunts: UILabel!
    @IBOutlet weak var buttonCreateAccount: UIButton!
    @IBOutlet weak var buttonSignIn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setHidesBackButton(true, animated: true)

        textCreateAccaunts.text = "Create or sign in to an existing account"
        
        buttonSignIn.setTitle("Sign in", for: .normal)
        buttonCreateAccount.setTitle("Create", for: .normal)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
