//
//  BrickSystem.swift
//  swift-breakout
//
//  Created by Luke Godfrey on 8/13/14.
//  Copyright (c) 2014 Luke Godfrey. See LICENSE.
//

import LGSwiftEngine

class BrickSystem: LGSystem
{
	let SIZE	= LGVector(x: 50, y: 20)
	let PADDING	= LGVector(x: 5, y: 5)
	
	let rows: Int
	let cols: Int
	var origin: LGVector!
	
	var gameState: GameState!
	
	// MARK: LGSystem Overrides
	
	init(rows: Int, cols: Int)
	{
		self.rows = rows
		self.cols = cols
		
		super.init()
		updatePhase = .None
	}
	
	override func initialize()
	{
		// TODO: Don't make this method depend on GameManagerSystem.initialize...
		gameState = scene.entityNamed("gameState")?.get(GameState)
		
		let originX = Double(scene.view.frame.size.width) / 2 - (SIZE.x + PADDING.x) * Double(cols) / 2
		let originY = Double(scene.view.frame.size.height) - (SIZE.y + PADDING.y) * Double(rows) - 40
		
		origin = LGVector(x: originX, y: originY)
		
		for row in 0 ..< rows
		{
			for col in 0 ..< cols
			{
				createBrick(row: row, col: col)
			}
		}
	}
	
	override func accepts(entity: LGEntity) -> Bool
	{
		return entity.has(Brick)
	}
	
	override func add(entity: LGEntity)
	{
		super.add(entity)
		gameState?.bricks++
	}
	
	override func remove(index: Int)
	{
		brickRemoved(entities[index])
		super.remove(index)
	}
	
	// MARK: BrickSystem Functions
	
	func createBrick(#row: Int, col: Int)
	{
		let x = origin.x + Double(col) * (SIZE.x + PADDING.x)
		let y = origin.y + Double(row) * (SIZE.y + PADDING.y)
		
		let body = LGPhysicsBody(width: SIZE.x, height: SIZE.y, dynamic: false)
		body.didCollide = { entity, other in self.brickCollided(entity) }
		
		let brick = LGEntity(
			body,
			LGPosition(x: x, y: y),
			LGSprite(red: 0, green: 0, blue: 1, size: SIZE),
			Brick(),
			Damageable()
		)
		
		scene.addEntity(brick)
	}
	
	// MARK: Event Handlers
	
	func brickCollided(brick: LGEntity)
	{
		brick.get(Damageable)!.health--
	}
	
	func brickRemoved(brick: LGEntity)
	{
		gameState?.bricks--
		gameState?.score++
		
		let sound = LGEntity(LGSound(name: "break.wav"))
		scene.addEntity(sound)
	}
}
