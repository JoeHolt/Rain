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
    
    private var screenSize: CGSize!             /** Size of screen */
    private let length: CGFloat = 15.0          /** Length of drop */
    private let width: CGFloat = 2.0            /** Width of drop */
    private let color: NSColor = NSColor.blue   /** Color of drop */
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
        
        // Make path (Make it a line)
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 0.0, y: 0.0))
        path.addLine(to: CGPoint(x: 0.0, y: length))
        self.path = path
        
        //General set up color, size and posistion
        dropSpeed = CGFloat(arc4random_uniform(4) + 2)
        acceleration = CGFloat(drand48())/70.0
        screenSize = bounds
        strokeColor = color
        lineWidth = width
        let randomX = CGFloat(arc4random_uniform(UInt32(screenSize.width))) - widthBound
        let randomY = heightBound + CGFloat(arc4random_uniform(UInt32(screenSize.height)))
        position = CGPoint(x: randomX, y: randomY)
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
    
    
}
