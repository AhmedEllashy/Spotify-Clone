//
//  PlayerViewController.swift
//  Spotify
//
//  Created by Ahmad Ellashy on 15/05/2024.
//

import UIKit
protocol PlayerViewDelegate : AnyObject{
    func didTapPlayPausePlayViewDelegate()
    func didTapForwardPlayViewDelegate()
    func didTapBackwardPlayViewDelegate()
    func changeSliderValuePlayViewDelegate(sliderValue : Double)
}

class PlayerViewController: UIViewController {
    //MARK: - Properties
    weak var delegate : PlayerViewDelegate?
    private let playView = PlayComponentsView()
    weak var dataSource : PlayerViewModelDataSource?
    private var viewModel  = PlayerViewModel.shared
    //MARK: - UIViews
    
    private let imageView : UIImageView = {
        let imageView : UIImageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    //MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        playView.config(with: dataSource?.songName ?? "", artistName: dataSource?.artistName ?? "")
        playView.delegate = self
    }
//    init(track: Track) {
//        self.track = track
//        super.init(nibName: nil, bundle: nil)
//    }
//    required init?(coder: NSCoder) {
//        fatalError()
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
        view.addSubview(playView)
        view.backgroundColor = .systemBackground
        imageView.sd_setImage(with: URL(string: viewModel.imageURL ?? ""), completed: nil)
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapShare))
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.width , height: view.width + 100)
        playView.frame = CGRect(x: 20, y: imageView.bottom + 20, width: view.width - 60, height: view.height - imageView.height - view.safeAreaInsets.bottom - 20)
    }
    
    
    //MARK: - Functions
    @objc func didTapCancel(){
        self.dismiss(animated: true)
    }
    @objc func didTapShare(){
        //Do
    }
}
extension PlayerViewController : PlayComponentsViewDelegate{
    func sliderChanged(_ value: Double) {
        self.delegate?.changeSliderValuePlayViewDelegate(sliderValue: value)
    }
    
    func didTapForward() {
        self.delegate?.didTapForwardPlayViewDelegate()
    }
    
    func didTapPause() {
        self.delegate?.didTapPlayPausePlayViewDelegate()
    }
    
    func didTabBackward() {
        self.delegate?.didTapBackwardPlayViewDelegate()
    }
    
    
        
}



