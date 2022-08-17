//
//  Step.swift
//  Klotski
//
//  Created by 闫润邦 on 2022/8/17.
//

import Foundation

struct Step {
    let personController: PersonController
    let direction: MoveDirection
    
    init(personController: PersonController, direction: MoveDirection) {
        self.personController = personController
        self.direction = direction
    }
}
