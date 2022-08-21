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
        playPauseButton.addTarget(self, action: #selector(ViewController.playPauseButtonTapped), for: .touchUpInside)
        return playPauseButton
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupHierarchy()
        setupLayout()
        timerLabel.text = timeString(time: TimeInterval(workingTimeSeconds))
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

    // MARK: - Timer

    var workingTimeSeconds = 25
    var relaxTimeSeconds = 5
    var isWorkingTime = true
    var isTimerRunning = false
    var timer = Timer()

    func runTimer() {
        isTimerRunning = true
        timer = Timer.scheduledTimer(timeInterval: 1,
                                     target: self,
                                     selector: (#selector(ViewController.updateTimer)),
                                     userInfo: nil,
                                     repeats: true)
    }

    func startWorkingTimer() {
        timerLabel.text = timeString(time: TimeInterval(workingTimeSeconds))
        playPauseButton.tintColor = UIColor.systemPink
        timerLabel.textColor = UIColor.systemPink

        if workingTimeSeconds < 1 {
            timer.invalidate()
            isWorkingTime = false
            isTimerRunning = false
            relaxTimeSeconds = 5
            runTimer()
            return
        }
        workingTimeSeconds -= 1
    }

    func startRelaxingTimer() {
        timerLabel.text = timeString(time: TimeInterval(relaxTimeSeconds))
        playPauseButton.tintColor = UIColor.systemGreen
        timerLabel.textColor = UIColor.systemGreen

        if relaxTimeSeconds < 1 {
            timer.invalidate()
            isWorkingTime = true
            isTimerRunning = false
            workingTimeSeconds = 25
            runTimer()
            return
        }
        relaxTimeSeconds -= 1
    }

    @objc func updateTimer() {
        if isWorkingTime {
            startWorkingTimer()
        } else {
            startRelaxingTimer()
        }
    }

    @objc private func playPauseButtonTapped() {
        if isTimerRunning == false {
            runTimer()
            playPauseButton.setImage(UIImage(systemName: "pause"), for: .normal)
            isTimerRunning = true
        } else {
            timer.invalidate()
            playPauseButton.setImage(UIImage(systemName: "play"), for: .normal)
            isTimerRunning = false
        }
    }

    func timeString(time:TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }

}

