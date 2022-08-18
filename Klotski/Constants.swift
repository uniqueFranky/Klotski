//
//  Constants.swift
//  Klotski
//
//  Created by 闫润邦 on 2022/8/17.
//

import Foundation
import UIKit
let screenWidth: CGFloat = UIScreen.main.bounds.width
let screenHeight: CGFloat = UIScreen.main.bounds.height
let singleCellWidth: CGFloat = screenWidth / 4
let topGap: CGFloat = (screenHeight - singleCellWidth * 5) / 2
let maximumX = 4
let minimumX = 0
let maximumY = 3
let minimumY = 0
let personNames = [
    "soldier1",
    "soldier2",
    "soldier3",
    "soldier4",
    "maChao",
    "caoCao",
    "huangZhong",
    "zhaoYun",
    "guanYu",
    "zhangFei",
]

let personConfigs: [String: PersonConfig] = [
    "soldier1"    :     PersonConfig(x: 4, y: 0, width: 1, height: 1),
    "soldier2"    :     PersonConfig(x: 4, y: 3, width: 1, height: 1),
    "soldier3"    :     PersonConfig(x: 3, y: 1, width: 1, height: 1),
    "soldier4"    :     PersonConfig(x: 3, y: 2, width: 1, height: 1),
    "maChao"      :     PersonConfig(x: 0, y: 0, width: 1, height: 2),
    "caoCao"      :     PersonConfig(x: 0, y: 1, width: 2, height: 2),
    "zhaoYun"     :     PersonConfig(x: 0, y: 3, width: 1, height: 2),
    "huangZhong"  :     PersonConfig(x: 2, y: 0, width: 1, height: 2),
    "guanYu"      :     PersonConfig(x: 2, y: 1, width: 2, height: 1),
    "zhangFei"    :     PersonConfig(x: 2, y: 3, width: 1, height: 2),
    
//    "soldier1" : PersonConfig(x: 3, y: 3, width: 1, height: 1),
//    "soldier2" : PersonConfig(x: 2, y: 0, width: 1, height: 1),
//    "soldier3" : PersonConfig(x: 2, y: 1, width: 1, height: 1),
//    "soldier4" : PersonConfig(x: 4, y: 3, width: 1, height: 1),
//    "maChao" : PersonConfig(x: 0, y: 3, width: 1, height: 2),
//    "caoCao" : PersonConfig(x: 3, y: 1, width: 2, height: 2),
//    "huangZhong" : PersonConfig(x: 0, y: 1, width: 1, height: 2),
//    "zhaoYun" : PersonConfig(x: 0, y: 2, width: 1, height: 2),
//    "guanYu" : PersonConfig(x: 2, y: 2, width: 2, height: 1),
//    "zhangFei" : PersonConfig(x: 0, y: 0, width: 1, height: 2),

]

let personIds: [String: Int] = [
    "soldier1"    :     1,
    "soldier2"    :     2,
    "soldier3"    :     3,
    "soldier4"    :     4,
    "maChao"      :     5,
    "caoCao"      :     6,
    "zhaoYun"     :     7,
    "huangZhong"  :     8,
    "guanYu"      :     9,
    "zhangFei"    :     10,
]

let nameById: [Int: String] = [
    1 : "soldier1",
    2 : "soldier2",
    3 : "soldier3",
    4 : "soldier4",
    5 : "maChao",
    6 : "caoCao",
    7 : "zhaoYun",
    8 : "huangZhong",
    9 : "guanYu",
    10: "zhangFei",
]

enum MoveDirection {
    case up
    case down
    case left
    case right
}

func offsetForDirection(_ direction: MoveDirection) -> Position {
    switch direction {
    case .up:
        return Position(x: -1, y: 0)
    case .down:
        return Position(x: 1, y: 0)
    case .left:
        return Position(x: 0, y: -1)
    case .right:
        return Position(x: 0, y: 1)
    }
}
