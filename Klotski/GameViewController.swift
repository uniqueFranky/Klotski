//
//  ViewController.swift
//  Klotski
//
//  Created by 闫润邦 on 2022/8/13.
//

import UIKit

class GameViewController: UIViewController {
    weak var gameManager: GameManager?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        gameManager?.initGame()
        
        
    }
}

