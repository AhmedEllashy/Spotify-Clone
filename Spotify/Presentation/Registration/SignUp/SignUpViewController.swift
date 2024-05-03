//
//  SignUpViewController.swift
//  Spotify Clone
//
//  Created by Ahmad Ellashy on 23/03/2024.
//

import UIKit

class SignUpViewController: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textFieldView: UIView!
    @IBOutlet weak var navBar: UINavigationBar!
    //MARK: - Built In Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
//        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: nil)
        self.navigationItem.backButtonTitle = "hohoho"
        navBar.topItem?.backButtonDisplayMode = .minimal

    }
    //MARK: - IBActions
    @IBAction func nextButtonPressed(_ sender: UIButton) {
    }
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        self.modalTransitionStyle = .flipHorizontal
        self.dismiss(animated: true)
    }
    //MARK: - Function
    func setUp(){
        setViewStyles()
    }
    func setViewStyles(){
        textFieldView.layer.cornerRadius = 5
    }
    

    
}
