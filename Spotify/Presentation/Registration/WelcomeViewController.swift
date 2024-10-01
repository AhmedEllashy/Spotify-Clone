//
//  WelcomeViewController.swift
//  Spotify
//
//  Created by Ahmad Ellashy on 27/03/2024.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome"
        label.font = .systemFont(ofSize: 25,weight: .bold)
        label.textColor = .white
        return label
    }()
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "spot-logo")
        return imageView
    }()
    private var signInButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.setTitle("Sign In With Spotify", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        title = "Spotify"
        self.navigationItem.largeTitleDisplayMode = .always
        self.view.addSubview(signInButton)
        view.addSubview(welcomeLabel)
        view.addSubview(logoImageView)
        signInButton.addTarget(self, action: #selector(tapSignInButton), for: .touchUpInside)
        print("size : \(self.view.frame.origin.x)")
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        welcomeLabel.frame = CGRect(x: (view.width / 2) - 50, y: view.safeAreaInsets.top + 20, width: view.width, height: view.width / 2)
        logoImageView.frame = CGRect(x: (view.width / 2) - 75, y: welcomeLabel.bottom + 50, width: 160, height: 160)
        signInButton.frame = CGRect(
            x: 20,
            y: self.view.height - 50 - view.safeAreaInsets.bottom,
            width: view.width - 40,
            height: 50)
        signInButton.layer.masksToBounds = true
        signInButton.layer.cornerRadius = 20.0
    }
    @objc func tapSignInButton(){
        let accesToken = UserDefaults.standard.string(forKey: "access_token")
        let exDate = UserDefaults.standard.object(forKey: "expire_date")

        if let token = accesToken{
            let vc = TabBarViewController()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }else{
            let vc = AuthViewController()
            vc.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(vc, animated: false)
        }
  
    }
    

}
