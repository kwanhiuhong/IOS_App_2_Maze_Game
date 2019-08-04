//
//  GameScene.swift
//  Maze
//
//  Created by KHH on 4/8/2019.
//  Copyright © 2019 Kwan Hiu Hong. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion
//CoreMotion framework holds your accelerometer and your gyroscope that are already built into your IPhone and from there, you can grab the data from that and use it to change the scene according to how much the phone is tilted

//SKPhysicsContactDelegate will allow us to take the game scene and delegate to everything that happens physics-contact-wise
class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let manager = CMMotionManager()
    var player = SKSpriteNode()
    var endNode = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        player = self.childNode(withName: "player") as! SKSpriteNode
        endNode = self.childNode(withName: "endNode") as! SKSpriteNode
        
        manager.startAccelerometerUpdates()
        //we are starting the accelerometer we are grabing and we are gonna grab the data from that and use it
        manager.accelerometerUpdateInterval = 0.1
        //every tenth of a second it's gonna grab the data that's coming from the device
        manager.startAccelerometerUpdates(to: OperationQueue.main){
            (data, error) in
            
            self.physicsWorld.gravity = CGVector(dx: CGFloat((data?.acceleration.x)!) * 10, dy: CGFloat((data?.acceleration.y)!) * 10)
        }
        //This is all the code you need to move your objects
    }
    func didBegin(_ contact: SKPhysicsContact) {
        let bodyA = contact.bodyA
        let bodyB = contact.bodyB
        
        if (bodyA.categoryBitMask == 1 && bodyB.categoryBitMask == 2) || (bodyA.categoryBitMask == 2 && bodyB.categoryBitMask == 1){
            //Game Ends
            print ("Congratulations! You won!")
            let alert = UIAlertController(title: "Congratulations! You won!", message: "Would like to play again?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {action in self.reset()}))
            
            view?.window?.rootViewController?.present(alert, animated: true)
        }
    }
    
    @objc func reset(){
        print ("I am in")
        let moveAction = SKAction.move(to: CGPoint(x: 0, y:0), duration: 0)
        player.run(moveAction)
    }
    
    override func update(_ currentTime: TimeInterval) {
    }
}


//       self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
//if let label = self.label {
//    label.alpha = 0.0
//    label.run(SKAction.fadeIn(withDuration: 2.0))
//}
//
//// Create shape node to use during mouse interaction
//let w = (self.size.width + self.size.height) * 0.05
//self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
//
//if let spinnyNode = self.spinnyNode {
//    spinnyNode.lineWidth = 2.5
//
//    spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
//    spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
//                                      SKAction.fadeOut(withDuration: 0.5),
//                                      SKAction.removeFromParent()]))
//}
//
//    func touchDown(atPoint pos : CGPoint) {
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.green
//            self.addChild(n)
//        }
//    }
//
//    func touchMoved(toPoint pos : CGPoint) {
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.blue
//            self.addChild(n)
//        }
//    }
//
//    func touchUp(atPoint pos : CGPoint) {
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.red
//            self.addChild(n)
//        }
//    }
//
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if let label = self.label {
//            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
//        }
//
//        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
//    }
//
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
//    }
//
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
//    }
//
//    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
//    }
//
