//
//  GameState.swift
//  swift-breakout
//
//  Created by Luke Godfrey on 8/13/14.
//  Copyright (c) 2014 Luke Godfrey. See LICENSE.
//

import LGSwiftEngine

class GameState: LGComponent
{
	class func type() -> String
	{
		return "GameState"
	}
	
	func type() -> String
	{
		return GameState.type()
	}
	
	var bricks		= 0
	var balls		= 0
	var score		= 0
	var gameOver	= false
}
