//
//  Breakout.swift
//  swift-breakout
//
//  Created by Luke Godfrey on 8/13/14.
//  Copyright (c) 2014 Luke Godfrey. See LICENSE.
//

import UIKit
import LGSwiftEngine

class Breakout: LGGame
{
	// TODO: rename "addSystems" to "initialize" and remove "addEntities" completely
	override func addSystems(scene: LGScene)
	{
		// TODO: make order not important... right now, BallSystem.initialize depends on GameManagerSystem.initialize
		scene.addSystems(
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
	
	// MARK: UIViewController Overrides
	
	override func supportedInterfaceOrientations() -> Int
	{
		if UIDevice.currentDevice().userInterfaceIdiom == .Phone
		{
			return Int(UIInterfaceOrientationMask.AllButUpsideDown.toRaw())
		}
		else
		{
			return Int(UIInterfaceOrientationMask.All.toRaw())
		}
	}
}
