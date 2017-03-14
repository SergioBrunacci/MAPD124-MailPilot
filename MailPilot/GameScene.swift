//
//  GameScene.swift
//  MailPilot
//
//  Created by Tom Tsiliopoulos on 2017-03-13.
//  Copyright © 2017 Tom Tsiliopoulos. All rights reserved.
//

import SpriteKit
import GameplayKit

let screenSize = UIScreen.main.bounds
var screenWidth:CGFloat?
var screenHeight:CGFloat?


class GameScene: SKScene {

    var oceanSprite:Ocean?
    var islandSprite:Island?
    var planeSprite:Plane?
    var cloudSprites: [Cloud] = []
    var scoreboard:ScoreManager?
    
    public static var Lives:Int = 5
    
    override func didMove(to view: SKView) {
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        
        // add ocean
        oceanSprite = Ocean()
        self.addChild(oceanSprite!)
        
        // add island
        islandSprite = Island()
        self.addChild(islandSprite!)
        
        // add plane
        planeSprite = Plane()
        self.addChild(planeSprite!)
        
        // add three clouds
        for index in 0...2 {
            let cloud: Cloud = Cloud()
            cloudSprites.append(cloud)
            self.addChild(cloudSprites[index])
        }
        
        scoreboard = ScoreManager()
        
    }
    
    func touchDown(atPoint pos : CGPoint) {
        planeSprite?.TouchMove(newPos: CGPoint(x: pos.x, y: 50))
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        planeSprite?.TouchMove(newPos: CGPoint(x: pos.x, y: 50))
    }
    
    func touchUp(atPoint pos : CGPoint) {
        planeSprite?.TouchMove(newPos: CGPoint(x: pos.x, y: 50))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        oceanSprite?.Update()
        islandSprite?.Update()
        planeSprite?.Update()
        CollisionManager.CheckCollision(object1: planeSprite!, object2: islandSprite!, scoreboard: self.scoreboard!)
        
        for cloud in cloudSprites {
            cloud.Update()
            CollisionManager.CheckCollision(object1: planeSprite!, object2: cloud, scoreboard: self.scoreboard!)
        }
        
        
    }
}
