//
//  Configurations.swift
//  AngryBird
//
//  Created by yedi luo on 10/20/20.
//

import Foundation
import CoreGraphics

//allows CGPoint * CGFloat
extension CGPoint {
    static public func * (left: CGPoint, right: CGFloat) -> CGPoint {
        return CGPoint(x: left.x * right, y: left.y*right)
    }
    
}
