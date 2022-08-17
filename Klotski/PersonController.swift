//
//  PersonController.swift
//  Klotski
//
//  Created by 闫润邦 on 2022/8/17.
//

import Foundation
import UIKit

struct Position {
    var x: Int
    var y: Int
    
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
}

struct Size {
    var width: Int
    var height: Int
    
    init(width: Int, height: Int) {
        self.width = width
        self.height = height
    }
}

struct PersonConfig {
    let position: Position
    let size: Size
    
    init(x: Int, y: Int, width: Int, height: Int) {
        self.position = Position(x: x, y: y)
        self.size = Size(width: width, height: height)
    }
}

class PersonController {
    private let personView: PersonView
    var position: Position {
        didSet {
            movePersonViewToCurrentPosition()
        }
    }
    let size: Size
    let name: String
    weak var gameManager: GameManager?
    
    private init(personName: String, x: Int, y: Int, width: Int, height: Int) {
        self.name = personName
        personView = PersonView(name: personName, controller: nil)
        position = Position(x: x, y: y)
        size = Size(width: width, height: height)
        movePersonViewToCurrentPosition()
        personView.controller = self
    }
    
    
    private convenience init(personName: String, position: Position, size: Size) {
        self.init(personName: personName, x: position.x, y: position.y, width: size.width, height: size.height)
    }
    
    convenience init(personName: String) {
        guard let config = personConfigs[personName] else {
            fatalError("unexpected personName \(personName)")
        }
        self.init(personName: personName, position: config.position, size: config.size)
    }
    
    func addPersonViewToSuperView(_ superView: UIView) {
        superView.addSubview(personView)
    }
    
    private func movePersonViewToCurrentPosition() {
        personView.frame.origin = CGPoint(
            x: singleCellWidth * CGFloat(position.y),
            y: topGap + singleCellWidth * CGFloat(position.x)
        )
    }
    
}
