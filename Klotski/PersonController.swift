//
//  PersonController.swift
//  Klotski
//
//  Created by 闫润邦 on 2022/8/17.
//

import Foundation
import UIKit

struct Position: Hashable {
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
    let personView: PersonView
    var position: Position {
        didSet {
            movePersonViewToCurrentPosition(animated: true)
            if name == "caoCao" && position.x == 3 && position.y == 1 {
                gameManager?.playerWin()
            }
        }
    }
    let size: Size
    let name: String
    weak var gameManager: GameManager?
    var touchStartPoint: CGPoint?
    
    private init(personName: String, x: Int, y: Int, width: Int, height: Int) {
        self.name = personName
        personView = PersonView(name: personName, controller: nil)
        position = Position(x: x, y: y)
        size = Size(width: width, height: height)
        movePersonViewToCurrentPosition(animated: false)
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
    
    private func movePersonViewToCurrentPosition(animated: Bool) {
        if animated {
            UIView.animate(withDuration: 0.3) {
                self.personView.frame.origin = CGPoint(
                    x: singleCellWidth * CGFloat(self.position.y),
                    y: singleCellWidth * CGFloat(self.position.x)
                )
            }
        } else {
            self.personView.frame.origin = CGPoint(
                x: singleCellWidth * CGFloat(self.position.y),
                y: singleCellWidth * CGFloat(self.position.x)
            )
        }

    }
    
    func touchBegan(at point: CGPoint) {
        touchStartPoint = point
    }
    
    func touchEnd(at point: CGPoint) {
        guard let touchStartPoint = touchStartPoint else {
            return
        }
        let xOffset = point.x - touchStartPoint.x
        let yOffset = point.y - touchStartPoint.y
        
        if abs(xOffset) > abs(yOffset) { // left or right
            if xOffset > 0 {
                gameManager?.tryToMove(self, direction: .right)
            } else {
                gameManager?.tryToMove(self, direction: .left)
            }
        } else { // up or down
            if yOffset > 0 {
                gameManager?.tryToMove(self, direction: .down)
            } else {
                gameManager?.tryToMove(self, direction: .up)
            }
        }
        self.touchStartPoint = nil
    }
    
}
