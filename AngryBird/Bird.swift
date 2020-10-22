//
//  Bird.swift
//  AngryBird
//
//  Created by yedi luo on 10/22/20.
//

import UIKit
import SpriteKit

enum BirdType: String  {
    case red, blue, yellow, gray
}

class Bird: SKSpriteNode {
    let birdType: BirdType
    var grabbed = false

    init(type: BirdType) {
        self.birdType = type
        var color: UIColor!
        switch type {
        case .red:
            color = .red
        case .blue:
            color = .blue
        case .yellow:
            color = .yellow
        case .gray:
            color = .gray
        default:
            color = UIColor.gray
        }
        super.init(texture: nil, color: color, size: CGSize(width: 40.0, height: 40.0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
