//
//  GameManager.swift
//  Klotski
//
//  Created by 闫润邦 on 2022/8/17.
//

import Foundation

class Weak<T: AnyObject> {
  weak var value : T?
  init (value: T) {
    self.value = value
  }
}

class GameManager {
    weak var gameViewController: GameViewController?
    var personControllers: [Weak<PersonController>]
    
    init(gameViewController: GameViewController) {
        self.gameViewController = gameViewController
        self.personControllers = []
        gameViewController.gameManager = self
    }
    
    func initGame() {
        
        guard let gameViewController = gameViewController else {
            fatalError("gameViewController not found")
        }

        personNames.forEach { personName in
            let pc = PersonController(personName: personName)
            pc.addPersonViewToSuperView(gameViewController.view)
            personControllers.append(Weak<PersonController>(value: pc))
        }
        
    }
}
