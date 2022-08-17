//
//  GameManager.swift
//  Klotski
//
//  Created by 闫润邦 on 2022/8/17.
//

import Foundation


class GameManager {
    weak var gameViewController: GameViewController?
    var personControllers: [PersonController]
    var isOccupied: [Position: Bool] = [: ]
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
            personControllers.append(pc)
            setOccupyFor(pc, occupied: true)
        }
    }
    
    func restartGame() {
        personControllers.forEach { pc in
            guard let config = personConfigs[pc.name] else {
                fatalError("unexpected personName \(pc.name)")
            }
            
            pc.position = config.position
        }
    }
    
    func tryToMove(_ sender: PersonController, direction: MoveDirection) {
        if canMove(sender, direction: direction) {
            setOccupyFor(sender, occupied: false)
            sender.position.x += offsetForDirection(direction).x
            sender.position.y += offsetForDirection(direction).y
            setOccupyFor(sender, occupied: true)
        } else {
            return
        }
    }
    
    private func canMove(_ personController: PersonController, direction: MoveDirection) -> Bool {
        let offset = offsetForDirection(direction)
        let newPosition = Position(x: personController.position.x + offset.x,
                                   y: personController.position.y + offset.y)
        if newPosition.x < minimumX || newPosition.x > maximumX
            || newPosition.y < minimumY || newPosition.y > maximumY {
            return false
        }
        switch direction {
        case .down:
            for i in
                    personController.position.y
                                ..<
                    personController.position.y + personController.size.width {
                guard let oc = isOccupied[Position(
                    x: newPosition.x + personController.size.height - 1, y: i)] else {
                    continue
                }
                if oc == true {
                    return false
                }
            }
        case .up:
            for i in
                    personController.position.y
                                ..<
                    personController.position.y + personController.size.width {
                guard let oc = isOccupied[Position(x: newPosition.x, y: i)] else { continue }
                if oc == true {
                    return false
                }
            }
        case .left:
            for i in
                    personController.position.x
                                ..<
                    personController.position.x + personController.size.height {
                guard let oc = isOccupied[Position(x: i, y: newPosition.y)] else { continue }
                if oc == true {
                    return false
                }
            }
        case .right:
            for i in
                    personController.position.x
                                ..<
                    personController.position.x + personController.size.height {
                guard let oc = isOccupied[Position(x: i,
                                                   y: newPosition.y + personController.size.width - 1)] else {
                    continue
                }
                if oc == true {
                    return false
                }
            }
        }
        return true
    }
    
    private func setOccupyFor(_ personController: PersonController, occupied: Bool) {
        for i in
                personController.position.x ..< personController.position.x + personController.size.height {
            for j in
                    personController.position.y ..< personController.position.y + personController.size.width {
                isOccupied[Position(x: i, y: j)] = occupied
            }
        }
    }
    
    
}
