//
//  PersonController.swift
//  Klotski
//
//  Created by 闫润邦 on 2022/8/17.
//

import Foundation
import UIKit

class Position {
    var x: Int
    var y: Int
    
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
}

class Size {
    var width: Int
    var height: Int
    
    init(width: Int, height: Int) {
        self.width = width
        self.height = height
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
    
    private init(personName: String, x: Int, y: Int, width: Int, height: Int) {
        personView = PersonView(name: personName, controller: nil)
        position = Position(x: x, y: y)
        size = Size(width: width, height: height)
        movePersonViewToCurrentPosition()
        personView.controller = self
    }
    
    
    convenience init(personName: String) {
        if personName == "soldier1" {
            self.init(personName: "soldier", x: 4, y: 0, width: 1, height: 1)
        } else if personName == "soldier2" {
            self.init(personName: "soldier", x: 4, y: 3, width: 1, height: 1)
        } else if personName == "soldier3" {
            self.init(personName: "soldier", x: 3, y: 1, width: 1, height: 1)
        } else if personName == "soldier4" {
            self.init(personName: "soldier", x: 3, y: 2, width: 1, height: 1)
        } else if personName == "maChao" {
            self.init(personName: personName, x: 0, y: 0, width: 1, height: 2)
        } else if personName == "caoCao" {
            self.init(personName: personName, x: 0, y: 1, width: 2, height: 2)
        } else if personName == "zhaoYun" {
            self.init(personName: personName, x: 0, y: 3, width: 1, height: 2)
        } else if personName == "huangZhong" {
            self.init(personName: personName, x: 2, y: 0, width: 1, height: 2)
        } else if personName == "guanYu" {
            self.init(personName: personName, x: 2, y: 1, width: 2, height: 1)
        } else if personName == "zhangFei" {
            self.init(personName: personName, x: 2, y: 3, width: 1, height: 2)
        } else {
            fatalError("unexpected personName")
        }
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
