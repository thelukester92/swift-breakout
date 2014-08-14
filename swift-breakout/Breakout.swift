//
//  Breakout.swift
//  swift-breakout
//
//  Created by Luke Godfrey on 8/13/14.
//  Copyright (c) 2014 Luke Godfrey. See LICENSE.
//

import LGSwiftEngine

class Breakout: LGGame
{
	// TODO: rename "addSystems" to "initialize" and remove "addEntities" completely
	override func addSystems(scene: LGScene)
	{
		scene.addSystems(
			LGPhysicsSystem(gravity: LGVector(x: 0, y: 0)),
			LGRenderingSystem(),
			BrickSystem(rows: 4, cols: 8),
			BallSystem(),
			PaddleSystem(),
			DamageSystem()
			// GameManagerSystem()
		)
	}
}
