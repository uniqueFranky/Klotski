//
//  GameSolver.swift
//  Klotski
//
//  Created by 闫润邦 on 2022/8/17.
//

import Foundation


struct PersonStatus: Hashable {

    let name: String
    var position: Position
    let size: Size
    
    init(personController: PersonController) {
        self.name = personController.name
        self.position = personController.position
        self.size = personController.size
    }
    
    static func == (lhs: PersonStatus, rhs: PersonStatus) -> Bool {
        lhs.position.x == rhs.position.x && lhs.position.y == rhs.position.y && lhs.name == rhs.name
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(position.x)
        hasher.combine(position.y)
    }
}

struct GameStatus: Hashable {

    var personStatuses: [PersonStatus]
    var stepNum: Int?
    
    init(personStatuses: [PersonStatus]) {
        self.personStatuses = personStatuses
    }
    
    init(personControllers: [PersonController]) {
        var pss: [PersonStatus] = []
        personControllers.forEach { pc in
            pss.append(PersonStatus(personController: pc))
        }
        self.init(personStatuses: pss)
    }
    
    static func == (lhs: GameStatus, rhs: GameStatus) -> Bool {
        return lhs.personStatuses == rhs.personStatuses
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(personStatuses)
    }
}



class GameSolver {
    
    var statusQueue: [GameStatus] = []
    var nowIndex = 0
    var visited: [GameStatus: Bool] = [: ]
    func solve(primaryStatus start: GameStatus) {
        
        var st = start
        st.stepNum = 0
        statusQueue.append(st)

        while nowIndex < statusQueue.count {
            let gs = statusQueue[nowIndex]
            nowIndex += 1
            print(gs.stepNum!)
            let gameManager = GameManager(gameStatus: gs)
            gs.personStatuses.forEach { ps in
                let pc = gameManager.getPersonControllerByName(ps.name)
                
                
                
                if gameManager.canMove(pc, direction: .up) {
                    gameManager.tryToMove(pc, direction: .up)
                    var newGameStatus = GameStatus(personControllers: gameManager.personControllers)
                    newGameStatus.stepNum = gs.stepNum! + 1
                    if visited[newGameStatus] == nil || visited[newGameStatus] == false {
                        visited[newGameStatus] = true
                        statusQueue.append(newGameStatus)
//                        print(pc.name, MoveDirection.up)
                    }
                    if gameManager.hasEnd() {
                        print("found")
                        while nowIndex < statusQueue.count {
                            statusQueue.popLast()
                        }
                        return
                    }
                    gameManager.tryToMove(pc, direction: .down)
                }
                
                if gameManager.canMove(pc, direction: .down) {
                    gameManager.tryToMove(pc, direction: .down)
                    var newGameStatus = GameStatus(personControllers: gameManager.personControllers)
                    newGameStatus.stepNum = gs.stepNum! + 1

                    if visited[newGameStatus] == nil || visited[newGameStatus] == false {
                        visited[newGameStatus] = true
                        statusQueue.append(newGameStatus)
//                        print(pc.name, MoveDirection.down)

                    }
                    if gameManager.hasEnd() {
                        print("found")
                        while nowIndex < statusQueue.count {
                            statusQueue.popLast()
                        }
                        return
                    }
                    gameManager.tryToMove(pc, direction: .up)
                }
                
                
                if gameManager.canMove(pc, direction: .left) {
                    gameManager.tryToMove(pc, direction: .left)
                    var newGameStatus = GameStatus(personControllers: gameManager.personControllers)
                    newGameStatus.stepNum = gs.stepNum! + 1

                    if visited[newGameStatus] == nil || visited[newGameStatus] == false {
                        visited[newGameStatus] = true
                        statusQueue.append(newGameStatus)
//                        print(pc.name, MoveDirection.left)

                    }
                    if gameManager.hasEnd() {
                        print("found")
                        while nowIndex < statusQueue.count {
                            statusQueue.popLast()
                        }
                        return
                    }
                    gameManager.tryToMove(pc, direction: .right)
                }
                
                if gameManager.canMove(pc, direction: .right) {
                    gameManager.tryToMove(pc, direction: .right)
                    var newGameStatus = GameStatus(personControllers: gameManager.personControllers)
                    newGameStatus.stepNum = gs.stepNum! + 1

                    if visited[newGameStatus] == nil || visited[newGameStatus] == false {
                        visited[newGameStatus] = true
                        statusQueue.append(newGameStatus)
//                        print(pc.name, MoveDirection.right)

                    }
                    if gameManager.hasEnd() {
                        print("found")
                        while nowIndex < statusQueue.count {
                            statusQueue.popLast()
                        }
                        return
                    }
                    gameManager.tryToMove(pc, direction: .left)
                }
                
                
                
            }
        }
        
    }
    
}
