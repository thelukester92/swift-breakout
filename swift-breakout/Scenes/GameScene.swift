//
//  GameScene.swift
//  swift-breakout
//
//  Created by Luke Godfrey on 9/13/14.
//  Copyright (c) 2014 Luke Godfrey. See LICENSE.
//

import LGSwiftEngine

class GameScene: LGScene
{
	override func initialize()
	{
		// TODO: make order not important... right now, BallSystem.initialize depends on GameManagerSystem.initialize
		addSystems(
			GameManagerSystem(),
			LGSoundSystem(),
			LGPhysicsSystem(gravity: LGVector(x: 0, y: 0)),
			LGRenderingSystem(),
			BrickSystem(rows: 4, cols: 8),
			BallSystem(),
			PaddleSystem(),
			DamageSystem()
		)
	}
}
