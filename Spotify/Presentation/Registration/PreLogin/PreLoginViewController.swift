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
    @IBOutlet weak var phoneButtonView : UIView!
    @IBOutlet weak var googleButtonView : UIView!
    @IBOutlet weak var facebookButtonView : UIView!
    @IBOutlet weak var appleButtonView : UIView!
    //MARK: - Properties



    //MARK: - Built In Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        
    }

//MARK: - IBActions
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        let vc = SignUpViewController()
//        vc.modalTransitionStyle = .
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    @IBAction func loginButtonPressed(_ sender: Any) {
    }
    //MARK: - Functions
   private func setUp(){
        setupButtons()
       

    }
    private func setupButtons(){
        signUpButton.layer.cornerRadius = 20
        phoneButtonView.addBorderRadius()
        googleButtonView.addBorderRadius()
        facebookButtonView.addBorderRadius()
        appleButtonView.addBorderRadius()
        configGestures()


    }
    func configGestures() {
        let  phoneTapGesture = UITapGestureRecognizer(target:self, action: #selector(handlePhoneTap))
        let  googleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleGoogleTap))
        let  facebookTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleFacebookTap))
        let  appleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleAppleTap))
        phoneButtonView.addGestureRecognizer(phoneTapGesture)
        googleButtonView.addGestureRecognizer(googleTapGesture)
        facebookButtonView.addGestureRecognizer(facebookTapGesture)
        appleButtonView.addGestureRecognizer(appleTapGesture)
    }
    @objc func handlePhoneTap(){
      print("phone pressed")
    }
    @objc func handleGoogleTap(){
      print("google pressed")
    }
    @objc func handleFacebookTap(){
      print("facebook pressed")
    }
    @objc func handleAppleTap(){
      print("apple pressed")
    }

}
