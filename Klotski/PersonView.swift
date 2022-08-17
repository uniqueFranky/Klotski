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
        imageView.contentMode = .scaleToFill
        self.controller = controller
        super.init(frame: frame)
        addSubview(imageView)
    }
    
    convenience init(name: String, controller: PersonController?) {
        guard let config = personConfigs[name] else {
            fatalError("unexpected personName \(name)")
        }
        let rect = CGRect(x: 0, y: 0,
                          width: CGFloat(config.size.width) * singleCellWidth,
                          height: CGFloat(config.size.height) * singleCellWidth)
        self.init(frame: rect, name: name, controller: controller)
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
