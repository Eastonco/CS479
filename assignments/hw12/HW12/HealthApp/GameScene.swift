//
//  GameScene.swift
//  HealthApp
//
//  Created by Connor Easton on 4/20/21.
//

import SpriteKit
import GameplayKit


class GameScene: SKScene, SKPhysicsContactDelegate {
    
    private var scoreLabel : SKLabelNode!
    var timer: Timer!
    var score = 0

    
    override func didMove(to view: SKView) {
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsWorld.contactDelegate = self
        self.physicsBody?.categoryBitMask = 0b0100
        self.physicsBody?.collisionBitMask = 0b0111
        self.physicsBody?.contactTestBitMask = 0b0000
        
        Timer.scheduledTimer(withTimeInterval: 3, repeats: true, block: spawnRona)
        
        scoreLabel = SKLabelNode()
        scoreLabel.text = "Score: 0"
        scoreLabel.position = CGPoint(x:0, y:-639)
    }
    
    func spawnRona(_ timer: Timer){
        var rona = SKSpriteNode(imageNamed: "coronavirus.png")
        rona.name = "Rona"
        rona.physicsBody = SKPhysicsBody(circleOfRadius: rona.frame.size.width/2.0)
        rona.physicsBody?.affectedByGravity = false
        rona.physicsBody?.friction = 0.0
        rona.physicsBody?.restitution = 1.0
        rona.physicsBody?.linearDamping = 0.0
        rona.physicsBody?.categoryBitMask = 0b0001
        rona.physicsBody?.collisionBitMask = 0b0111
        rona.physicsBody?.contactTestBitMask = 0b0001
        
        let width = Int(self.frame.width)
        let height = Int(self.frame.height)
        
        let px = (Int.random(in: 0..<width) - width/2)
        let py = (Int.random(in: 0..<height) - height/2)
        rona.position = CGPoint(x:px, y:py)
        
        self.addChild(rona)

        
        let dx = CGFloat(Int.random(in: -200...200))
        let dy = CGFloat(Int.random(in: -200...200))
        
        rona.physicsBody?.applyImpulse(CGVector(dx:dx, dy:dy))
        

    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let point = touch.location(in: self)
            var newrocket = SKSpriteNode(imageNamed: "rocket.png")
            newrocket.name = "Rocket"
            newrocket.physicsBody = SKPhysicsBody(circleOfRadius: newrocket.frame.size.width / 2.0)
            newrocket.physicsBody?.affectedByGravity = false
            newrocket.physicsBody?.friction = 0.0
            newrocket.physicsBody?.restitution = 0.0
            newrocket.physicsBody?.linearDamping = 0.0
            newrocket.position = CGPoint(x:point.x, y:-639)
            newrocket.physicsBody?.velocity = CGVector(dx: 0.0, dy: 200.0)
            newrocket.physicsBody?.categoryBitMask = 0b001
            newrocket.physicsBody?.collisionBitMask = 0b0000
            newrocket.physicsBody?.contactTestBitMask = 0b0010
            self.addChild(newrocket)
        }
    }
    
    func incrementScore(){
        score += 1
        scoreLabel.text = "Score: \(score)"
    }
    
    func didBegin(_ contact:SKPhysicsContact) {
        let nodeA = contact.bodyA.node!
        let nodeB = contact.bodyB.node!
        if nodeA.name != nodeB.name{
            print("Contact: \(nodeA.name ?? "?") with \(nodeB.name ?? "?")")
            incrementScore()
            nodeA.removeFromParent()
            nodeB.removeFromParent()
        }
        
    }
    
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
