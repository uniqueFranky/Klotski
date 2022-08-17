//
//  PersonView.swift
//  Klotski
//
//  Created by 闫润邦 on 2022/8/17.
//

import UIKit

class PersonView: UIView {
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    let imageView: UIImageView
    init(frame: CGRect, name: String) {
        imageView = UIImageView(frame: frame)
        imageView.image = UIImage(named: name)
        imageView.contentMode = .scaleAspectFill
        super.init(frame: frame)
        addSubview(imageView)
    }
    
    convenience init(name: String) {
        if name == "soldier" {
            self.init(frame: CGRect(x: 0, y: 0, width: singleCellWidth, height: singleCellWidth),
                      name: name)
        } else if name == "caoCao" {
            self.init(frame: CGRect(x: 0, y: 0, width: singleCellWidth * 2, height: singleCellWidth * 2),
                      name: name)
        } else if name == "guanYu" {
            self.init(frame: CGRect(x: 0, y: 0, width: singleCellWidth * 2, height: singleCellWidth),
                      name: name)
        } else {
            self.init(frame: CGRect(x: 0, y: 0, width: singleCellWidth, height: singleCellWidth * 2),
                      name: name)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
