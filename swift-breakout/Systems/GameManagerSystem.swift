//
//  GameManagerSystem.swift
//  swift-breakout
//
//  Created by Luke Godfrey on 8/13/14.
//  Copyright (c) 2014 Luke Godfrey. See LICENSE.
//

import LGSwiftEngine

class GameManagerSystem: LGSystem
{
	var gameState: GameState!
	
	// MARK: LGSystem Overrides
	
	override func initialize()
	{
		createGameState()
	}
	
	override func update()
	{
		checkGameOverConditions()
	}
	
	// MARK: GameManagerSystem Functions
	
	func createGameState()
	{
		// TODO: move this somewhere that will be called before initialize()
		gameState = GameState()
		scene.addEntity( LGEntity(gameState) )
	}
	
	func checkGameOverConditions()
	{
		if !gameState.gameOver
		{
			if gameState.balls == 0
			{
				println("You lose!")
				gameState.gameOver = true
			}
			else if gameState.bricks == 0
			{
				println("You win!")
				gameState.gameOver = true
			}
		}
	}
}
