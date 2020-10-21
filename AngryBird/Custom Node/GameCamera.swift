//
//  GameCamera.swift
//  AngryBird
//
//  Created by yedi luo on 10/17/20.
//

import UIKit
import SpriteKit

class GameCamera: SKCameraNode {
    func setConstraints(with scene:SKScene, and frame:CGRect, to node: SKNode?) {
        let scaledSize = CGSize(width: scene.size.width * xScale, height: scene.size.height * yScale)
        let boardContentRect = frame
        
        let xInset = min((scaledSize.width/2),boardContentRect.width/2)
        let yInset = min((scaledSize.height/2),boardContentRect.height/2)
        print("SSW/2:\(scaledSize.width/2)  SSH/2:\(scaledSize.height/2)  ")
        // using the xInset and yInset as constraint, use centerpoint of BoardContentRect to create new rect
        let insetContentRect = boardContentRect.insetBy(dx: xInset, dy: yInset)
        print("equation:\(insetContentRect.maxY - insetContentRect.minY)    orginalBoardContentRectHeight:\(boardContentRect.height)  Oheight-2*Yinset:\(boardContentRect.height-2*yInset)   yInset: \(yInset)")
        print("equation:\(insetContentRect.maxX - insetContentRect.minX)    orginalBoardContentRectWidth:\(boardContentRect.width)     xInset: \(xInset)")

        let xRange = SKRange(lowerLimit: insetContentRect.minX, upperLimit: insetContentRect.maxX)
        let yRange = SKRange(lowerLimit: insetContentRect.minY, upperLimit: insetContentRect.maxY)
        let levelEdgeConstraint = SKConstraint.positionX(xRange, y: yRange)
        constraints = [levelEdgeConstraint]
    }
}
