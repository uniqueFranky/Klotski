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
    weak var controller: PersonController?
    init(frame: CGRect, name: String, controller: PersonController?) {
        imageView = UIImageView(frame: frame)
        imageView.image = UIImage(named: name)
        imageView.contentMode = .scaleAspectFill
        self.controller = controller
        super.init(frame: frame)
        addSubview(imageView)
    }
    
    convenience init(name: String, controller: PersonController?) {
        if name == "soldier" {
            self.init(frame: CGRect(x: 0, y: 0, width: singleCellWidth, height: singleCellWidth),
                      name: name, controller: controller)
        } else if name == "caoCao" {
            self.init(frame: CGRect(x: 0, y: 0, width: singleCellWidth * 2, height: singleCellWidth * 2),
                      name: name, controller: controller)
        } else if name == "guanYu" {
            self.init(frame: CGRect(x: 0, y: 0, width: singleCellWidth * 2, height: singleCellWidth),
                      name: name, controller: controller)
        } else {
            self.init(frame: CGRect(x: 0, y: 0, width: singleCellWidth, height: singleCellWidth * 2),
                      name: name, controller: controller)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        print(touches.first?.location(in: superview))

    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        print(touches.first?.location(in: superview))
    }
    
}
