//
//  ViewController.swift
//  Spotify
//
//  Created by Ahmad Ellashy on 24/03/2024.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let vc = TabBarViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc,animated: false)
    }


}

