//
//  PaddleSystem.swift
//  swift-breakout
//
//  Created by Luke Godfrey on 8/13/14.
//  Copyright (c) 2014 Luke Godfrey. See LICENSE.
//

import LGSwiftEngine
import UIKit

class PaddleSystem: LGSystem
{
	let SIZE	= LGVector(x: 100, y: 20)
	let SPEED	= 4.0
	
	var position: LGPosition!
	var sprite: LGSprite!
	var body: LGPhysicsBody!
	var aimer: BallAimer!
	
	// MARK: LGSystem Overrides
	
	override func initialize()
	{
		createPaddle()
	}
	
	// MARK: PaddleSystem Functions
	
	func createPaddle()
	{
		position	= LGPosition(x: 100, y: 20)
		sprite		= LGSprite(red: 0, green: 1, blue: 0, size: SIZE)
		body		= LGPhysicsBody(size: SIZE, dynamic: false)
		aimer		= BallAimer()
		
		let paddle = LGEntity( position, sprite, body, aimer )
		scene.addEntity(paddle)
	}
}

extension PaddleSystem: LGTouchObserver
{
	func touchesBegan(touches: NSSet!, withEvent event: UIEvent!)
	{
		if let touch = touches.anyObject() as? UITouch
		{
			body.velocity.x = touch.locationInView(scene.view).x > scene.view.frame.size.width / 2 ? SPEED : -SPEED
		}
	}
	
	func touchesMoved(touches: NSSet!, withEvent event: UIEvent!) {}
	
	func touchesEnded(touches: NSSet!, withEvent event: UIEvent!)
	{
		if event.allTouches()!.count - touches.count == 0
		{
			body.velocity.x = 0
		}
	}
}
