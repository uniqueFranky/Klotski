//
//  GameManager.swift
//  Klotski
//
//  Created by 闫润邦 on 2022/8/17.
//

import Foundation
import UIKit


class GameManager {
    weak var gameViewController: GameViewController?
    var personControllers: [PersonController] = []
    var isOccupied: [Position: Bool] = [: ]
    var stepStack: [Step] = []
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
            pc.addPersonViewToSuperView(gameViewController.gameView)
            pc.gameManager = self
            personControllers.append(pc)
            setOccupyFor(pc, occupied: true)
        }
    }
    
    func playerWin() {
        guard let gameViewController = gameViewController else {
            fatalError("gameViewController not found")
        }

        DispatchQueue.main.async {
            let alert = UIAlertController(title: "You Win!", message: "恭喜🎉！\n您用了\(gameViewController.nowStep)步完成", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "再来一次", style: .default) { _ in
                self.restartGame()
            }
            alert.addAction(okAction)
            gameViewController.present(alert, animated: true)
        }
    }
    
    func autoSolve() {
        print("solve")
        let gameSolver = GameSolver()
        gameSolver.solveByPersonControllers(personControllers)
    }
    
    func undoMove() {
        guard let step = stepStack.popLast() else { return }
        switch step.direction {
        case .down:
            movePerson(step.personController, direction: .up)
        case .up:
            movePerson(step.personController, direction: .down)
        case .left:
            movePerson(step.personController, direction: .right)
        case.right:
            movePerson(step.personController, direction: .left)
        }
        gameViewController?.nowStep -= 1
    }
    
    func restartGame() {
        personControllers.forEach { pc in
            guard let config = personConfigs[pc.name] else {
                fatalError("unexpected personName \(pc.name)")
            }
            setOccupyFor(pc, occupied: false)
            pc.position = config.position
            setOccupyFor(pc, occupied: true)
            gameViewController?.nowStep = 0
        }
        stepStack = []
    }
    
    func tryToMove(_ sender: PersonController, direction: MoveDirection) {
        if canMove(sender, direction: direction) {
            setOccupyFor(sender, occupied: false)
            sender.position.x += offsetForDirection(direction).x
            sender.position.y += offsetForDirection(direction).y
            stepStack.append(Step(personController: sender, direction: direction))
            setOccupyFor(sender, occupied: true)
            gameViewController?.nowStep += 1
        } else {
            return
        }
    }
    
    private func movePerson(_ personController: PersonController, direction: MoveDirection) {
        setOccupyFor(personController, occupied: false)
        personController.position.x += offsetForDirection(direction).x
        personController.position.y += offsetForDirection(direction).y
        setOccupyFor(personController, occupied: true)
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


extension GameManager { // judge whether can move
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
}
