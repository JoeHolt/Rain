//
//  GameScene.swift
//  Rain
//
//  Created by Joe Holt on 10/1/17.
//  Copyright © 2017 Joe Holt. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var numberOfDrops: Int = 1000
    private var rainDrops: [RainDrop]!
    
    override func didMove(to view: SKView) {
        
        backgroundColor = NSColor.black
        
        rainDrops = []
        for _ in 0..<numberOfDrops {
            let drop = RainDrop(bounds: self.size)
            rainDrops.append(drop)
            addChild(drop)
        }
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        for drop in rainDrops {
            drop.fall()
        }
    }
}
