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
            pc.gameManager = self
            personControllers.append(Weak<PersonController>(value: pc))
        }
        
    }
    
    func restartGame() {
        personControllers.forEach { weakPc in
            guard let pc = weakPc.value else {
                fatalError("unexpected weak value \(weakPc)")
            }
            guard let config = personConfigs[pc.name] else {
                fatalError("unexpected personName \(pc.name)")
            }
            
            pc.position = config.position
        }
    }
}
