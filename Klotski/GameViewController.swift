//
//  ViewController.swift
//  Klotski
//
//  Created by 闫润邦 on 2022/8/13.
//

import UIKit

class GameViewController: UIViewController {
    var gameManager: GameManager?
    var nowStep: Int = 0 {
        didSet {
            scoreLabel.text = "当前步数：\(nowStep)步"
        }
    }
    let restartButton = UIButton(type: .system)
    let undoButton = UIButton(type: .system)
    let scoreLabel = UILabel()
    let gameView = UIView(frame: CGRect(x: 0, y: topGap, width: screenWidth, height: singleCellWidth * 5))
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        gameManager?.initGame()
        configureGameView()
        configureRestartButton()
        configureUndoButton()
        configureScoreLabel()
    }
}

// Configure Subviews
extension GameViewController {
    
    func configureGameView() {
        view.addSubview(gameView)
    }
    
    func configureRestartButton() {
        view.addSubview(restartButton)
        restartButton.setTitle("重新开始", for: .normal)
        restartButton.addTarget(self, action: #selector(restart), for: .touchUpInside)
        restartButton.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            restartButton.bottomAnchor.constraint(equalTo: gameView.topAnchor),
            restartButton.heightAnchor.constraint(equalToConstant: 50),
            restartButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            restartButton.widthAnchor.constraint(equalToConstant: 100),
        ]
        view.addConstraints(constraints)
    }
    
    func configureUndoButton() {
        view.addSubview(undoButton)
        undoButton.setTitle("撤销", for: .normal)
        undoButton.addTarget(self, action: #selector(undo), for: .touchUpInside)
        undoButton.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            undoButton.bottomAnchor.constraint(equalTo: gameView.topAnchor),
            undoButton.heightAnchor.constraint(equalToConstant: 50),
            undoButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            undoButton.widthAnchor.constraint(equalToConstant: 100),
        ]
        view.addConstraints(constraints)
    }
    
    func configureScoreLabel() {
        view.addSubview(scoreLabel)
        scoreLabel.text = "当前步数：0步"
        scoreLabel.textAlignment = .center
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            scoreLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scoreLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scoreLabel.bottomAnchor.constraint(equalTo: undoButton.topAnchor),
            scoreLabel.widthAnchor.constraint(equalToConstant: 200),
        ]
        view.addConstraints(constraints)
    }
}


extension GameViewController {
    @objc func undo() {
        gameManager?.undoMove()
    }
    
    @objc func restart() {
        gameManager?.restartGame()
    }
}
