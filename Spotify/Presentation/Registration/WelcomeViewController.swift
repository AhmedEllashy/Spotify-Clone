//
//  WelcomeViewController.swift
//  Spotify
//
//  Created by Ahmad Ellashy on 27/03/2024.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    private var signInButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemRed
        button.setTitle("Sign In With Spotify", for: .normal)
        button.setTitleColor(.orange, for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        title = "Spotify"
        self.navigationItem.largeTitleDisplayMode = .always
        self.view.addSubview(signInButton)
        signInButton.addTarget(self, action: #selector(tapSignInButton), for: .touchUpInside)
        print("size : \(self.view.frame.origin.x)")
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        signInButton.frame = CGRect(
            x: 10, 
            y: self.view.height - 50 - view.safeAreaInsets.bottom,
            width: view.width - 40,
            height: 50)
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
