//
//  PlayComponentsView.swift
//  Spotify
//
//  Created by Ahmad Ellashy on 15/05/2024.
//

import UIKit
protocol PlayComponentsViewDelegate : AnyObject{
    func didTapForward()
    func didTapPause()
    func didTabBackward()
    func sliderChanged(_ value : Double)
}
class PlayComponentsView: UIView  {
    weak var delegate : PlayComponentsViewDelegate?
    //MARK: - UI Components
    private var isPlaying : Bool = true
    private let sliderView : UISlider = {
        let slider = UISlider()
        slider.value = 0.0
        return slider
    }()
    private let trackNameLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.text = "Dream"
        return label
    }()
    private let artistNameLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.text = "Diablo DPM"
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let playForwardButton : UIButton = {
        let button = UIButton()
        let image = UIImage(
            systemName: "forward.fill",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 35, weight: .bold))
        button.setImage(image, for: .normal)
        return button
    }()
    private let playPauseButton : UIButton = {
        let button = UIButton()
        let image = UIImage(
            systemName: "pause",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 35, weight: .bold))
        button.setImage(image, for: .normal)
        return button
    }()
    private let playBackwardButton : UIButton = {
        let button = UIButton()
        let image = UIImage(
            systemName: "backward.fill",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 35, weight: .bold))
        button.setImage(image, for: .normal)
        return button
    }()
    //MARK: - Life Cycle
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(sliderView)
        addSubview(trackNameLabel)
        addSubview(artistNameLabel)
        addSubview(playForwardButton)
        addSubview(playPauseButton)
        addSubview(playBackwardButton)
        sliderView.addTarget(self, action: #selector(changeSliderValue(_:)), for: .valueChanged)
        playForwardButton.addTarget(self, action: #selector(didTapForwardButton), for: .touchUpInside)
        playPauseButton.addTarget(self, action: #selector(didTapPauseButton), for: .touchUpInside)
        playBackwardButton.addTarget(self, action: #selector(didTapBackwardButton), for: .touchUpInside)
        trackNameLabel.text = PlayerViewModel.shared.songName
        artistNameLabel.text = PlayerViewModel.shared.artistName
        clipsToBounds = true

    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        trackNameLabel.frame = CGRect(x: 10, y: 0, width: width, height: 30)
        artistNameLabel.frame = CGRect(x: 10, y: trackNameLabel.bottom + 10, width: width, height: 30)
        sliderView.frame = CGRect(x: 10, y: artistNameLabel.bottom, width: width - 20, height: 30)
        playBackwardButton.frame = CGRect(x: self.left + 10, y: sliderView.bottom + 20, width: 50, height: 50)
        playPauseButton.frame = CGRect(x: playBackwardButton.right + 80, y: sliderView.bottom + 20, width: 50, height: 50)
        playForwardButton.frame = CGRect(x: playPauseButton.right + 80, y: sliderView.bottom + 20, width: 50, height: 50)


    }
    //MARK: - Functions
     func config(with title : String, artistName : String){
        trackNameLabel.text = title
        artistNameLabel.text = artistName
    }

    

}
extension PlayComponentsView {
    @objc func changeSliderValue(_ sliderValue: Double) {
        self.delegate?.sliderChanged(sliderValue)
    }
    @objc func didTapForwardButton(){
        self.delegate?.didTapForward()
    }
    @objc func didTapPauseButton(){
        self.isPlaying = !isPlaying
        let pause = UIImage(systemName: "pause",withConfiguration: UIImage.SymbolConfiguration(pointSize: 35, weight: .bold))
        let play = UIImage(systemName: "play.fill",withConfiguration: UIImage.SymbolConfiguration(pointSize: 35, weight: .bold))
        playPauseButton.setImage(isPlaying ? pause : play, for: .normal)
        self.delegate?.didTapPause()
    }
    @objc func didTapBackwardButton(){
        self.delegate?.didTabBackward()
    }
}
