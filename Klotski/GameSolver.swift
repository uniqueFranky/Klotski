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

struct PersonStatusForCpp: Codable {
    var name: String
    var position: Position
    var size: Size
    
    init(name: String, position: Position, size: Size) {
        self.name = name
        self.position = position
        self.size = size
    }
    
    init(personController: PersonController) {
        self.init(name: personController.name,
                  position: personController.position,
                  size: personController.size)
    }
}

struct GameStatusForCpp: Codable {
    var personStatuses: [PersonStatusForCpp] = []
    
    mutating func appendPersonStatus(_ personStatus: PersonStatusForCpp) {
        self.personStatuses.append(personStatus)
    }
    
    init(personControllers: [PersonController]) {
        personControllers.forEach { pc in
            let ps = PersonStatusForCpp(personController: pc)
            self.personStatuses.append(ps)
        }
    }
}

class GameSolver {
    
    func solveByPersonControllers(_ personControllers: [PersonController]) {
        let game = GameStatusForCpp(personControllers: personControllers)
        guard let gameData = try? JSONEncoder().encode(game) else {
            fatalError("unexpected game status \(game)")
        }
        
        guard let gameString = String(data: gameData, encoding: .utf8) else {
            fatalError("unexpected gameData \(gameData)")
        }
        let cppWrapper = CppWrapper()
        guard let solveChars = cppWrapper.solveGame_Wrapped(gameString) else { fatalError() }
        guard let solveStr = String(cString: solveChars, encoding: .utf8) else { fatalError() }
        print(solveStr)
    }
    
}
