//
//  PreLoginViewController.swift
//  Spotify Clone
//
//  Created by Ahmad Ellashy on 23/03/2024.
//

import UIKit

class PreLoginViewController: UIViewController {
//MARK: - IBOutlets
    @IBOutlet weak var signUpButton : UIButton!
    @IBOutlet weak var phoneButton : UIButton!
    @IBOutlet weak var googleButton : UIButton!
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var appleButton : UIButton!
   
    //MARK: - Built In Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        
    }
//MARK: - IBActions
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
    }
    @IBAction func continueWithPhonePressed(_ sender : UIButton){
        
    }
    @IBAction func continueWithFacebookPressed(_ sender: UIButton) {
    }
    @IBAction func continueWithGooglePressed(_ sender : UIButton){
        
    }
    @IBAction func continueWithApplePressed(_ sender : UIButton){
        
    }
    @IBAction func loginButtonPressed(_ sender: Any) {
    }
    //MARK: - Functions
    func setUp(){
        signUpButton.layer.cornerRadius = 20
        phoneButton.addBorderRadius()
        googleButton.addBorderRadius()
        facebookButton.addBorderRadius()
        appleButton.addBorderRadius()
    }

}
