//
//  GameScene.swift
//  AngryBird
//
//  Created by yedi luo on 10/17/20.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var mapNode = SKTileMapNode()
    
    let gameCamera = GameCamera()
    var panRecognizer = UIPanGestureRecognizer()
    override func didMove(to view: SKView) {
        //addCamera()
        setupLevel()
        setupGestureRecognizer()
    }
    
    func setupLevel() {
        if let safeMapNode = childNode(withName: "Tile Map Node") as? SKTileMapNode {
            self.mapNode = safeMapNode
        }
        addCamera()
    }
        
    func addCamera() {
        guard let view = view else {return}
        addChild(gameCamera)
        gameCamera.position = CGPoint(x: view.bounds.size.width/2, y: view.bounds.size.height/2)
        camera = gameCamera
        gameCamera.setConstraints(with: self, and: mapNode.frame, to: nil)
    }
    
    func setupGestureRecognizer() {
        guard let view = view else {return}
        panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(pan))
       // panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(pan))
        view.addGestureRecognizer(panRecognizer)
        
    }
    
}
//MARK: - UIgestureRecognizer
extension GameScene {
    @objc func pan(sender:UIPanGestureRecognizer) {
        guard let view = view else {
            return
        }
        //pan movement amount
        let translation = sender.translation(in: view)
        print("x:\(translation.x) + y:\(translation.y)")
        print("gameCamera.x:\(gameCamera.position.x)+gameCamera.y\(gameCamera.position.y)")
        gameCamera.position = CGPoint(x: gameCamera.position.x - translation.x, y: gameCamera.position.y + translation.y)
        
        sender.setTranslation(CGPoint.zero, in: view)
    }
}
