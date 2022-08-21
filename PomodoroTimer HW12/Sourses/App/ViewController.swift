//
//  ViewController.swift
//  PomodoroTimer HW12
//
//  Created by Артур Горлов on 21.08.2022.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    // MARK: - View Elements

    private lazy var timerLabel: UILabel = {
        let timerLabel = UILabel()
        timerLabel.font = UIFont(name: "courier new", size: 70)
        timerLabel.text = "00:00"
        timerLabel.textColor = UIColor.systemPink
        timerLabel.alpha = 0.8
        timerLabel.textAlignment = .center
        timerLabel.adjustsFontSizeToFitWidth = true
        return timerLabel
    }()

    private lazy var playPauseButton: UIButton = {
        let playPauseButton = UIButton()
        playPauseButton.setImage(UIImage(systemName: "play"), for: .normal)
        playPauseButton.tintColor = UIColor.systemPink
        playPauseButton.alpha = 0.8
        playPauseButton.contentVerticalAlignment = .fill
        playPauseButton.contentHorizontalAlignment = .fill
        playPauseButton.imageView?.contentMode = .scaleAspectFit
        return playPauseButton
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupHierarchy()
        setupLayout()
    }

    // MARK: - Setup

    private func setupHierarchy() {
        view.addSubview(timerLabel)
        view.addSubview(playPauseButton)
    }

    private func setupLayout() {
        timerLabel.snp.makeConstraints {
            $0.centerX.equalTo(view.snp.centerX)
            $0.centerY.equalTo(view.snp.centerY).offset(-50)
            $0.leading.equalTo(view.safeAreaInsets.left).offset(50)
            $0.trailing.equalTo(view.safeAreaInsets.right).inset(50)
        }

        playPauseButton.snp.makeConstraints {
            $0.top.equalTo(timerLabel.snp.bottom).offset(20)
            $0.centerX.equalTo(timerLabel.snp.centerX)
            $0.size.equalTo(timerLabel).inset(15)
        }
    }

}

