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
    var pinchRecognizer = UIPinchGestureRecognizer()
    var maxScale:CGFloat = 0.0
    
    var bird = Bird(type: .red)
    let anchor = SKNode()
    
    
    override func didMove(to view: SKView) {
        //addCamera()
        setupLevel()
        setupGestureRecognizer()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            // check if the touch is on the spritenode or not
            if bird.contains(location) {
                panRecognizer.isEnabled = false
                bird.grabbed = true
                bird.position = location
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if bird.grabbed {
                let location = touch.location(in: self)
                bird.position = location
            }
            
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if bird.grabbed {
            bird.grabbed = false
            launchBird()
        }
    }
    
    func launchBird() {
        
    }
    func setupLevel() {
        if let safeMapNode = childNode(withName: "Tile Map Node") as? SKTileMapNode {
            self.mapNode = safeMapNode
            maxScale = safeMapNode.mapSize.width/frame.size.width
        }
        addCamera()
        anchor.position = CGPoint(x: mapNode.frame.midX/2, y: mapNode.frame.midY/2)
        addChild(anchor)
        addBird()
    }
    
    func addBird() {
        bird.position = anchor.position
        addChild(bird)
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

        pinchRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(pinch))
        view.addGestureRecognizer(pinchRecognizer)
    }
    
}
//MARK: - UIgestureRecognizer
extension GameScene {
    @objc func pan(sender:UIPanGestureRecognizer) {
        guard let view = view else {
            return
        }
        //pan movement amount
        let translation = sender.translation(in: view) * gameCamera.yScale
        print("x:\(translation.x) + y:\(translation.y)")
        print("gameCamera.x:\(gameCamera.position.x)+gameCamera.y\(gameCamera.position.y)")
        gameCamera.position = CGPoint(x: gameCamera.position.x - translation.x, y: gameCamera.position.y + translation.y)
        
        sender.setTranslation(CGPoint.zero, in: view)
    }

    @objc func pinch(sender:UIPinchGestureRecognizer) {
        guard let view = view else {
            return
        }
        
        if sender.numberOfTouches == 2 {
            if sender.state == .changed {
                let locationInView = sender.location(in: view)
                let location = convertPoint(fromView: locationInView)
                let convertedScale = 1/sender.scale
                //x or yscale both works,doesnt matter
                let newScale = gameCamera.yScale * convertedScale
                
                if newScale < maxScale && newScale > 0.5 {
                    gameCamera.setScale(newScale)
                }
                let locationAfterScale = convertPoint(fromView: locationInView)
                
                
               // let locationDelta = CGPoint(x: location.x - locationAfterScale.x, y: location.y - locationAfterScale.y)
                
                let locationDelta = location - locationAfterScale
                
                // new position for camera. after zoom and pinch
                //let newPosition = CGPoint(x: gameCamera.position.x+locationDelta.x , y: gameCamera.position.y+locationDelta.y)
                
                let newPosition = gameCamera.position + locationDelta
                gameCamera.position = newPosition
                //next pinch will use base scale = 1 again
                sender.scale = 1.0
                gameCamera.setConstraints(with: self, and: mapNode.frame, to: nil)
            }
        }
    }
}
