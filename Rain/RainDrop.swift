//
//  RainDrop.swift
//  Rain
//
//  Created by Joe Holt on 10/1/17.
//  Copyright © 2017 Joe Holt. All rights reserved.
//

import Cocoa
import SpriteKit

class RainDrop: SKShapeNode {
    
    private let length: CGFloat = 15.0          /** Length of drop */
    private let width: CGFloat = 2.0            /** Width of drop */
    private let color: NSColor = NSColor.green  /** Color of drop */
    private var z: Int!                         /** How close or far the object is, larger = closer */
    private var screenSize: CGSize!             /** Size of screen */
    private var dropSpeed: CGFloat!             /** Speed of the water drop */
    private var acceleration: CGFloat!          /** Rate of increase of fall */
    private var heightBound: CGFloat {          /** up and down bound */
        return screenSize.height/2
    }
    private var widthBound: CGFloat {           /** Left and right bound */
        return screenSize.width/2
    }
    
    init(bounds: CGSize) {
        super.init()
        //Set the z with more in back than in front
        //If a prticle is in the front it should be bigger and move faster
        if drand48() > 0.8 {
            z = Int(arc4random_uniform(5) + 1) + 10
        } else {
            z = Int(arc4random_uniform(5) + 1)
        }
        // Mapped values
        screenSize = bounds
        let mappedSpeed = map(value: CGFloat(z), min: 1, max: 15, newMin: 2, newMax: 6)
        let mappedAcceleration = map(value: CGFloat(z), min: 1, max: 15, newMin: 0, newMax: 0.06)
        let mappedWidth = map(value: CGFloat(z), min: 1, max: 15, newMin: 1, newMax: 4)
        let randomX = CGFloat(arc4random_uniform(UInt32(screenSize.width))) - widthBound
        let randomY = heightBound + CGFloat(arc4random_uniform(UInt32(screenSize.height)))
        //General set up color, size and posistion
        dropSpeed = mappedSpeed
        acceleration = mappedAcceleration
        lineWidth = mappedWidth
        strokeColor = color
        position = CGPoint(x: randomX, y: randomY)
        
        // Make path (Make it a line)
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 0.0, y: 0.0))
        path.addLine(to: CGPoint(x: 0.0, y: length))
        self.path = path
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func fall() {
        dropSpeed = dropSpeed + acceleration
        position.y -= dropSpeed
        
        if position.y < -heightBound {
            dropSpeed = CGFloat(arc4random_uniform(4) + 2)
            position.y = heightBound
        }
    }
    
    /** Maps a value in a range to a new range */
    private func map(value: CGFloat, min: CGFloat, max: CGFloat, newMin: CGFloat, newMax: CGFloat) -> CGFloat {
        let old = max-min
        let new = newMax-newMin
        let scale = new/old
        return (value * scale)
    }
    
    
}
