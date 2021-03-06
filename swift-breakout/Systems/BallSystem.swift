//
//  BallSystem.swift
//  swift-breakout
//
//  Created by Luke Godfrey on 8/13/14.
//  Copyright (c) 2014 Luke Godfrey. See LICENSE.
//

import LGSwiftEngine
import Foundation

// TODO: the whole problem is that entity types aren't lining up with accepts
// the problem is that the system is no longer alerted when the entity is removed

class BallSystem: LGSystem
{
	let SIZE			= LGVector(x: 20, y: 20)
	let START_POSITION	= LGVector(x: 40, y: 100)
	let START_VELOCITY	= LGVector(x: 2, y: -2)
	
	var positions	= [LGPosition]()
	var bodies		= [LGPhysicsBody]()
	var velocities	= [LGVector]()
	
	var gameState: GameState!
	
	// MARK: LGSystem Overrides
	
	override func initialize()
	{
		// TODO: Don't make this method depend on GameManagerSystem.initialize...
		gameState = scene.entityNamed("gameState")?.get(GameState)
		
		createBall(x: START_POSITION.x, y: START_POSITION.y)
	}
	
	override func accepts(entity: LGEntity) -> Bool
	{
		return entity.has(Ball) && entity.has(LGPosition) && entity.has(LGPhysicsBody)
	}
	
	override func add(entity: LGEntity)
	{
		super.add(entity)
		
		positions.append(entity.get(LGPosition)!)
		bodies.append(entity.get(LGPhysicsBody)!)
		velocities.append(LGVector())
		
		gameState?.balls++
	}
	
	override func remove(index: Int)
	{
		ballRemoved(entities[index])
		super.remove(index)
		
		positions.removeAtIndex(index)
		bodies.removeAtIndex(index)
		velocities.removeAtIndex(index)
	}
	
	override func update()
	{
		for i in 0 ..< entities.count
		{
			checkBounds(i)
			updateVelocity(i)
		}
	}
	
	// MARK: BallSystem Functions
	
	func createBall(#x: Double, y: Double, velocity: LGVector)
	{
		let body = LGPhysicsBody(size: SIZE)
		body.didCollide = { self.ballCollided($0, withEntity: $1) }
		body.velocity = LGVector(x: velocity.x, y: velocity.y)
		
		let ball = LGEntity(
			body,
			LGPosition(x: x, y: y),
			LGSprite(red: 1, green: 1, blue: 0, size: SIZE),
			Ball()
		)
		
		scene.addEntity(ball)
	}
	
	func createBall(#x: Double, y: Double)
	{
		createBall(x: x, y: y, velocity: START_VELOCITY)
	}
	
	func checkBounds(id: Int)
	{
		if positions[id].x < 1
		{
			positions[id].x = 1
			bodies[id].collidedLeft = true
			bounce(id)
		}
		else if positions[id].x + bodies[id].width + 1 > Double(scene.view.frame.size.width)
		{
			positions[id].x = Double(scene.view.frame.size.width) - bodies[id].width - 1
			bodies[id].collidedRight = true
			bounce(id)
		}
		
		if positions[id].y + bodies[id].height + 1 > Double(scene.view.frame.size.height)
		{
			positions[id].y = Double(scene.view.frame.size.height) - bodies[id].height - 1
			bodies[id].collidedTop = true
			bounce(id)
		}
		else if positions[id].y + bodies[id].height < 0
		{
			scene.removeEntity(entities[id])
		}
	}
	
	func updateVelocity(id: Int)
	{
		velocities[id].x = bodies[id].velocity.x
		velocities[id].y = bodies[id].velocity.y
	}
	
	// MARK: Event Handlers
	
	func ballCollided(ball: LGEntity, withEntity entity: LGEntity?)
	{
		if let id = entityIndex(ball)
		{
			bounce(id, entity: entity)
			
			let sound = LGEntity(LGSound(name: "bounce.wav"))
			scene.addEntity(sound)
		}
	}
	
	func ballRemoved(ball: LGEntity)
	{
		gameState?.balls--
	}
	
	func bounce(id: Int, entity: LGEntity? = nil)
	{
		// Bounce on the y-axis
		
		if bodies[id].collidedTop
		{
			bodies[id].velocity.y = min(0, -velocities[id].y)
		}
		else if bodies[id].collidedBottom
		{
			bodies[id].velocity.y = max(0, -velocities[id].y)
		}
		
		// Bounce on the x-axis
		
		if bodies[id].collidedLeft
		{
			bodies[id].velocity.x = max(0, -velocities[id].x)
		}
		else if bodies[id].collidedRight
		{
			bodies[id].velocity.x = min(0, -velocities[id].x)
		}
		else if let aimer = entity?.get(BallAimer)
		{
			// Aim the ball based on where it collided
			
			let aimerX			= entity!.get(LGPosition)!.x
			let aimerWidth		= entity!.get(LGPhysicsBody)!.width
			
			let ballHalfWidth	= bodies[id].width / 2
			let ballCenterX		= positions[id].x + ballHalfWidth
			
			let interpolation	= (ballCenterX - aimerX) / aimerWidth
			
			var regionPosition	= interpolation * Double(aimer.deltas.count)
			regionPosition		= max(regionPosition, 0)
			regionPosition		= min(regionPosition, Double(aimer.deltas.count) - 1)
			
			bodies[id].velocity.x += aimer.deltas[Int(regionPosition)]
		}
	}
	
	// MARK: Helper Functions
	
	func entityIndex(entity: LGEntity) -> Int?
	{
		for i in 0 ..< entities.count
		{
			if entities[i] === entity
			{
				return i
			}
		}
		
		return nil
	}
}
